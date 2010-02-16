From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: tlv320dac33: Clearing FIFOFLUSH flag
	before playback
Date: Tue, 16 Feb 2010 13:23:15 +0200
Message-ID: <1266319396-25066-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1266319396-25066-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 68BC6243F6
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

In repeated playback the FIFOFLUSH bit remained set, and
never has been cleared.
Clear it during the setup phase.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 1b35d0c..dab7fd5 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -734,7 +734,10 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 
 	aictrl_a = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_A);
 	aictrl_a &= ~(DAC33_NCYCL_MASK | DAC33_WLEN_MASK);
+	/* Read FIFO control A, and clear FIFO flush bit */
 	fifoctrl_a = dac33_read_reg_cache(codec, DAC33_FIFO_CTRL_A);
+	fifoctrl_a &= ~DAC33_FIFOFLUSH;
+
 	fifoctrl_a &= ~DAC33_WIDTH;
 	switch (substream->runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-- 
1.7.0
