From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: use sizeof_field rather than declaring hcp" to the asoc tree
Date: Tue, 19 Sep 2017 14:47:02 +0100
Message-ID: <E1duIre-0008My-DY@debutante>
References: <20170918094843.28121-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170918094843.28121-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: use sizeof_field rather than declaring hcp

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

>From 0607aa3cd824bddf85fa5174fe4be34af5a429fb Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 18 Sep 2017 10:48:43 +0100
Subject: [PATCH] ASoC: hdmi-codec: use sizeof_field rather than declaring hcp

Use FIELD_SIZEOF rather than declaring and initializing hcp. Remove
unused variables. Cleans up clang warning:

warning: Value stored to 'hcp' during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 3abf82563408..5672e516bec3 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -303,11 +303,8 @@ enum {
 static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_info *uinfo)
 {
-	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
-	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
-
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
-	uinfo->count = sizeof(hcp->eld);
+	uinfo->count = FIELD_SIZEOF(struct hdmi_codec_priv, eld);
 
 	return 0;
 }
-- 
2.14.1
