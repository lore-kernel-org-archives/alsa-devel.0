From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Limit the US_TO_SAMPLES
	macro
Date: Fri, 29 Oct 2010 14:07:25 +0300
Message-ID: <1288350445-17913-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id C35F6243B4
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 13:07:24 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Limit the time window to maximum 1s in the macro.
The driver deals with much shorter times (<200ms).
This will fix a rare division by zero bug in Mode1.
This could happen, when the work is not executed in
time (within mode1_latency) after the interrupt.
In this case the DAC33 will not receive the needed
nSample command in time, and enters to an unknown
state, and won't recover.
In such event the time window will increase, and
eventually going to be bigger than 1s, resulting
devision by zero.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 6778e2e..c5ab8c8 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -58,7 +58,7 @@
 	(1000000000 / ((rate * 1000) / samples))
 
 #define US_TO_SAMPLES(rate, us) \
-	(rate / (1000000 / us))
+	(rate / (1000000 / (us < 1000000 ? us : 1000000)))
 
 #define UTHR_FROM_PERIOD_SIZE(samples, playrate, burstrate) \
 	((samples * 5000) / ((burstrate * 5000) / (burstrate - playrate)))
-- 
1.7.3.2
