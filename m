From: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH 2/2] ASoC: tlv320aic3x: extending registers
	cache
Date: Wed,  4 Jul 2012 08:12:51 +0200
Message-ID: <1341382371-4515-2-git-send-email-jiri.prchal@aksignal.cz>
References: <1341382371-4515-1-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id F13C310437A
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 08:13:21 +0200 (CEST)
In-Reply-To: <1341382371-4515-1-git-send-email-jiri.prchal@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
List-Id: alsa-devel@alsa-project.org

Adds missing register default values to cache.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 sound/soc/codecs/tlv320aic3x.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 7a49390..bd03f4d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -119,7 +119,9 @@ static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
 	0x00, 0x00, 0x00, 0x00,	/* 88 */
 	0x00, 0x00, 0x00, 0x00,	/* 92 */
 	0x00, 0x00, 0x00, 0x00,	/* 96 */
-	0x00, 0x00, 0x02,	/* 100 */
+	0x00, 0x00, 0x02, 0x00,	/* 100 */
+	0x00, 0x00, 0x00, 0x00,	/* 104 */
+	0x00, 0x00,            	/* 108 */
 };
 
 /*
-- 
1.7.7
