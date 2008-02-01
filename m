From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Mono voice playback volume for WM8753
Date: Fri,  1 Feb 2008 11:18:31 +0000
Message-ID: <1201864711-28471-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 33734243FC
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 12:18:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Montour <mail@mmontour.net>, Werner Almesberger <werner@openmoko.org>
List-Id: alsa-devel@alsa-project.org

From: Mike Montour <mail@mmontour.net>

Voice playback volume is in register bits 0:2, not 4:6.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Werner Almesberger <werner@openmoko.org>
---
I don't have a Signed-off-by from Mike but the change is sufficiently
obvious.

 sound/soc/codecs/wm8753.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index ba16375..0f23659 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -280,7 +280,7 @@ SOC_DOUBLE_R("Speaker Playback ZC Switch", WM8753_LOUT2V, WM8753_ROUT2V, 7, 1, 0
 
 SOC_SINGLE("Mono Bypass Playback Volume", WM8753_MOUTM1, 4, 7, 1),
 SOC_SINGLE("Mono Sidetone Playback Volume", WM8753_MOUTM2, 4, 7, 1),
-SOC_SINGLE("Mono Voice Playback Volume", WM8753_MOUTM2, 4, 7, 1),
+SOC_SINGLE("Mono Voice Playback Volume", WM8753_MOUTM2, 0, 7, 1),
 SOC_SINGLE("Mono Playback ZC Switch", WM8753_MOUTV, 7, 1, 0),
 
 SOC_ENUM("Bass Boost", wm8753_enum[0]),
-- 
1.5.3.8
