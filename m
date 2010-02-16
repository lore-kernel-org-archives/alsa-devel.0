From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: tlv320dac33: Correct the OSCSET
	calculation
Date: Tue, 16 Feb 2010 13:23:16 +0200
Message-ID: <1266319396-25066-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1266319396-25066-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C436243F9
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 12:23:27 +0100 (CET)
In-Reply-To: <1266319396-25066-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

OSCSET calculation was not correct in case of 44.1KHz
sampling rate.
With small adjustment both 48 and 44.1 KHz calculation
now gives the correct value.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index dab7fd5..f9f367d 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -700,7 +700,7 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 }
 
 #define CALC_OSCSET(rate, refclk) ( \
-	((((rate * 10000) / refclk) * 4096) + 5000) / 10000)
+	((((rate * 10000) / refclk) * 4096) + 7000) / 10000)
 #define CALC_RATIOSET(rate, refclk) ( \
 	((((refclk  * 100000) / rate) * 16384) + 50000) / 100000)
 
-- 
1.7.0
