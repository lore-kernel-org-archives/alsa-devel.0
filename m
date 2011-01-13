From: Nitin Daga <ndaga@nvidia.com>
Subject: [PATCH] ALSA: hda: Disable odd numbered channels on
	HDMI controllers.
Date: Fri, 14 Jan 2011 01:49:47 +0530
Message-ID: <1294949987-11389-1-git-send-email-ndaga@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 35BF8103B06
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 21:20:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Added code in hda_intel.c to disable odd numbered channels
not supported by HDMI controllers.

Signed-off-by: Nitin Daga <ndaga@nvidia.com>
Acked-By: Stephen Warren <swarren@nvidia.com>
---
 pci/hda/hda_intel.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/pci/hda/hda_intel.c b/pci/hda/hda_intel.c
index a78ea34..293c685 100644
--- a/pci/hda/hda_intel.c
+++ b/pci/hda/hda_intel.c
@@ -1539,6 +1539,16 @@ struct azx_pcm {
 	struct hda_pcm_stream *hinfo[2];
 };
 
+static unsigned int channels_2_4_6_8[] = {
+	2, 4, 6, 8
+};
+
+static struct snd_pcm_hw_constraint_list hw_constraints_2_4_6_8_channels = {
+	.count = ARRAY_SIZE(channels_2_4_6_8),
+	.list = channels_2_4_6_8,
+	.mask = 0,
+};
+
 static int azx_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
@@ -1566,6 +1576,9 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 				   128);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				   128);
+	snd_pcm_hw_constraint_list(runtime, 0,
+				   SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &hw_constraints_2_4_6_8_channels);
 	snd_hda_power_up(apcm->codec);
 	err = hinfo->ops.open(hinfo, apcm->codec, substream);
 	if (err < 0) {
-- 
1.7.0.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
