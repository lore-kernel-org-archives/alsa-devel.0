From: Yang Xiao <YangX92@hotmail.com>
Subject: [PATCH] ASoc: au8540: use 64-bit arithmetic instead of
	32-bit
Date: Tue, 27 Nov 2018 06:33:16 +0000
Message-ID: <HK0PR01MB21639B3BAE478CE75DB3115BADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-oln040092255100.outbound.protection.outlook.com [40.92.255.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 32982267A8C
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2018 07:33:20 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Yang Xiao <YangX92@hotmail.com>
List-Id: alsa-devel@alsa-project.org

From: Young_X <YangX92@hotmail.com>

    Add suffix ULL to constant 256 in order to give the compiler complete
    information about the proper arithmetic to use.

    Notice that such constant is used in a context that expects an
    expression of type u64 (64 bits, unsigned) and the following
    expression is currently being evaluated using 32-bit arithmetic:

    256 * fs * 2 * mclk_src_scaling[i].param

Signed-off-by: Young_X <YangX92@hotmail.com>
---
 sound/soc/codecs/nau8540.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index e3c8cd1..4dd1a60 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -585,7 +585,7 @@ static int nau8540_calc_fll_param(unsigned int fll_in,
 	fvco_max = 0;
 	fvco_sel = ARRAY_SIZE(mclk_src_scaling);
 	for (i = 0; i < ARRAY_SIZE(mclk_src_scaling); i++) {
-		fvco = 256 * fs * 2 * mclk_src_scaling[i].param;
+		fvco = 256ULL * fs * 2 * mclk_src_scaling[i].param;
 		if (fvco > NAU_FVCO_MIN && fvco < NAU_FVCO_MAX &&
 			fvco_max < fvco) {
 			fvco_max = fvco;
-- 
2.7.4
