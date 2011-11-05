From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: wm9081: Don't write WM9081_BIAS_ENA
 bit to WM9081_VMID_CONTROL register
Date: Sat, 05 Nov 2011 14:49:21 +0800
Message-ID: <1320475761.8360.3.camel@phoenix>
References: <1320475639.8360.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5542024501
	for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2011 07:49:27 +0100 (CET)
Received: by iafi7 with SMTP id i7so3155283iaf.38
	for <alsa-devel@alsa-project.org>; Fri, 04 Nov 2011 23:49:26 -0700 (PDT)
In-Reply-To: <1320475639.8360.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

WM9081_BIAS_ENA is the bit[1] of WM9081_BIAS_CONTROL_1 register (05h).
Current code incorrectly write it to WM9081_VMID_CONTROL(04h) register.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm9081.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index fe65618..4a398c3 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -807,7 +807,6 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 			mdelay(100);
 
 			/* Normal bias enable & soft start off */
-			reg |= WM9081_BIAS_ENA;
 			reg &= ~WM9081_VMID_RAMP;
 			snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
 
@@ -830,14 +829,15 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		/* Startup bias source */
+		/* Startup bias source and disable bias */
 		reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
 		reg |= WM9081_BIAS_SRC;
+		reg &= ~WM9081_BIAS_ENA;
 		snd_soc_write(codec, WM9081_BIAS_CONTROL_1, reg);
 
-		/* Disable VMID and biases with soft ramping */
+		/* Disable VMID with soft ramping */
 		reg = snd_soc_read(codec, WM9081_VMID_CONTROL);
-		reg &= ~(WM9081_VMID_SEL_MASK | WM9081_BIAS_ENA);
+		reg &= ~WM9081_VMID_SEL_MASK;
 		reg |= WM9081_VMID_RAMP;
 		snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
 
-- 
1.7.5.4
