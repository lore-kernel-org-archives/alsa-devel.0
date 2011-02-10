From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH] ASoC: mid-x86: Use the soc-jack apis for jack
	type detection
Date: Thu, 10 Feb 2011 12:58:01 +0530
Message-ID: <1297322881-20461-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id F33471039B4
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 08:20:25 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch modifies the mfld_machine to use the new jack apis for adding the
voltage zones for jack type detection. It also modifed TI sn95031 codec driver
to use these new apis

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/codecs/sn95031.c       |    4 +---
 sound/soc/mid-x86/mfld_machine.c |   12 ++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 4cc0017..d0b7802 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -782,9 +782,7 @@ static int sn95031_get_headset_state(struct snd_soc_jack *mfld_jack)
 {
 	int micbias = sn95031_get_mic_bias(mfld_jack->codec);
 
-	/* Defaulting to HEADSET for now.
-	 * will change after adding soc-jack detection apis */
-	int jack_type = SND_JACK_HEADSET;
+	int jack_type = snd_soc_jack_get_type(mfld_jack, micbias);
 
 	pr_debug("jack type detected = %d\n", jack_type);
 	if (jack_type == SND_JACK_HEADSET)
diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 45a0067..96487fb 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -74,6 +74,12 @@ static struct snd_soc_jack_pin mfld_jack_pins[] = {
 	},
 };
 
+/* jack detection voltage zones */
+static struct snd_soc_jack_zone mfld_zones[] = {
+	{MFLD_MV_START, MFLD_MV_AM_HS, SND_JACK_HEADPHONE},
+	{MFLD_MV_AM_HS, MFLD_MV_HS, SND_JACK_HEADSET},
+};
+
 /* sound card controls */
 static const char *headset_switch_text[] = {"Earpiece", "Headset"};
 
@@ -264,6 +270,12 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 		pr_err("adding jack pins failed\n");
 		return ret_val;
 	}
+	ret_val = snd_soc_jack_add_zones(&mfld_jack,
+			ARRAY_SIZE(mfld_zones), mfld_zones);
+	if (ret_val) {
+		pr_err("adding jack zones failed\n");
+		return ret_val;
+	}
 
 	/* we want to check if anything is inserted at boot,
 	 * so send a fake event to codec and it will read adc
-- 
1.7.2.3
