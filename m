From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 2/2] ASoC: cs42l52: Correct MIC CTL mask
Date: Thu, 14 Nov 2013 11:46:12 -0600
Message-ID: <1384451172-1532-2-git-send-email-brian.austin@cirrus.com>
References: <1384451172-1532-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 818FB265200
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 18:43:23 +0100 (CET)
In-Reply-To: <1384451172-1532-1-git-send-email-brian.austin@cirrus.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgridwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The mask for CS42L52_MIC_CTL_TYPE_MASK was wrong keeping the mic config
from being set correctly.

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l52.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.h b/sound/soc/codecs/cs42l52.h
index 1a9412d..6fb8f00 100644
--- a/sound/soc/codecs/cs42l52.h
+++ b/sound/soc/codecs/cs42l52.h
@@ -179,7 +179,7 @@
 #define CS42L52_MICB_CTL			0x11
 #define	CS42L52_MIC_CTL_MIC_SEL_MASK		0xBF
 #define	CS42L52_MIC_CTL_MIC_SEL_SHIFT		6
-#define CS42L52_MIC_CTL_TYPE_MASK		0xDF
+#define CS42L52_MIC_CTL_TYPE_MASK		0x20
 #define CS42L52_MIC_CTL_TYPE_SHIFT		5
 
 
-- 
1.8.4.3
