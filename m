From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: [PATCH 1/2] ASoC: uda134x: add DATA011 register found
	in codecs family
Date: Thu, 24 Jun 2010 15:17:07 +0400
Message-ID: <1277378228-29658-1-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 619D410380B
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 13:17:46 +0200 (CEST)
Received: by fxm13 with SMTP id 13so1914587fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 04:17:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Vladimir Zapolskiy <vzapolskiy@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

In UDA1340, UDA1344 and UDA1345 codecs there is one more functional
register in part of DATA0 tranfser. For UDA1341 this register
coincides with EA register.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
---
 sound/soc/codecs/uda134x.c |    3 ++-
 sound/soc/codecs/uda134x.h |    5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index b3039b1..e770029 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -57,7 +57,7 @@ static const char uda134x_reg[UDA134X_REGS_NUM] = {
 	/* Extended address registers */
 	0x04, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
 	/* Status, data regs */
-	0x00, 0x83, 0x00, 0x40, 0x80, 0x00,
+	0x00, 0x83, 0x00, 0x40, 0x80, 0xC0, 0x00,
 };
 
 /*
@@ -116,6 +116,7 @@ static int uda134x_write(struct snd_soc_codec *codec, unsigned int reg,
 	case UDA134X_DATA000:
 	case UDA134X_DATA001:
 	case UDA134X_DATA010:
+	case UDA134X_DATA011:
 		addr = UDA134X_DATA0_ADDR;
 		break;
 	case UDA134X_DATA1:
diff --git a/sound/soc/codecs/uda134x.h b/sound/soc/codecs/uda134x.h
index 94f4404..205f03b 100644
--- a/sound/soc/codecs/uda134x.h
+++ b/sound/soc/codecs/uda134x.h
@@ -23,9 +23,10 @@
 #define UDA134X_DATA000 10
 #define UDA134X_DATA001 11
 #define UDA134X_DATA010 12
-#define UDA134X_DATA1	13
+#define UDA134X_DATA011 13
+#define UDA134X_DATA1   14
 
-#define UDA134X_REGS_NUM 14
+#define UDA134X_REGS_NUM 15
 
 #define STATUS0_DAIFMT_MASK (~(7<<1))
 #define STATUS0_SYSCLK_MASK (~(3<<4))
-- 
1.7.0.4
