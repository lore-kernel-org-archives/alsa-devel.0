From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: wm8904: Make undocumented registers
	non-readable
Date: Sat, 17 Oct 2015 11:11:10 +0800
Message-ID: <1445051470.3014.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id F147C2606E9
 for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2015 05:11:16 +0200 (CEST)
Received: by pabrc13 with SMTP id rc13so136575149pab.0
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 20:11:15 -0700 (PDT)
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
I think the intention of wm8904_readable_register is to return false for
undocumented registers, but current code returns true for all cases in
wm8904_readable_register.
Please review if this patch is correct or not.
Thanks.

 sound/soc/codecs/wm8904.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index b783743..f48b9cb 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -312,7 +312,7 @@ static bool wm8904_readable_register(struct device *dev, unsigned int reg)
 	case WM8904_FLL_NCO_TEST_1:
 		return true;
 	default:
-		return true;
+		return false;
 	}
 }
 
-- 
2.1.4
