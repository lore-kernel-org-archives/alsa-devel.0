From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: TSCS42xx: make functions pll_event and
	dac_event static" to the asoc tree
Date: Tue, 09 Jan 2018 17:43:34 +0000
Message-ID: <E1eYxvy-0006bO-J0@debutante>
References: <20180108231444.8415-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E063B26719C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 18:43:44 +0100 (CET)
In-Reply-To: <20180108231444.8415-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: TSCS42xx: make functions pll_event and dac_event static

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

>From 3511108a790fc8942448556b82046d6de945b80f Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 8 Jan 2018 23:14:44 +0000
Subject: [PATCH] ASoC: TSCS42xx: make functions pll_event and dac_event static

The functions pll_event and dac_event are local to the source and do
not need to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'pll_event' was not declared. Should it be static?
symbol 'dac_event' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs42xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index 4a5b32a717f2..e7661d0315e6 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -355,8 +355,8 @@ static int dapm_micb_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-int pll_event(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event)
+static int pll_event(struct snd_soc_dapm_widget *w,
+		     struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	int ret;
@@ -369,8 +369,8 @@ int pll_event(struct snd_soc_dapm_widget *w,
 	return ret;
 }
 
-int dac_event(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event)
+static int dac_event(struct snd_soc_dapm_widget *w,
+		     struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct tscs42xx *tscs42xx = snd_soc_codec_get_drvdata(codec);
-- 
2.15.1
