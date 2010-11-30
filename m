From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/5] ASoC: tpa6130a2: Defer SW enable from
	power enable
Date: Tue, 30 Nov 2010 16:00:01 +0200
Message-ID: <1291125604-10396-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id BDD27103979
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 15:00:12 +0100 (CET)
In-Reply-To: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
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

Do not enable the amplifier right after the power has been
restored to the amplifier.
The DAPM_SUPPLY widget turns on the amp early in the DAPM
power walk, and the unmuting of channel happens quite late.
Keeping the amp in SW reset state ensures better muting.
In this way the pop noise coming from other components (codec)
can be filtered out.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 199edf0..42887ae 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -151,11 +151,6 @@ static int tpa6130a2_power(u8 power)
 			data->power_state = 0;
 			goto exit;
 		}
-
-		/* Clear SWS */
-		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
-		val &= ~TPA6130A2_SWS;
-		tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
 	} else {
 		/* set SWS */
 		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
@@ -301,6 +296,7 @@ static void tpa6130a2_channel_enable(u8 channel, int enable)
 		/* Enable amplifier */
 		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
 		val |= channel;
+		val &= ~TPA6130A2_SWS;
 		tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
 
 		/* Unmute channel */
-- 
1.7.3.2
