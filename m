From: Tim Cussins <timcussins@eml.cc>
Subject: [PATCH] alsa-lib: Fix assorted tstamp_type
	bugs/omissions.
Date: Tue, 25 Nov 2014 14:44:54 +0000
Message-ID: <1416926694-25174-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 8A379265824
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 15:47:14 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id C399A20930
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 09:47:13 -0500 (EST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tim Cussins <timcussins@eml.cc>
List-Id: alsa-devel@alsa-project.org

Just a couple of quick fixes related to tstamp_type.

- snd_pcm_sw_params(): copy tstamp_type field
- snd_pcm_tstamp_type_name(): fix argument type
- snd_pcm_dump_sw_setup(): fix dumping of tstamp_type field

---
 src/pcm/pcm.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 3904256..baa47c7 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -897,6 +897,7 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
 	if (err < 0)
 		return err;
 	pcm->tstamp_mode = params->tstamp_mode;
+	pcm->tstamp_type = params->tstamp_type;
 	pcm->period_step = params->period_step;
 	pcm->avail_min = params->avail_min;
 	pcm->period_event = sw_get_period_event(params);
@@ -1843,7 +1844,7 @@ const char *snd_pcm_tstamp_mode_name(snd_pcm_tstamp_t mode)
  * \param mode PCM tstamp type
  * \return ascii name of PCM tstamp type setting
  */
-const char *snd_pcm_tstamp_type_name(snd_pcm_tstamp_t type)
+const char *snd_pcm_tstamp_type_name(snd_pcm_tstamp_type_t type)
 {
 	if (type > SND_PCM_TSTAMP_TYPE_LAST)
 		return NULL;
@@ -1924,7 +1925,7 @@ int snd_pcm_dump_sw_setup(snd_pcm_t *pcm, snd_output_t *out)
 		return -EIO;
 	}
 	snd_output_printf(out, "  tstamp_mode  : %s\n", snd_pcm_tstamp_mode_name(pcm->tstamp_mode));
-	snd_output_printf(out, "  tstamp_type  : %s\n", snd_pcm_tstamp_type_name(pcm->tstamp_mode));
+	snd_output_printf(out, "  tstamp_type  : %s\n", snd_pcm_tstamp_type_name(pcm->tstamp_type));
 	snd_output_printf(out, "  period_step  : %d\n", pcm->period_step);
 	snd_output_printf(out, "  avail_min    : %ld\n", pcm->avail_min);
 	snd_output_printf(out, "  period_event : %i\n", pcm->period_event);
-- 
1.7.10.4
