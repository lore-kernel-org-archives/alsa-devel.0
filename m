From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC v2 3/3] ASoC: tlv320dac33: Reverse the power up
	sequence for bypass switches
Date: Fri,  3 Dec 2010 15:31:13 +0200
Message-ID: <1291383073-16048-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1291383073-16048-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 7588B244CF
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 14:31:20 +0100 (CET)
In-Reply-To: <1291383073-16048-1-git-send-email-peter.ujfalusi@nokia.com>
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

Switching of the bypass on generates a pop noise.
Reverse the order of the power up sequence.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index ccb267f..2aec9e2 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -634,6 +634,10 @@ static int dac33_add_widgets(struct snd_soc_codec *codec)
 	/* set up audio path interconnects */
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
+	/* Reverse the power up sequence for bypass switches */
+	snd_soc_dapm_reverse_powerup_sequence(dapm, "Analog Left Bypass");
+	snd_soc_dapm_reverse_powerup_sequence(dapm, "Analog Right Bypass");
+
 	return 0;
 }
 
-- 
1.7.3.2
