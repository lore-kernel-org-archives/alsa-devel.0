From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 1/7] ASoC: rt5677: add GPIO helper macros
Date: Tue,  2 Jun 2015 02:09:12 +0300
Message-ID: <1433200158-6890-1-git-send-email-vz@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DB67260422
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 01:09:28 +0200 (CEST)
In-Reply-To: <1433200031-6748-1-git-send-email-vz@mleia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Add generic macro definitions for GPIO[1-5] direction and value
register bits, argument is RT5677_GPIOn.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 7eca38a..5b84255 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1622,6 +1622,12 @@
 #define RT5677_GPIO1_P_NOR			(0x0 << 0)
 #define RT5677_GPIO1_P_INV			(0x1 << 0)
 
+#define RT5677_GPIO_DIR_OUT_MASK(n)		(0x3 << (n * 3 + 1))
+#define RT5677_GPIO_DIR_MASK(n)			(0x1 << (n * 3 + 2))
+#define RT5677_GPIO_DIR_OUT(n)			(0x1 << (n * 3 + 2))
+#define RT5677_GPIO_OUT_MASK(n)			(0x1 << (n * 3 + 1))
+#define RT5677_GPIO_OUT_HI(n)			(0x1 << (n * 3 + 1))
+
 /* GPIO Control 3 (0xc2) */
 #define RT5677_GPIO6_DIR_MASK			(0x1 << 2)
 #define RT5677_GPIO6_DIR_SFT			2
-- 
2.1.4
