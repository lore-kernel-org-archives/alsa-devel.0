From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] ASoC: samsung: Remove non-existing
	CONFIG_CPU_S3C2413
Date: Mon, 17 Jul 2017 07:44:21 +0200
Message-ID: <1500270261-23235-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 034A6266D71
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 07:44:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is no CONFIG_CPU_S3C2413 so get rid of it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/s3c-i2s-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 8f42deaa184b..ca522a95160b 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -27,7 +27,7 @@
 
 #undef S3C_IIS_V2_SUPPORTED
 
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413) \
+#if defined(CONFIG_CPU_S3C2412) \
 	|| defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_CPU_S5PV210)
 #define S3C_IIS_V2_SUPPORTED
 #endif
-- 
2.7.4
