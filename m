From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5645: fix coccinelle warnings
Date: Thu, 8 May 2014 15:42:37 +0800
Message-ID: <1399534957-23937-2-git-send-email-oder_chiou@realtek.com>
References: <1399534957-23937-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 90A702654AE
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 09:43:29 +0200 (CEST)
In-Reply-To: <1399534957-23937-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Return statements in functions returning bool should use
true/false instead of 1/0.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 30410eb..68923ec 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -242,9 +242,9 @@ static bool rt5645_volatile_register(struct device *dev, unsigned int reg)
 	case RT5645_VENDOR_ID:
 	case RT5645_VENDOR_ID1:
 	case RT5645_VENDOR_ID2:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
@@ -391,9 +391,9 @@ static bool rt5645_readable_register(struct device *dev, unsigned int reg)
 	case RT5645_VENDOR_ID:
 	case RT5645_VENDOR_ID1:
 	case RT5645_VENDOR_ID2:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
1.8.1.1.439.g50a6b54
