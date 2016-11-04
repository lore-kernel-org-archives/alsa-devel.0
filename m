From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] ASoC: stac9766: Remove unused DAI ID
	defines
Date: Fri,  4 Nov 2016 18:26:53 +0100
Message-ID: <1478280417-24832-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BF9A266623
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 18:27:10 +0100 (CET)
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
numerical ID. These days a string is used instead and the defines are
unused.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/stac9766.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/stac9766.h b/sound/soc/codecs/stac9766.h
index c726f90..cb0d550 100644
--- a/sound/soc/codecs/stac9766.h
+++ b/sound/soc/codecs/stac9766.h
@@ -10,8 +10,4 @@
 #define AC97_STAC_ANALOG_SPECIAL (AC97_STAC_PAGE0 | 0x6E)
 #define AC97_STAC_STEREO_MIC 0x78
 
-/* STAC9766 DAI ID's */
-#define STAC9766_DAI_AC97_ANALOG		0
-#define STAC9766_DAI_AC97_DIGITAL		1
-
 #endif
-- 
2.1.4
