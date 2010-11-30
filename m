From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: tlv320dac33: Avoid multiple soft
	power up
Date: Tue, 30 Nov 2010 14:31:46 +0200
Message-ID: <1291120306-18445-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1291120306-18445-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id E2D1324493
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 13:31:56 +0100 (CET)
In-Reply-To: <1291120306-18445-1-git-send-email-peter.ujfalusi@nokia.com>
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

During playback start the codec has been already powered at
BIAS_ON event time, so there's no need to enable the codec again.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 080ec91..a0ba5d1 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -642,7 +642,8 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		dac33_soft_power(codec, 1);
+		if (!dac33->substream)
+			dac33_soft_power(codec, 1);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
-- 
1.7.3.2
