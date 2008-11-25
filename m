From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 02/13] ASoC: TWL4030: Disable soft-volume
Date: Tue, 25 Nov 2008 15:44:38 +0000
Message-ID: <1227627889-8373-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081125154302.GA8319@rakim.wolfsonmicro.main>
	<1227627889-8373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 535D32448E
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:44:51 +0100 (CET)
In-Reply-To: <1227627889-8373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Keep Soft-volume disabled for now, since if it is enabled
the FGAIN volume controls are not working in the current
configuration:
CODEC_MODE:OPT_MODE = 1
OPTION:ARXR2_EN = 1
OPTION:ARXL2_EN = 1
OPTION:ARXR1_EN = 0
OPTION:ARXL1_VRX_EN = 0
RX_PATH_SEL:RXL1_SEL = 0x0 (or 0x1)
RX_PATH_SEL:RXR1_SEL = 0x0 (or 0x1)

After the patch, FGAIN volume control works.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 3348951..49c7da3 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -87,7 +87,7 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_ALC_SET1		(0x2C)	*/
 	0x00, /* REG_ALC_SET2		(0x2D)	*/
 	0x00, /* REG_BOOST_CTL		(0x2E)	*/
-	0x01, /* REG_SOFTVOL_CTL	(0x2F)	*/
+	0x00, /* REG_SOFTVOL_CTL	(0x2F)	*/
 	0x00, /* REG_DTMF_FREQSEL	(0x30)	*/
 	0x00, /* REG_DTMF_TONEXT1H	(0x31)	*/
 	0x00, /* REG_DTMF_TONEXT1L	(0x32)	*/
-- 
1.5.6.5
