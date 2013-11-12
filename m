From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8997: Correct typo in ISRC mux routes
Date: Tue, 12 Nov 2013 10:52:10 +0000
Message-ID: <1384253530-4123-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAC972616FA
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 12:07:05 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8997.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 6ec3de3..2e886ca 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -887,7 +887,7 @@ static const struct snd_soc_dapm_route wm8997_dapm_routes[] = {
 	ARIZONA_MIXER_ROUTES("Mic Mute Mixer", "Mic"),
 
 	ARIZONA_MUX_ROUTES("ISRC1INT1", "ISRC1INT1"),
-	ARIZONA_MUX_ROUTES("ISRC1INT2", "ISRC2INT2"),
+	ARIZONA_MUX_ROUTES("ISRC1INT2", "ISRC1INT2"),
 
 	ARIZONA_MUX_ROUTES("ISRC1DEC1", "ISRC1DEC1"),
 	ARIZONA_MUX_ROUTES("ISRC1DEC2", "ISRC1DEC2"),
-- 
1.7.2.5
