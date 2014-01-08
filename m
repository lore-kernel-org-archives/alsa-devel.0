From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: adau1701: Fix
	ADAU1701_SEROCTL_WORD_LEN_16 constant
Date: Wed,  8 Jan 2014 11:22:25 +0100
Message-ID: <1389176545-10316-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-079.synserver.de
 [212.40.185.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 1233826501D
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 11:22:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The driver defines ADAU1701_SEROCTL_WORD_LEN_16 as 0x10 while it should be b10,
so 0x2. This patch fixes it.

Reported-by: Magnus Reftel <magnus.reftel@lockless.no>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/adau1701.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index ebff112..adee866 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -71,7 +71,7 @@
 
 #define ADAU1701_SEROCTL_WORD_LEN_24	0x0000
 #define ADAU1701_SEROCTL_WORD_LEN_20	0x0001
-#define ADAU1701_SEROCTL_WORD_LEN_16	0x0010
+#define ADAU1701_SEROCTL_WORD_LEN_16	0x0002
 #define ADAU1701_SEROCTL_WORD_LEN_MASK	0x0003
 
 #define ADAU1701_AUXNPOW_VBPD		0x40
-- 
1.8.0
