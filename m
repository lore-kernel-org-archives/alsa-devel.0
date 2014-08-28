From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 2/3] ASoC: cs42l52: use true/false returns for
	bool functions
Date: Thu, 28 Aug 2014 10:02:41 -0500
Message-ID: <1409238162-13400-2-git-send-email-brian.austin@cirrus.com>
References: <1409238162-13400-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 09AE72664A3
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 17:02:16 +0200 (CEST)
In-Reply-To: <1409238162-13400-1-git-send-email-brian.austin@cirrus.com>
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

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l52.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 969167d..da4f758 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -176,9 +176,9 @@ static bool cs42l52_volatile_register(struct device *dev, unsigned int reg)
 	case CS42L52_BATT_LEVEL:
 	case CS42L52_SPK_STATUS:
 	case CS42L52_CHARGE_PUMP:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
1.7.9.5
