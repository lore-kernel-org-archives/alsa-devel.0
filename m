From: jeeja.kp@intel.com
Subject: [PATCH 27/30] ASoC: Intel: Skylake: Add jack port
	initialize in skl_nau88l25_ssm4567 machine
Date: Mon, 16 Jan 2017 23:27:54 +0530
Message-ID: <1484589477-7630-28-git-send-email-jeeja.kp@intel.com>
References: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 447FC2668B3
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 18:48:59 +0100 (CET)
In-Reply-To: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

After the pcm jack is created, create and initialize the pin switch
widget for each port. Pin switch is to enable/disable the pin when
monitor is connected/disconnected.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 5deb68f..eb7751b 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -136,9 +136,6 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{"MIC", NULL, "Headset Mic"},
 	{"DMic", NULL, "SoC DMIC"},
 
-	{"DP1", NULL, "hif5-0 Output"},
-	{"DP2", NULL, "hif6-0 Output"},
-
 	/* CODEC BE connections */
 	{ "Left Playback", NULL, "ssp0 Tx"},
 	{ "Right Playback", NULL, "ssp0 Tx"},
@@ -660,10 +657,12 @@ static int skylake_card_late_probe(struct snd_soc_card *card)
 {
 	struct skl_nau88125_private *ctx = snd_soc_card_get_drvdata(card);
 	struct skl_hdmi_pcm *pcm;
+	struct snd_soc_codec *codec = NULL;
 	int err, i = 0;
 	char jack_name[NAME_SIZE];
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
+		codec = pcm->codec_dai->codec;
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
@@ -682,7 +681,10 @@ static int skylake_card_late_probe(struct snd_soc_card *card)
 		i++;
 	}
 
-	return 0;
+	if (!codec)
+		return -EINVAL;
+
+	return hdac_hdmi_jack_port_init(codec, &card->dapm);
 }
 
 /* skylake audio machine driver for SPT + NAU88L25 */
-- 
2.5.0
