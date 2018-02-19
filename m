From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: kbl_da7219_max98357: replace
	codec to component" to the asoc tree
Date: Mon, 19 Feb 2018 12:19:45 +0000
Message-ID: <E1enkQ5-0002rw-Px@debutante>
References: <874lmdpzxn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F08EE267396
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 13:19:55 +0100 (CET)
In-Reply-To: <874lmdpzxn.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Harsha Priya <harshapriya.n@intel.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>, Mark Brown <broonie@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Mihai Serban <mihai.serban@nxp.com>, Naveen Manohar <naveen.m@intel.com>, Dylan Reid <dgreid@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Daniel Baluta <daniel.baluta@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: kbl_da7219_max98357: replace codec to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 257aaceb63eb2337e50cd9f9008d11df2cb86207 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 19 Feb 2018 04:15:38 +0000
Subject: [PATCH] ASoC: intel: kbl_da7219_max98357: replace codec to component

Now we can replace Codec to Component. Let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_da7219_max98357a.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index d689124f6687..e84baafd5f63 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -168,7 +168,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_component *component = rtd->codec_dai->component;
 	struct snd_soc_jack *jack;
 	int ret;
 
@@ -191,7 +191,7 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
-	da7219_aad_jack_det(codec, &ctx->kabylake_headset);
+	da7219_aad_jack_det(component, &ctx->kabylake_headset);
 
 	ret = snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
 	if (ret)
@@ -522,12 +522,12 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 {
 	struct kbl_codec_private *ctx = snd_soc_card_get_drvdata(card);
 	struct kbl_hdmi_pcm *pcm;
-	struct snd_soc_codec *codec = NULL;
+	struct snd_soc_component *component = NULL;
 	int err, i = 0;
 	char jack_name[NAME_SIZE];
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
-		codec = pcm->codec_dai->codec;
+		component = pcm->codec_dai->component;
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
@@ -546,10 +546,10 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 
 	}
 
-	if (!codec)
+	if (!component)
 		return -EINVAL;
 
-	return hdac_hdmi_jack_port_init(codec, &card->dapm);
+	return hdac_hdmi_jack_port_init(component, &card->dapm);
 }
 
 /* kabylake audio machine driver for SPT + DA7219 */
-- 
2.16.1
