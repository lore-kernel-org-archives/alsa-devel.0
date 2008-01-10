From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 02/17] Fix inverted Bass, Treble,
	Mono volume and Phone volume WM9712 mixer controls.
Date: Thu, 10 Jan 2008 13:17:00 +0000
Message-ID: <1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id A9F7D2458B
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:19 +0100 (CET)
In-Reply-To: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Joe Sauer <jsauer@vernier.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Joe Sauer <jsauer@vernier.com>

Signed-off-by: Joe Sauer <jsauer@vernier.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9712.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 986b5d5..111c266 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -102,7 +102,7 @@ SOC_SINGLE("Speaker Playback ZC Switch", AC97_MASTER, 7, 1, 0),
 SOC_SINGLE("Speaker Playback Invert Switch", AC97_MASTER, 6, 1, 0),
 SOC_SINGLE("Headphone Playback ZC Switch", AC97_HEADPHONE, 7, 1, 0),
 SOC_SINGLE("Mono Playback ZC Switch", AC97_MASTER_MONO, 7, 1, 0),
-SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 0),
+SOC_SINGLE("Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1),
 
 SOC_SINGLE("ALC Target Volume", AC97_CODEC_CLASS_REV, 12, 15, 0),
 SOC_SINGLE("ALC Hold Time", AC97_CODEC_CLASS_REV, 8, 15, 0),
@@ -131,7 +131,7 @@ SOC_SINGLE("Aux Playback Headphone Volume", AC97_CD, 12, 7, 1),
 SOC_SINGLE("Aux Playback Speaker Volume", AC97_CD, 8, 7, 1),
 SOC_SINGLE("Aux Playback Phone Volume", AC97_CD, 4, 7, 1),
 
-SOC_SINGLE("Phone Volume", AC97_PHONE, 0, 15, 0),
+SOC_SINGLE("Phone Volume", AC97_PHONE, 0, 15, 1),
 SOC_DOUBLE("Line Capture Volume", AC97_LINE, 8, 0, 31, 1),
 
 SOC_SINGLE("Capture 20dB Boost Switch", AC97_REC_SEL, 14, 1, 0),
@@ -145,8 +145,8 @@ SOC_ENUM("Bass Control", wm9712_enum[5]),
 SOC_SINGLE("Bass Cut-off Switch", AC97_MASTER_TONE, 12, 1, 1),
 SOC_SINGLE("Tone Cut-off Switch", AC97_MASTER_TONE, 4, 1, 1),
 SOC_SINGLE("Playback Attenuate (-6dB) Switch", AC97_MASTER_TONE, 6, 1, 0),
-SOC_SINGLE("Bass Volume", AC97_MASTER_TONE, 8, 15, 0),
-SOC_SINGLE("Treble Volume", AC97_MASTER_TONE, 0, 15, 0),
+SOC_SINGLE("Bass Volume", AC97_MASTER_TONE, 8, 15, 1),
+SOC_SINGLE("Treble Volume", AC97_MASTER_TONE, 0, 15, 1),
 
 SOC_SINGLE("Capture ADC Switch", AC97_REC_GAIN, 15, 1, 1),
 SOC_ENUM("Capture Volume Steps", wm9712_enum[6]),
-- 
1.5.3.8
