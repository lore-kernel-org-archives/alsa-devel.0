From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/3] ASoC: osk5912: Use the correct DSP_A mode
Date: Thu,  9 Apr 2009 12:34:42 +0300
Message-ID: <1239269682-21309-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1239269682-21309-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239269682-21309-2-git-send-email-peter.ujfalusi@nokia.com>
	<1239269682-21309-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id BF2A7103873
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 11:35:12 +0200 (CEST)
In-Reply-To: <1239269682-21309-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: jarkko.nikula@nokia.com, broonie@opensource.wolfsonmicro.com, arunks@mistralsolutions.com
List-Id: alsa-devel@alsa-project.org

Use DSP_A format with correct clock, frame sync polarity.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/osk5912.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index a952a4e..d67e77e 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -61,8 +61,8 @@ static int osk_hw_params(struct snd_pcm_substream *substream,
 
 	/* Set codec DAI configuration */
 	err = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_DSP_B |
-				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_DSP_A |
+				  SND_SOC_DAIFMT_IB_IF |
 				  SND_SOC_DAIFMT_CBM_CFM);
 	if (err < 0) {
 		printk(KERN_ERR "can't set codec DAI configuration\n");
@@ -71,8 +71,8 @@ static int osk_hw_params(struct snd_pcm_substream *substream,
 
 	/* Set cpu DAI configuration */
 	err = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_DSP_B |
-				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_DSP_A |
+				  SND_SOC_DAIFMT_IB_IF |
 				  SND_SOC_DAIFMT_CBM_CFM);
 	if (err < 0) {
 		printk(KERN_ERR "can't set cpu DAI configuration\n");
-- 
1.6.2.2
