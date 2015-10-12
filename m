From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt298: set register non-volatile by
	default
Date: Mon, 12 Oct 2015 21:34:59 +0800
Message-ID: <1444656899-13645-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A1813261566
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 15:35:23 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, ramesh.babu@intel.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

It is not necessary to set registers volatile. So, return false
for default case of rt298_volatile_register.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 5a9aadb..56e5e1a 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -128,7 +128,7 @@ static bool rt298_volatile_register(struct device *dev, unsigned int reg)
 	case VERB_CMD(AC_VERB_GET_EAPD_BTLENABLE, RT298_HP_OUT, 0):
 		return true;
 	default:
-		return true;
+		return false;
 	}
 
 
-- 
1.8.1.1.439.g50a6b54
