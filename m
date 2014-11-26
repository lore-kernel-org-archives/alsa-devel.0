From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH V2 6/6] ASoC: arizona: Add support for
	WM8280/WM8281
Date: Wed, 26 Nov 2014 15:13:08 +0000
Message-ID: <1417014788-8311-7-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1417014788-8311-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 96D77265CDB
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 16:15:06 +0100 (CET)
In-Reply-To: <1417014788-8311-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 9550d74..55b5e22 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -281,6 +281,7 @@ int arizona_init_gpio(struct snd_soc_codec *codec)
 
 	switch (arizona->type) {
 	case WM5110:
+	case WM8280:
 		snd_soc_dapm_disable_pin(&codec->dapm, "DRC2 Signal Activity");
 		break;
 	default:
@@ -1669,6 +1670,7 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 
 	switch (fll->arizona->type) {
 	case WM5110:
+	case WM8280:
 		if (fll->arizona->rev < 3 || sync)
 			return init_ratio;
 		break;
-- 
1.7.2.5
