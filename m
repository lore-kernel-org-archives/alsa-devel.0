From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: ak4641: Remove unused DAI ID defines
Date: Sat, 15 Oct 2016 21:32:39 +0200
Message-ID: <1476559961-23134-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 463962667EB
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 21:32:47 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DAI ID defines are back from the time when DAIs were referenced by a
numerical ID. These days a string is used for matching instead and the
defines are unused. This driver was merged after the change of DAIs are
matched was made and the IDs were never used and presumably never will be,
so remove them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ak4641.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/ak4641.h b/sound/soc/codecs/ak4641.h
index 4a26324..38b9e93 100644
--- a/sound/soc/codecs/ak4641.h
+++ b/sound/soc/codecs/ak4641.h
@@ -38,10 +38,4 @@
 
 #define AK4641_CACHEREGNUM	0x14
 
-
-
-#define AK4641_DAI_HIFI		0
-#define AK4641_DAI_VOICE	1
-
-
 #endif
-- 
2.1.4
