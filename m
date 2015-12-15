From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH] ASoC: rt5677: Reconfigure PLL1 after resume
Date: Tue, 15 Dec 2015 13:51:25 -0800
Message-ID: <1450216285-14875-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 58FFF260786
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 22:51:33 +0100 (CET)
Received: by mail-pa0-f53.google.com with SMTP id hk6so11757007pad.2
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 13:51:33 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Sometimes PLL1 stops working if the codec loses power
during suspend (when pow-ldo2 or reset gpio is used).
MX-7Bh(RT5677_PLL1_CTRL2) is cleared and won't be restored
by regcache since it's volatile. MX-7Bh has one status bit
and M code for PLL1. rt5677_set_dai_pll doesn't reconfigure
PLL1 after resume because it thinks the PLL params are not
changed.

This patch clears the cached PLL params at resume so that
rt5677_set_dai_pll can reconfigure the PLL after resume.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/rt5677.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index f73fd12..c404f51 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4792,6 +4792,9 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	if (!rt5677->dsp_vad_en) {
+		rt5677->pll_src = 0;
+		rt5677->pll_in = 0;
+		rt5677->pll_out = 0;
 		gpiod_set_value_cansleep(rt5677->pow_ldo2, 1);
 		gpiod_set_value_cansleep(rt5677->reset_pin, 0);
 		if (rt5677->pow_ldo2 || rt5677->reset_pin)
-- 
2.6.0.rc2.230.g3dd15c0
