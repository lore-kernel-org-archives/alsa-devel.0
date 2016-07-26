From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: soc-rt5616: add static qualifier for
	file local symbols
Date: Tue, 26 Jul 2016 22:41:56 +0900
Message-ID: <1469540517-32466-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id EA350268139
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 15:42:02 +0200 (CEST)
In-Reply-To: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sparse reports below warnings.

rt5616.c:1270:24: warning: symbol 'rt5616_aif_dai_ops' was not declared. Should it be static?
rt5616.c:1277:27: warning: symbol 'rt5616_dai' was not declared. Should it be static?

These two symbols are just used inner the file, thus it's better to add
static qualifier.

This commit adds it.

Fixes: b1d15059957d ('ASoC: rt5616: add rt5616 codec driver')
CC: Bard Liao <bardliao@realtek.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/rt5616.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index f527b5b..98ae326 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1267,14 +1267,14 @@ static int rt5616_resume(struct snd_soc_codec *codec)
 #define RT5616_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-struct snd_soc_dai_ops rt5616_aif_dai_ops = {
+static struct snd_soc_dai_ops rt5616_aif_dai_ops = {
 	.hw_params = rt5616_hw_params,
 	.set_fmt = rt5616_set_dai_fmt,
 	.set_sysclk = rt5616_set_dai_sysclk,
 	.set_pll = rt5616_set_dai_pll,
 };
 
-struct snd_soc_dai_driver rt5616_dai[] = {
+static struct snd_soc_dai_driver rt5616_dai[] = {
 	{
 		.name = "rt5616-aif1",
 		.id = RT5616_AIF1,
-- 
2.7.4
