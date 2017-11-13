From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8824: change FVCO maximum threshold
Date: Mon, 13 Nov 2017 10:36:28 +0800
Message-ID: <1510540588-2463-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 64CB52672AC
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 03:36:34 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Change the maximum of FDCO which remains between 90MHz-100MHz.
FDCO must be within the 90MHz-100MHz or the FFL cannot be
guaranteed across the full range of operation.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8824.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 8a9a993..088e0ce 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -43,7 +43,7 @@ static bool nau8824_is_jack_inserted(struct nau8824 *nau8824);
 
 /* the parameter threshold of FLL */
 #define NAU_FREF_MAX 13500000
-#define NAU_FVCO_MAX 124000000
+#define NAU_FVCO_MAX 100000000
 #define NAU_FVCO_MIN 90000000
 
 /* scaling for mclk from sysclk_src output */
-- 
2.6.4
