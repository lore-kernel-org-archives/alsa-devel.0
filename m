From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Create ASoC jack for
	hdmi in nau88l25_ssm4567 machine" to the asoc tree
Date: Thu, 16 Feb 2017 19:04:27 +0000
Message-ID: <E1ceRLv-0007Yg-6X@debutante>
References: <1484589477-7630-22-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B53AC267056
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 20:04:35 +0100 (CET)
In-Reply-To: <1484589477-7630-22-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Create ASoC jack for hdmi in nau88l25_ssm4567 machine

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9e4278cd9b8e6e6464a4eb5e65c2b232076aa6c6 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 7 Feb 2017 19:09:52 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Create ASoC jack for hdmi in
 nau88l25_ssm4567 machine

Creates ASoC jack for HDMI PCM and calls hdmi codec API to initialize
jack in skl_nau88l25_ssm4567 machine

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 41117bc51450..5deb68f0c1f0 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -36,6 +36,7 @@
 static struct snd_soc_jack skylake_headset;
 static struct snd_soc_card skylake_audio_card;
 static const struct snd_pcm_hw_constraint_list *dmic_constraints;
+static struct snd_soc_jack skylake_hdmi[3];
 
 struct skl_hdmi_pcm {
 	struct list_head head;
@@ -654,16 +655,31 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 };
 
+#define NAME_SIZE	32
 static int skylake_card_late_probe(struct snd_soc_card *card)
 {
 	struct skl_nau88125_private *ctx = snd_soc_card_get_drvdata(card);
 	struct skl_hdmi_pcm *pcm;
-	int err;
+	int err, i = 0;
+	char jack_name[NAME_SIZE];
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
-		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device);
+		snprintf(jack_name, sizeof(jack_name),
+			"HDMI/DP, pcm=%d Jack", pcm->device);
+		err = snd_soc_card_jack_new(card, jack_name,
+					SND_JACK_AVOUT,
+					&skylake_hdmi[i],
+					NULL, 0);
+
+		if (err)
+			return err;
+
+		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
+						&skylake_hdmi[i]);
 		if (err < 0)
 			return err;
+
+		i++;
 	}
 
 	return 0;
-- 
2.11.0
