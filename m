From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: acp-da7219-max98357: replace codec
	to component" to the asoc tree
Date: Mon, 19 Feb 2018 12:19:41 +0000
Message-ID: <E1enkQ1-0002qZ-7F@debutante>
References: <87371xpzx0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 88DC92674CE
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 13:20:01 +0100 (CET)
In-Reply-To: <87371xpzx0.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: amd: acp-da7219-max98357: replace codec to component

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

>From 9a60cde2dd63e10b421e87e1397641304dd1ef13 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 19 Feb 2018 04:16:06 +0000
Subject: [PATCH] ASoC: amd: acp-da7219-max98357: replace codec to component

Now we can replace Codec to Component. Let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index e51a878890ce..bbe0f103e6a8 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -47,8 +47,8 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
 	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_component *component = codec_dai->component;
 
 	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
 
@@ -76,7 +76,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	da7219_aad_jack_det(codec, &cz_jack);
+	da7219_aad_jack_det(component, &cz_jack);
 
 	return 0;
 }
-- 
2.16.1
