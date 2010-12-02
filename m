From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 2/2] ASoC: tlv320dac33: Request for reordered
	update power sequence
Date: Thu,  2 Dec 2010 14:03:10 +0200
Message-ID: <1291291390-8669-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id E89DD103A83
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 13:03:16 +0100 (CET)
In-Reply-To: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
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

DAC33 codec emmits pop noise, when the bypass path enable bit
get changed.
By using the reordered sequence this pop noise can be filtered
out.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index ccb267f..31f7a22 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1416,6 +1416,7 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 	codec->control_data = dac33->control_data;
 	codec->hw_write = (hw_write_t) i2c_master_send;
 	codec->dapm.idle_bias_off = 1;
+	codec->dapm.dapm_reorder_pupdate = 1;
 	dac33->codec = codec;
 
 	/* Read the tlv320dac33 ID registers */
-- 
1.7.3.2
