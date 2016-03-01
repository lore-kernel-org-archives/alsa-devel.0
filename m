From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98095: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:23:19 +0900
Message-ID: <E1aaau7-00085G-N8@finisterre>
References: <1456765684-5717-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 15710265DA7
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:23:31 +0100 (CET)
In-Reply-To: <1456765684-5717-4-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98095: Fix enum ctl accesses in a wrong type

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

>From 58c0213872816bf24d14364989c82dc4acd58103 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:08:02 +0100
Subject: [PATCH] ASoC: max98095: Fix enum ctl accesses in a wrong type

"Biquad1 Mode" and "Biquad2 Mode" ctls in max98095 codec driver are
enum, while the current driver accesses wrongly via
value.integer.value[].  They have to be via value.enumerated.item[]
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98095.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 1fedac50355e..3577003f39cf 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1499,7 +1499,7 @@ static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
 	struct max98095_pdata *pdata = max98095->pdata;
 	int channel = max98095_get_eq_channel(kcontrol->id.name);
 	struct max98095_cdata *cdata;
-	unsigned int sel = ucontrol->value.integer.value[0];
+	unsigned int sel = ucontrol->value.enumerated.item[0];
 	struct max98095_eq_cfg *coef_set;
 	int fs, best, best_val, i;
 	int regmask, regsave;
@@ -1653,7 +1653,7 @@ static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
 	struct max98095_pdata *pdata = max98095->pdata;
 	int channel = max98095_get_bq_channel(codec, kcontrol->id.name);
 	struct max98095_cdata *cdata;
-	unsigned int sel = ucontrol->value.integer.value[0];
+	unsigned int sel = ucontrol->value.enumerated.item[0];
 	struct max98095_biquad_cfg *coef_set;
 	int fs, best, best_val, i;
 	int regmask, regsave;
-- 
2.7.0
