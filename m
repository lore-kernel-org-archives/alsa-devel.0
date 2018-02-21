From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmic: don't use codec anymore" to the
	asoc tree
Date: Wed, 21 Feb 2018 12:18:37 +0000
Message-ID: <E1eoTM5-0004KH-KQ@debutante>
References: <87tvubnln7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B21FF2675A4
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 13:18:48 +0100 (CET)
In-Reply-To: <87tvubnln7.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, huang lin <hl@rock-chips.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmic: don't use codec anymore

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

>From 15b7c5de7c0c4f55d529ca71a5a0feca4cf03ab3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Feb 2018 02:06:29 +0000
Subject: [PATCH] ASoC: dmic: don't use codec anymore

commit 6d6c3946d877 ("ASoC: dmic: replace codec to component")
replaced codec to component, but
commit 05c9b302eda7 ("ASoC: dmic: Add optional wakeup delay")
used codec again. This patch fix it up.

Fixes: 05c9b302eda7 ("ASoC: dmic: Add optional wakeup delay")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/dmic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index bac5bbb2dd59..8c4926df9286 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -37,8 +37,8 @@ struct dmic {
 
 static int dmic_aif_event(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol, int event) {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct dmic *dmic = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct dmic *dmic = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-- 
2.16.1
