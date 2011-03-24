From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Restore L/R DAC power
	control register
Date: Thu, 24 Mar 2011 08:58:05 +0200
Message-ID: <1300949885-12978-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id A364610397B
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 07:58:07 +0100 (CET)
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

Register 0x40, 0x41 need to be restored after power up, since
it contains gain related fields, which affects playback volume.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 93f38b1..6c3735d 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -324,6 +324,10 @@ static void dac33_init_chip(struct snd_soc_codec *codec)
 	dac33_write(codec, DAC33_OUT_AMP_CTRL,
 		    dac33_read_reg_cache(codec, DAC33_OUT_AMP_CTRL));
 
+	dac33_write(codec, DAC33_LDAC_PWR_CTRL,
+		    dac33_read_reg_cache(codec, DAC33_LDAC_PWR_CTRL));
+	dac33_write(codec, DAC33_RDAC_PWR_CTRL,
+		    dac33_read_reg_cache(codec, DAC33_RDAC_PWR_CTRL));
 }
 
 static inline int dac33_read_id(struct snd_soc_codec *codec)
-- 
1.7.4.1
