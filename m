From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4642: make arrays fs_list and ps_list static const" to the asoc tree
Date: Fri, 30 Jun 2017 12:59:40 +0100
Message-ID: <E1dQuaK-00085F-Sm@finisterre>
References: <20170630091636.8287-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170630091636.8287-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4642: make arrays fs_list and ps_list static const

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

>From 836e4fedee8df123a203a0ded090251de66b9bd1 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 30 Jun 2017 10:16:36 +0100
Subject: [PATCH] ASoC: ak4642: make arrays fs_list and ps_list static const

Don't populate the arrays fs_list and ps_list on the stack but make
them static const.  Makes the object code smaller:

Before:
   text    data     bss     dec     hex filename
  12084    4888      64   17036    428c sound/soc/codecs/ak4642.o

After:
   text    data     bss     dec     hex filename
  11883    5032      64   16979    4253 sound/soc/codecs/ak4642.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4642.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 23ab9646c351..66de8a2013a6 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -433,7 +433,7 @@ static int ak4642_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static int ak4642_set_mcko(struct snd_soc_codec *codec,
 			   u32 frequency)
 {
-	u32 fs_list[] = {
+	static const u32 fs_list[] = {
 		[0] = 8000,
 		[1] = 12000,
 		[2] = 16000,
@@ -447,7 +447,7 @@ static int ak4642_set_mcko(struct snd_soc_codec *codec,
 		[14] = 29400,
 		[15] = 44100,
 	};
-	u32 ps_list[] = {
+	static const u32 ps_list[] = {
 		[0] = 256,
 		[1] = 128,
 		[2] = 64,
-- 
2.13.2
