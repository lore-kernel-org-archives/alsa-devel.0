From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] SoC: rt5640: Add the rt5639 support to the OF
	match table
Date: Mon, 28 Apr 2014 16:55:21 +0800
Message-ID: <1398675321-22123-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 175182608ED
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 10:55:30 +0200 (CEST)
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

The patch adds the rt5639 support to the OF match table.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 79635ee..2133fa0 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2157,6 +2157,7 @@ MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
 
 #if defined(CONFIG_OF)
 static const struct of_device_id rt5640_of_match[] = {
+	{ .compatible = "realtek,rt5639", },
 	{ .compatible = "realtek,rt5640", },
 	{},
 };
-- 
1.8.1.1.439.g50a6b54
