From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2] ASoC: tlv320dac33: Lower the OSC
	calibration time
Date: Tue, 12 Apr 2011 09:09:17 +0300
Message-ID: <1302588557-6072-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id E8F3810387E
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 08:09:22 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

To get correct calibration, we can decrease the time
needed for the OSC to calibrate itself.
With this change we can save ~15ms in the OSC
calibration phase.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Hi,

Changes: typo fix in the commit message.

 sound/soc/codecs/tlv320dac33.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index c109f6d..401a7ce 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -946,8 +946,8 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 	/* Write registers 0x08 and 0x09 (MSB, LSB) */
 	dac33_write16(codec, DAC33_INT_OSC_FREQ_RAT_A, oscset);
 
-	/* calib time: 128 is a nice number ;) */
-	dac33_write(codec, DAC33_CALIB_TIME, 128);
+	/* OSC calibration time */
+	dac33_write(codec, DAC33_CALIB_TIME, 96);
 
 	/* adjustment treshold & step */
 	dac33_write(codec, DAC33_INT_OSC_CTRL_B, DAC33_ADJTHRSHLD(2) |
-- 
1.7.4.1
