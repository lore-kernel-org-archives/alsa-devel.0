From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH 1/2] ASoC: OMAP: Apply channel
	constrains to N810 machine driver
Date: Tue, 25 Nov 2008 12:45:08 +0200
Message-ID: <1227609909-25273-2-git-send-email-jarkko.nikula@nokia.com>
References: <1227609909-25273-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A369224399
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 11:46:01 +0100 (CET)
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com
	[10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mAPAjb7W009924
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 04:45:58 -0600
In-Reply-To: <1227609909-25273-1-git-send-email-jarkko.nikula@nokia.com>
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

Prepare for upcoming McBSP DAI update adding support for mono links by
restricting number of channels to 2 in N810. This is due tlv320aic3x which
claims channels_min = 1 and playing pure mono audio over I2S would cause
it to be played only from left channel if both cpu and codec DAI's claim to
support mono.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/n810.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index d216b4f..18e2062 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -70,9 +70,13 @@ static void n810_ext_control(struct snd_soc_codec *codec)
 
 static int n810_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->socdev->codec;
 
+	snd_pcm_hw_constraint_minmax(runtime,
+				     SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
+
 	n810_ext_control(codec);
 	return clk_enable(sys_clkout2);
 }
-- 
1.5.6.5
