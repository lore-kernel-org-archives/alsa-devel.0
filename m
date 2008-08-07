From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ALSA: ASoC V2: disable automatic volume
	control in the CS4270 sound driver
Date: Thu,  7 Aug 2008 11:22:32 -0500
Message-ID: <1218126153-26095-2-git-send-email-timur@freescale.com>
References: <1218126153-26095-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 39926248F9
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Aug 2008 18:22:41 +0200 (CEST)
In-Reply-To: <1218126153-26095-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lg@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Disable the automatic volume control feature of the CS4270 audio codec.  This
feature, which is enabled by default, causes volume change commands to be
delayed.  Sometimes the volume change happens after playback is started.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for ASoC V2.

 sound/soc/codecs/cs4270.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index df3294d..e1c3fbd 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -430,6 +430,19 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
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
+		dev_err(codec->dev, "I2C write failed\n");
+		return ret;
+	}
+
 	/* Thaw and power-up the codec */
 
 	ret = cs4270_i2c_write(codec, CS4270_PWRCTL, 0);
-- 
1.5.5
