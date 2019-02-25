From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [RFC PATCH 2/2] ASoC: core: standardize
	snd_soc_dai_set_bclk_ratio() behaviour
Date: Mon, 25 Feb 2019 11:42:18 -0500
Message-ID: <20190225164218.19439-2-TheSven73@gmail.com>
References: <20190225164218.19439-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5256F89656
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 17:42:28 +0100 (CET)
Received: by mail-it1-x144.google.com with SMTP id i2so14287335ite.5
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 08:42:27 -0800 (PST)
In-Reply-To: <20190225164218.19439-1-TheSven73@gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: alsa-devel@alsa-project.org

snd_soc_dai_set_bclk_ratio() should behave like other
snd_soc_dai_XXX functions, and return -ENOTSUPP if the
callback in driver->ops is NULL.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 sound/soc/soc-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 50617db05c46..5611caf25ea3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2550,10 +2550,11 @@ EXPORT_SYMBOL_GPL(snd_soc_component_set_pll);
  */
 int snd_soc_dai_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 {
-	if (dai->driver->ops->set_bclk_ratio)
-		return dai->driver->ops->set_bclk_ratio(dai, ratio);
-	else
+	if (dai->driver == NULL)
 		return -EINVAL;
+	if (dai->driver->ops->set_bclk_ratio == NULL)
+		return -ENOTSUPP;
+	return dai->driver->ops->set_bclk_ratio(dai, ratio);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_bclk_ratio);
 
-- 
2.17.1
