From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RESEND] ASoC: wm8904: Make undocumented
 registers non-readable
Date: Wed, 18 Nov 2015 16:24:56 +0800
Message-ID: <1447835096.13770.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 0802E260455
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 09:25:02 +0100 (CET)
Received: by padhx2 with SMTP id hx2so37760021pad.1
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 00:25:01 -0800 (PST)
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
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
This patch was sent on
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/099094.html

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
