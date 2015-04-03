From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5102: Remove set of volume update bits
	for output 3R
Date: Fri,  3 Apr 2015 18:28:32 +0100
Message-ID: <1428082112-2390-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E18822604EA
 for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2015 19:33:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The earpiece on wm5102 is mono, thus there is no output 3R. Don't toggle
the volume update bits for this output, although worth noting that doing
so had no negative effects it is just redundant.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 6d0fe0a..0c6d1bc 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1861,7 +1861,6 @@ static unsigned int wm5102_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_2L,
 	ARIZONA_DAC_DIGITAL_VOLUME_2R,
 	ARIZONA_DAC_DIGITAL_VOLUME_3L,
-	ARIZONA_DAC_DIGITAL_VOLUME_3R,
 	ARIZONA_DAC_DIGITAL_VOLUME_4L,
 	ARIZONA_DAC_DIGITAL_VOLUME_4R,
 	ARIZONA_DAC_DIGITAL_VOLUME_5L,
-- 
1.7.2.5
