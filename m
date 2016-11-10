From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 1/2] plugin: dynamically update avail_min on
	slave
Date: Thu, 10 Nov 2016 16:34:42 +0900
Message-ID: <20161110073443.1192-2-jiada_wang@mentor.com>
References: <20161110073443.1192-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id D54A9266670
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 08:34:43 +0100 (CET)
In-Reply-To: <20161110073443.1192-1-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, wens@csie.org
Cc: jiada_wang@mentor.com, alsa-devel@alsa-project.org, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

mmapped capture access on some plugins can fetch data from slave in the 'background'.
A subsequent snd_pcm_wait waits for too long time to reach avail_min threshold again.
Waiting too long leads to xruns on other devices waiting for the capture data.

As a fix the avail_min on slave is recalculated dynamically.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 src/pcm/pcm_plugin.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index e53c5bb..c78316b 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -535,6 +535,52 @@ static int snd_pcm_plugin_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 	return 0;
 }
 
+static int snd_pcm_plugin_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail)
+{
+	if (pcm->stream == SND_PCM_STREAM_CAPTURE &&
+	    pcm->access != SND_PCM_ACCESS_RW_INTERLEAVED &&
+	    pcm->access != SND_PCM_ACCESS_RW_NONINTERLEAVED) {
+		/* mmap access on capture device already consumes data from slave in avail_update operation (@see snd_pcm_plugin_avail_update).
+		  Entering snd_pcm_wait after having already consumed some fragments leads to waiting for too long time,
+		  as slave will unnecessarily wait for avail_min condition reached again.
+		  To avoid unnecessary wait times we adapt the avail_min threshold on slave dynamically.
+		  Just modifying slave->avail_min as a shortcut and lightweight solution does not work for all slave plugin types
+		  and in addition it will not propagate the change through all downstream plugins, so we have to use the sw_params API.
+		  note: reading fragmental parts from slave will only happen in case
+			a) the slave can provide contineous hw_ptr between periods
+			b) avail_min does not match one slave_period
+		*/
+		snd_pcm_plugin_t *plugin = pcm->private_data;
+		snd_pcm_t *slave = plugin->gen.slave;
+		snd_pcm_uframes_t needed_slave_avail_min;
+		snd_pcm_sframes_t available;
+
+		/* update, as it might have changed. This will also call avail_update on slave and also can return error*/
+		available = snd_pcm_avail_update(pcm);
+		if (available < 0)
+			return 0;
+
+		if (available >= pcm->avail_min)
+			/*don't wait at all. As we can't configure avail_min of slave to 0 return here*/
+			return 0;
+
+		needed_slave_avail_min = pcm->avail_min - available;
+		if (slave->avail_min != needed_slave_avail_min) {
+			snd_pcm_sw_params_t *swparams;
+			snd_pcm_sw_params_alloca(&swparams);
+			/* pray that changing sw_params while running is properly implemented in all downstream plugins... it's legal but not commonly used.*/
+			snd_pcm_sw_params_current(slave, swparams);
+			/* snd_pcm_sw_params_set_avail_min() restricts setting to >= period size.
+			This conflicts at least with our dshare patch which allows combining multiple periods or with slaves which return hw postions between periods
+			-> set directly in sw_param structure */
+			swparams->avail_min = needed_slave_avail_min;
+			snd_pcm_sw_params(slave, swparams);
+		}
+		avail = available;
+	}
+	return snd_pcm_generic_may_wait_for_avail_min(pcm, avail);
+}
+
 const snd_pcm_fast_ops_t snd_pcm_plugin_fast_ops = {
 	.status = snd_pcm_plugin_status,
 	.state = snd_pcm_generic_state,
@@ -564,7 +610,7 @@ const snd_pcm_fast_ops_t snd_pcm_plugin_fast_ops = {
 	.poll_descriptors_count = snd_pcm_generic_poll_descriptors_count,
 	.poll_descriptors = snd_pcm_generic_poll_descriptors,
 	.poll_revents = snd_pcm_generic_poll_revents,
-	.may_wait_for_avail_min = snd_pcm_generic_may_wait_for_avail_min,
+	.may_wait_for_avail_min = snd_pcm_plugin_may_wait_for_avail_min,
 };
 
 #endif
-- 
2.9.3
