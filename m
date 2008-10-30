From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 8/8] ASoC: Disable automatic volume control in
	the CS4270 sound driver
Date: Thu, 30 Oct 2008 15:58:29 +0000
Message-ID: <1225382309-1827-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081030155718.GA1418@rakim.wolfsonmicro.main>
	<1225382309-1827-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CB672448A
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 16:58:32 +0100 (CET)
In-Reply-To: <1225382309-1827-7-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

From: Timur Tabi <timur@freescale.com>

Disable the automatic volume control feature of the CS4270 audio codec.  This
feature, which is enabled by default, causes volume change commands to be
delayed.  Sometimes the volume change happens after playback is started.

Signed-off-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4270.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 0bbd945..0ff476d 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -450,6 +450,19 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	/* Disable automatic volume control.  It's enabled by default, and
+	 * it causes volume change commands to be delayed, sometimes until
+	 * after playback has started.
+	 */
+
+	reg = cs4270_read_reg_cache(codec, CS4270_TRANS);
+	reg &= ~(CS4270_TRANS_SOFT | CS4270_TRANS_ZERO);
+	ret = cs4270_i2c_write(codec, CS4270_TRANS, reg);
+	if (ret < 0) {
+		printk(KERN_ERR "I2C write failed\n");
+		return ret;
+	}
+
 	/* Thaw and power-up the codec */
 
 	ret = snd_soc_write(codec, CS4270_PWRCTL, 0);
-- 
1.5.6.5
