From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 1/3] ASoC: cs35l32: use true/false returns for
	bool functions
Date: Thu, 28 Aug 2014 10:02:40 -0500
Message-ID: <1409238162-13400-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C52A42664A2
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 17:02:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Return true or false instead of 1 and 0

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs35l32.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 9c6b272..ca897c4 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -121,9 +121,9 @@ static bool cs35l32_volatile_register(struct device *dev, unsigned int reg)
 	case CS35L32_INT_STATUS_2:
 	case CS35L32_INT_STATUS_3:
 	case CS35L32_LED_STATUS:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
@@ -134,9 +134,9 @@ static bool cs35l32_precious_register(struct device *dev, unsigned int reg)
 	case CS35L32_INT_STATUS_2:
 	case CS35L32_INT_STATUS_3:
 	case CS35L32_LED_STATUS:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
1.7.9.5
