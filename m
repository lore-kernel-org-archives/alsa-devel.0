From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: Disable soft-volume
Date: Mon, 24 Nov 2008 08:25:45 +0200
Message-ID: <1227507945-9295-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BC6824539
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 07:25:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

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
1.6.0.3
