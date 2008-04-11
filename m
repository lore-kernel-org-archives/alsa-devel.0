From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ASoC: Add support for 19.2 MHz MCLK in
	TLV320AIC3X
Date: Fri, 11 Apr 2008 11:32:15 +0300
Message-ID: <1207902735-6660-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id CEAAB246E7
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Apr 2008 10:31:53 +0200 (CEST)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m3B8VLDs017646
	for <alsa-devel@alsa-project.org>; Fri, 11 Apr 2008 11:31:51 +0300
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index e6a730b..630684f 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -661,42 +661,52 @@ struct aic3x_rate_divs {
 static const struct aic3x_rate_divs aic3x_divs[] = {
 	/* 8k */
 	{12000000, 8000, 48000, 0xa, 16, 3840},
+	{19200000, 8000, 48000, 0xa, 10, 2400},
 	{22579200, 8000, 48000, 0xa, 8, 7075},
 	{33868800, 8000, 48000, 0xa, 5, 8049},
 	/* 11.025k */
 	{12000000, 11025, 44100, 0x6, 15, 528},
+	{19200000, 11025, 44100, 0x6, 9, 4080},
 	{22579200, 11025, 44100, 0x6, 8, 0},
 	{33868800, 11025, 44100, 0x6, 5, 3333},
 	/* 16k */
 	{12000000, 16000, 48000, 0x4, 16, 3840},
+	{19200000, 16000, 48000, 0x4, 10, 2400},
 	{22579200, 16000, 48000, 0x4, 8, 7075},
 	{33868800, 16000, 48000, 0x4, 5, 8049},
 	/* 22.05k */
 	{12000000, 22050, 44100, 0x2, 15, 528},
+	{19200000, 22050, 44100, 0x2, 9, 4080},
 	{22579200, 22050, 44100, 0x2, 8, 0},
 	{33868800, 22050, 44100, 0x2, 5, 3333},
 	/* 32k */
 	{12000000, 32000, 48000, 0x1, 16, 3840},
+	{19200000, 32000, 48000, 0x1, 10, 2400},
 	{22579200, 32000, 48000, 0x1, 8, 7075},
 	{33868800, 32000, 48000, 0x1, 5, 8049},
 	/* 44.1k */
 	{12000000, 44100, 44100, 0x0, 15, 528},
+	{19200000, 44100, 44100, 0x0, 9, 4080},
 	{22579200, 44100, 44100, 0x0, 8, 0},
 	{33868800, 44100, 44100, 0x0, 5, 3333},
 	/* 48k */
 	{12000000, 48000, 48000, 0x0, 16, 3840},
+	{19200000, 48000, 48000, 0x0, 10, 2400},
 	{22579200, 48000, 48000, 0x0, 8, 7075},
 	{33868800, 48000, 48000, 0x0, 5, 8049},
 	/* 64k */
 	{12000000, 64000, 96000, 0x1, 16, 3840},
+	{19200000, 64000, 96000, 0x1, 10, 2400},
 	{22579200, 64000, 96000, 0x1, 8, 7075},
 	{33868800, 64000, 96000, 0x1, 5, 8049},
 	/* 88.2k */
 	{12000000, 88200, 88200, 0x0, 15, 528},
+	{19200000, 88200, 88200, 0x0, 9, 4080},
 	{22579200, 88200, 88200, 0x0, 8, 0},
 	{33868800, 88200, 88200, 0x0, 5, 3333},
 	/* 96k */
 	{12000000, 96000, 96000, 0x0, 16, 3840},
+	{19200000, 96000, 96000, 0x0, 10, 2400},
 	{22579200, 96000, 96000, 0x0, 8, 7075},
 	{33868800, 96000, 96000, 0x0, 5, 8049},
 };
@@ -818,6 +828,7 @@ static int aic3x_set_dai_sysclk(struct snd_soc_codec_dai *codec_dai,
 
 	switch (freq) {
 	case 12000000:
+	case 19200000:
 	case 22579200:
 	case 33868800:
 		aic3x->sysclk = freq;
-- 
1.5.4.4
