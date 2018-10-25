From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH v2 - AAF PCM plugin 6/7] aaf: Implement dump()
	ioplug callback
Date: Wed, 24 Oct 2018 18:11:15 -0700
Message-ID: <20181025011116.12360-7-andre.guedes@intel.com>
References: <20181025011116.12360-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 4885B267967
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2018 03:11:54 +0200 (CEST)
In-Reply-To: <20181025011116.12360-1-andre.guedes@intel.com>
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
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This patch introduces the aaf_dump() function which prints information
about both PCM and AVTP setup.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index 147e5b0..b022575 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -23,6 +23,7 @@
 #include <arpa/inet.h>
 #include <avtp.h>
 #include <avtp_aaf.h>
+#include <inttypes.h>
 #include <limits.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
@@ -964,6 +965,28 @@ static int aaf_close(snd_pcm_ioplug_t *io)
 	return 0;
 }
 
+static void aaf_dump(snd_pcm_ioplug_t *io, snd_output_t *out)
+{
+	snd_pcm_aaf_t *aaf = io->private_data;
+	snd_pcm_t *pcm = io->pcm;
+
+	snd_output_printf(out, "%s\n", io->name);
+	snd_output_printf(out, "PCM setup is:\n");
+	snd_pcm_dump_setup(pcm, out);
+	snd_output_printf(out, "AVTP setup is:\n");
+	snd_output_printf(out, "  ifname: %s\n", aaf->ifname);
+	snd_output_printf(out, "  macaddr: %.2X:%.2X:%.2X:%.2X:%.2X:%.2X\n",
+			  aaf->addr[0], aaf->addr[1], aaf->addr[2],
+			  aaf->addr[3], aaf->addr[4], aaf->addr[5]);
+	snd_output_printf(out, "  priority: %d\n", aaf->prio);
+	snd_output_printf(out, "  streamid: %"PRIX64"\n", aaf->streamid);
+	snd_output_printf(out, "  mtt: %d\n", aaf->mtt / NSEC_PER_USEC);
+	snd_output_printf(out, "  time uncertainty: %d\n",
+			  aaf->t_uncertainty / NSEC_PER_USEC);
+	snd_output_printf(out, "  frames per AVTPDU: %lu\n",
+			  aaf->frames_per_pdu);
+}
+
 static int aaf_hw_params(snd_pcm_ioplug_t *io,
 			 snd_pcm_hw_params_t *params ATTRIBUTE_UNUSED)
 {
@@ -1186,6 +1209,7 @@ static snd_pcm_sframes_t aaf_transfer(snd_pcm_ioplug_t *io,
 
 static const snd_pcm_ioplug_callback_t aaf_callback = {
 	.close = aaf_close,
+	.dump = aaf_dump,
 	.hw_params = aaf_hw_params,
 	.hw_free = aaf_hw_free,
 	.sw_params = aaf_sw_params,
-- 
2.14.4
