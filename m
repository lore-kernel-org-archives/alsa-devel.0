From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [2.6.30-rc2][PATCH 2/2] ASoC: OMAP: Fix FS polarity in
	OSK5912 machine driver
Date: Wed, 15 Apr 2009 13:48:17 +0300
Message-ID: <1239792497-31761-3-git-send-email-jarkko.nikula@nokia.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E5DC02445B
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 12:47:48 +0200 (CEST)
In-Reply-To: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Arun KS <arunks@mistralsolutions.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Using inverted FS polarity in OSK5912 must be an error since TLV320AIC23
do not have support for inverted polarities. This is mostly due the hassle
with the DSP formats in OMAP McBSP DAI and inversion on OMAP side probably
just made this configuration working at some point.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/osk5912.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index a952a4e..a4e149b 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -62,7 +62,7 @@ static int osk_hw_params(struct snd_pcm_substream *substream,
 	/* Set codec DAI configuration */
 	err = snd_soc_dai_set_fmt(codec_dai,
 				  SND_SOC_DAIFMT_DSP_B |
-				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM);
 	if (err < 0) {
 		printk(KERN_ERR "can't set codec DAI configuration\n");
@@ -72,7 +72,7 @@ static int osk_hw_params(struct snd_pcm_substream *substream,
 	/* Set cpu DAI configuration */
 	err = snd_soc_dai_set_fmt(cpu_dai,
 				  SND_SOC_DAIFMT_DSP_B |
-				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM);
 	if (err < 0) {
 		printk(KERN_ERR "can't set cpu DAI configuration\n");
-- 
1.6.2.1
