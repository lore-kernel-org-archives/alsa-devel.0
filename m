From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH RESEND v2 2/4] ASoC: cs42l52: increase
	MAX_REGISTER for regmap_register_patch
Date: Fri, 25 Oct 2013 10:01:15 -0500
Message-ID: <1382713277-10306-3-git-send-email-brian.austin@cirrus.com>
References: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id DF93826564B
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 16:59:12 +0200 (CEST)
In-Reply-To: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
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

regmap_register_patch fails without the MAX_REGISTER set to highest
register written to. Increase to register 0x47

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l52.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.h b/sound/soc/codecs/cs42l52.h
index 4277012..1a9412d 100644
--- a/sound/soc/codecs/cs42l52.h
+++ b/sound/soc/codecs/cs42l52.h
@@ -269,6 +269,6 @@
 #define CS42L52_FIX_BITS1			0x3E
 #define CS42L52_FIX_BITS2			0x47
 
-#define CS42L52_MAX_REGISTER			0x34
+#define CS42L52_MAX_REGISTER			0x47
 
 #endif
-- 
1.8.4.rc3
