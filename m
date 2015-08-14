From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: wm8994: fix add dynamic path error
Date: Fri, 14 Aug 2015 11:22:16 +0800
Message-ID: <898610f35e157ce9d5b1e53a85f5a6ed822eadae.1439522138.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0125.outbound.protection.outlook.com [65.55.169.125])
 by alsa0.perex.cz (Postfix) with ESMTP id C5B28264FF9
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 05:20:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, patches@opensource.wolfsonmicro.com, tiwai@suse.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

If there don't exist dynamic sink or source widget, it will failed to
add dynamic path.

"AIF3ADCDAT" is snd_soc_dapm_aif_out, can't be dynamic sink widget. So
change the audio route to fix this issue.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8994.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 962e1d3..2ccbb32 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1942,14 +1942,16 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "AIF2ADCDAT", NULL, "AIF2ADC Mux" },
 
 	/* AIF3 output */
-	{ "AIF3ADCDAT", "AIF1ADCDAT", "AIF1ADC1L" },
-	{ "AIF3ADCDAT", "AIF1ADCDAT", "AIF1ADC1R" },
-	{ "AIF3ADCDAT", "AIF1ADCDAT", "AIF1ADC2L" },
-	{ "AIF3ADCDAT", "AIF1ADCDAT", "AIF1ADC2R" },
-	{ "AIF3ADCDAT", "AIF2ADCDAT", "AIF2ADCL" },
-	{ "AIF3ADCDAT", "AIF2ADCDAT", "AIF2ADCR" },
-	{ "AIF3ADCDAT", "AIF2DACDAT", "AIF2DACL" },
-	{ "AIF3ADCDAT", "AIF2DACDAT", "AIF2DACR" },
+	{ "AIF3ADC Mux", "AIF1ADCDAT", "AIF1ADC1L" },
+	{ "AIF3ADC Mux", "AIF1ADCDAT", "AIF1ADC1R" },
+	{ "AIF3ADC Mux", "AIF1ADCDAT", "AIF1ADC2L" },
+	{ "AIF3ADC Mux", "AIF1ADCDAT", "AIF1ADC2R" },
+	{ "AIF3ADC Mux", "AIF2ADCDAT", "AIF2ADCL" },
+	{ "AIF3ADC Mux", "AIF2ADCDAT", "AIF2ADCR" },
+	{ "AIF3ADC Mux", "AIF2DACDAT", "AIF2DACL" },
+	{ "AIF3ADC Mux", "AIF2DACDAT", "AIF2DACR" },
+
+	{ "AIF3ADCDAT", NULL, "AIF3ADC Mux" },
 
 	/* Loopback */
 	{ "AIF1 Loopback", "ADCDAT", "AIF1ADCDAT" },
-- 
1.9.1
