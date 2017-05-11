From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] ASoC: rt5514: fix gcc-7 warning
Date: Thu, 11 May 2017 13:44:38 +0200
Message-ID: <20170511114512.2865725-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id C618826664F
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 13:46:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

gcc-7 warns that there is a duplicate 'const' specifier in some
variables that are declared using the SOC_ENUM_SINGLE_DECL macro:

sound/soc/codecs/rt5514.c:398:14: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
 static const SOC_ENUM_SINGLE_DECL(
sound/soc/codecs/rt5514.c:405:14: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
 static const SOC_ENUM_SINGLE_DECL(

This removes one to fix the warning.

Fixes: 4a6180ea7399 ("ASoC: rt5514: add rt5514 codec driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/rt5514.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index f91221b1ddf0..28ab9e2bb051 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -395,14 +395,14 @@ static const char * const rt5514_dmic_src[] = {
 	"DMIC1", "DMIC2"
 };
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5514_stereo1_dmic_enum, RT5514_DIG_SOURCE_CTRL,
 	RT5514_AD0_DMIC_INPUT_SEL_SFT, rt5514_dmic_src);
 
 static const struct snd_kcontrol_new rt5514_sto1_dmic_mux =
 	SOC_DAPM_ENUM("Stereo1 DMIC Source", rt5514_stereo1_dmic_enum);
 
-static const SOC_ENUM_SINGLE_DECL(
+static SOC_ENUM_SINGLE_DECL(
 	rt5514_stereo2_dmic_enum, RT5514_DIG_SOURCE_CTRL,
 	RT5514_AD1_DMIC_INPUT_SEL_SFT, rt5514_dmic_src);
 
-- 
2.9.0
