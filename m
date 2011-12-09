From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix comments for disabling amplifier and
	PGA
Date: Fri, 09 Dec 2011 18:43:20 +0800
Message-ID: <1323427400.3099.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A53CB103807
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 11:43:31 +0100 (CET)
Received: by ggnv5 with SMTP id v5so3112610ggn.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Dec 2011 02:43:30 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8961.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index dc087c1..58fbf0a 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -422,11 +422,11 @@ static int wm8961_spk_event(struct snd_soc_dapm_widget *w,
 	}
 
 	if (event & SND_SOC_DAPM_PRE_PMD) {
-		/* Enable the amplifier */
+		/* Disable the amplifier */
 		spk_reg &= ~(WM8961_SPKL_ENA | WM8961_SPKR_ENA);
 		snd_soc_write(codec, WM8961_CLASS_D_CONTROL_1, spk_reg);
 
-		/* Enable the PGA */
+		/* Disable the PGA */
 		pwr_reg &= ~(WM8961_SPKL_PGA | WM8961_SPKR_PGA);
 		snd_soc_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
 	}
-- 
1.7.5.4
