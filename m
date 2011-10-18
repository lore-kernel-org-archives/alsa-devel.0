From: axel <axel.lin@gmail.com>
Subject: [PATCH v2] ASoC: wm9081: Use snd_soc_update_bits for
 read-modify-write
Date: Tue, 18 Oct 2011 10:36:25 +0800
Message-ID: <1318905385.4228.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 079632433F
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 04:36:38 +0200 (CEST)
Received: by yws29 with SMTP id 29so146546yws.38
	for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2011 19:36:38 -0700 (PDT)
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

Use snd_soc_update_bits for read-modify-write register access instead of
open-coding it using snd_soc_read and snd_soc_write

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
v2:
For Initial cold start ( change bias level from SND_SOC_BIAS_OFF to
SND_SOC_BIAS_STANDBY ), the v1 does not set VMID_SEL[1:0] bits
correctly for Normal bias enable & soft start off.
In v2 we also clear VMID_SEL[1:0] bits for Normal bias enable & soft start off.
We did clear VMID_SEL[1:0] bits in SND_SOC_BIAS_OFF,
thus we know the VMID_SEL[1:0] bits status is 0b00 in this case.

 sound/soc/codecs/wm9081.c |   82 +++++++++++++++++++-------------------------
 1 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 66092ef..9c38ddb 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -766,84 +766,73 @@ static const struct snd_soc_dapm_route wm9081_audio_paths[] = {
 static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 reg;
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
 		/* VMID=2*40k */
-		reg = snd_soc_read(codec, WM9081_VMID_CONTROL);
-		reg &= ~WM9081_VMID_SEL_MASK;
-		reg |= 0x2;
-		snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
+		snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
+				    WM9081_VMID_SEL_MASK, 0x2);
 
 		/* Normal bias current */
-		reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
-		reg &= ~WM9081_STBY_BIAS_ENA;
-		snd_soc_write(codec, WM9081_BIAS_CONTROL_1, reg);
+		snd_soc_update_bits(codec, WM9081_BIAS_CONTROL_1,
+				    WM9081_STBY_BIAS_ENA, 0);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
 		/* Initial cold start */
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Disable LINEOUT discharge */
-			reg = snd_soc_read(codec, WM9081_ANTI_POP_CONTROL);
-			reg &= ~WM9081_LINEOUT_DISCH;
-			snd_soc_write(codec, WM9081_ANTI_POP_CONTROL, reg);
+			snd_soc_update_bits(codec, WM9081_ANTI_POP_CONTROL,
+					    WM9081_LINEOUT_DISCH, 0);
 
 			/* Select startup bias source */
-			reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
-			reg |= WM9081_BIAS_SRC | WM9081_BIAS_ENA;
-			snd_soc_write(codec, WM9081_BIAS_CONTROL_1, reg);
+			snd_soc_update_bits(codec, WM9081_BIAS_CONTROL_1,
+					    WM9081_BIAS_SRC | WM9081_BIAS_ENA,
+					    WM9081_BIAS_SRC | WM9081_BIAS_ENA);
 
 			/* VMID 2*4k; Soft VMID ramp enable */
-			reg = snd_soc_read(codec, WM9081_VMID_CONTROL);
-			reg |= WM9081_VMID_RAMP | 0x6;
-			snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
-
+			snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
+					    WM9081_VMID_RAMP | 0x6,
+					    WM9081_VMID_RAMP | 0x6);
 			mdelay(100);
 
 			/* Normal bias enable & soft start off */
-			reg |= WM9081_BIAS_ENA;
-			reg &= ~WM9081_VMID_RAMP;
-			snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
+			snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
+					    WM9081_VMID_RAMP | WM9081_BIAS_ENA |
+					    WM9081_VMID_SEL_MASK,
+					    WM9081_BIAS_ENA);
 
 			/* Standard bias source */
-			reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
-			reg &= ~WM9081_BIAS_SRC;
-			snd_soc_write(codec, WM9081_BIAS_CONTROL_1, reg);
+			snd_soc_update_bits(codec, WM9081_BIAS_CONTROL_1,
+					    WM9081_BIAS_SRC, 0);
 		}
 
 		/* VMID 2*240k */
-		reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
-		reg &= ~WM9081_VMID_SEL_MASK;
-		reg |= 0x04;
-		snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
+		snd_soc_update_bits(codec, WM9081_BIAS_CONTROL_1,
+				    WM9081_VMID_SEL_MASK, 0x04);
 
 		/* Standby bias current on */
-		reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
-		reg |= WM9081_STBY_BIAS_ENA;
-		snd_soc_write(codec, WM9081_BIAS_CONTROL_1, reg);
+		snd_soc_update_bits(codec, WM9081_BIAS_CONTROL_1,
+				    WM9081_STBY_BIAS_ENA,
+				    WM9081_STBY_BIAS_ENA);
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		/* Startup bias source */
-		reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
-		reg |= WM9081_BIAS_SRC;
-		snd_soc_write(codec, WM9081_BIAS_CONTROL_1, reg);
+		snd_soc_update_bits(codec, WM9081_BIAS_CONTROL_1,
+				    WM9081_BIAS_SRC, WM9081_BIAS_SRC);
 
 		/* Disable VMID and biases with soft ramping */
-		reg = snd_soc_read(codec, WM9081_VMID_CONTROL);
-		reg &= ~(WM9081_VMID_SEL_MASK | WM9081_BIAS_ENA);
-		reg |= WM9081_VMID_RAMP;
-		snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
+		snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
+				    WM9081_VMID_RAMP | WM9081_VMID_SEL_MASK |
+				    WM9081_BIAS_ENA, WM9081_VMID_RAMP);
 
 		/* Actively discharge LINEOUT */
-		reg = snd_soc_read(codec, WM9081_ANTI_POP_CONTROL);
-		reg |= WM9081_LINEOUT_DISCH;
-		snd_soc_write(codec, WM9081_ANTI_POP_CONTROL, reg);
+		snd_soc_update_bits(codec, WM9081_ANTI_POP_CONTROL,
+				    WM9081_LINEOUT_DISCH,
+				    WM9081_LINEOUT_DISCH);
 		break;
 	}
 
@@ -1242,11 +1231,10 @@ static int wm9081_probe(struct snd_soc_codec *codec)
 	wm9081_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Enable zero cross by default */
-	reg = snd_soc_read(codec, WM9081_ANALOGUE_LINEOUT);
-	snd_soc_write(codec, WM9081_ANALOGUE_LINEOUT, reg | WM9081_LINEOUTZC);
-	reg = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_PGA);
-	snd_soc_write(codec, WM9081_ANALOGUE_SPEAKER_PGA,
-		     reg | WM9081_SPKPGAZC);
+	snd_soc_update_bits(codec, WM9081_ANALOGUE_LINEOUT,
+			    WM9081_LINEOUTZC, WM9081_LINEOUTZC);
+	snd_soc_update_bits(codec, WM9081_ANALOGUE_SPEAKER_PGA,
+			    WM9081_SPKPGAZC, WM9081_SPKPGAZC);
 
 	snd_soc_add_controls(codec, wm9081_snd_controls,
 			     ARRAY_SIZE(wm9081_snd_controls));
-- 
1.7.5.4
