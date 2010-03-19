From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: tlv320dac33: Internal clocking
	changes
Date: Fri, 19 Mar 2010 11:10:20 +0200
Message-ID: <1268989820-18262-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1268989820-18262-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F1601038D2
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 10:10:46 +0100 (CET)
In-Reply-To: <1268989820-18262-1-git-send-email-peter.ujfalusi@nokia.com>
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

During validation of the internal clocking setup it has
been found that the following settings were not configured
in an optimal way:

ASRC_CTRL_A: SRCLKDIV was incorrect, instad of divide ratio 3,
             ratio of 2 has to be used (as the comment stated)
DAC_CTRL_A: Fs = Fsref is the desired configuration instead of
            Fs = Fsref / 1.5

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index f5dbed2..ee2e1e3 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -762,7 +762,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 	if (dac33->fifo_mode) {
 		/* Generic for all FIFO modes */
 		/* 50-51 : ASRC Control registers */
-		dac33_write(codec, DAC33_ASRC_CTRL_A, (1 << 4)); /* div=2 */
+		dac33_write(codec, DAC33_ASRC_CTRL_A, DAC33_SRCLKDIV(1));
 		dac33_write(codec, DAC33_ASRC_CTRL_B, 1); /* ??? */
 
 		/* Write registers 0x34 and 0x35 (MSB, LSB) */
@@ -1052,7 +1052,7 @@ static void dac33_init_chip(struct snd_soc_codec *codec)
 {
 	/* 44-46: DAC Control Registers */
 	/* A : DAC sample rate Fsref/1.5 */
-	dac33_write(codec, DAC33_DAC_CTRL_A, DAC33_DACRATE(1));
+	dac33_write(codec, DAC33_DAC_CTRL_A, DAC33_DACRATE(0));
 	/* B : DAC src=normal, not muted */
 	dac33_write(codec, DAC33_DAC_CTRL_B, DAC33_DACSRCR_RIGHT |
 					     DAC33_DACSRCL_LEFT);
-- 
1.7.0.2
