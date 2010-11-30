From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: tlv320dac33: Do not enable the codec
	in init_chip
Date: Tue, 30 Nov 2010 14:31:45 +0200
Message-ID: <1291120306-18445-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1291120306-18445-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 8183A103904
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 13:31:55 +0100 (CET)
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

No need to enable the codec at this time.
The codec will be enabled  later by other events

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index ccb267f..080ec91 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -315,8 +315,6 @@ static void dac33_init_chip(struct snd_soc_codec *codec)
 	 clock source = internal osc (?) */
 	dac33_write(codec, DAC33_ANA_VOL_SOFT_STEP_CTRL, DAC33_VOLCLKEN);
 
-	dac33_write(codec, DAC33_PWR_CTRL, DAC33_PDNALLB);
-
 	/* Restore only selected registers (gains mostly) */
 	dac33_write(codec, DAC33_LDAC_DIG_VOL_CTRL,
 		    dac33_read_reg_cache(codec, DAC33_LDAC_DIG_VOL_CTRL));
-- 
1.7.3.2
