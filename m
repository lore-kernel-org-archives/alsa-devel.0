From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: wm9712: fix unused variable warning
Date: Wed, 26 Sep 2018 21:37:40 +0200
Message-ID: <20180926193750.2468414-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 32D402678BA
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2018 21:38:15 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnd Bergmann <arnd@arndb.de>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The 'ret' variable is now only used in an #ifdef, and causes a
warning if it is declared outside of that block:

sound/soc/codecs/wm9712.c: In function 'wm9712_soc_probe':
sound/soc/codecs/wm9712.c:641:6: error: unused variable 'ret' [-Werror=unused-variable]

Fixes: 2ed1a8e0ce8d ("ASoC: wm9712: add ac97 new bus support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/wm9712.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index ade34c26ad2f..e873baa9e778 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -638,13 +638,14 @@ static int wm9712_soc_probe(struct snd_soc_component *component)
 {
 	struct wm9712_priv *wm9712 = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap;
-	int ret;
 
 	if (wm9712->mfd_pdata) {
 		wm9712->ac97 = wm9712->mfd_pdata->ac97;
 		regmap = wm9712->mfd_pdata->regmap;
 	} else {
 #ifdef CONFIG_SND_SOC_AC97_BUS
+		int ret;
+
 		wm9712->ac97 = snd_soc_new_ac97_component(component, WM9712_VENDOR_ID,
 						      WM9712_VENDOR_ID_MASK);
 		if (IS_ERR(wm9712->ac97)) {
-- 
2.18.0
