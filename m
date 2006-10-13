From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH] ASoC DAI capabilities labelling
Date: Fri, 13 Oct 2006 11:17:37 +0100
Message-ID: <1160734657.4171.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-0BDYGi2btha3Ss+N0k8q"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-0BDYGi2btha3Ss+N0k8q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch suggested by Takashi changes the DAI capabilities definitions
in pxa-i2s.c, at91rm9200-i2s.c, wm8731.c, wm8750.c and wm9712.c to use a
label = value style.

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>


--=-0BDYGi2btha3Ss+N0k8q
Content-Disposition: attachment; filename=asoc-label.patch
Content-Type: text/x-patch; name=asoc-label.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 98ae850eb995 soc/at91/at91rm9200-i2s.c
--- a/soc/at91/at91rm9200-i2s.c	Thu Oct 12 14:34:32 2006 +0200
+++ b/soc/at91/at91rm9200-i2s.c	Thu Oct 12 13:47:01 2006 +0100
@@ -51,24 +51,52 @@ static struct snd_soc_dai_mode at91rm920
 static struct snd_soc_dai_mode at91rm9200_i2s[] = {
 
 	/* 8k: BCLK = (MCLK/10) = (60MHz/50) = 1.2MHz */
-	{ AT91RM9200_I2S_DAIFMT, SND_SOC_DAITDM_LRDW(0,0),
-		SNDRV_PCM_FMTBIT_S16_LE, SNDRV_PCM_RATE_8000, AT91RM9200_I2S_DIR,
-		SND_SOC_DAI_BFS_DIV, 1500, SND_SOC_FSBD(10), (25 << 16 | 74) },
+	{
+		.fmt = AT91RM9200_I2S_DAIFMT, 
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE, 
+		.pcmrate = SNDRV_PCM_RATE_8000, 
+		.pcmdir = AT91RM9200_I2S_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV,
+		.fs = 1500,
+		.bfs = SND_SOC_FSBD(10),
+		.priv = (25 << 16 | 74),
+	},
 
 	/* 16k: BCLK = (MCLK/3) ~= (60MHz/14) = 4.285714MHz */
-	{ AT91RM9200_I2S_DAIFMT, SND_SOC_DAITDM_LRDW(0,0),
-		SNDRV_PCM_FMTBIT_S16_LE, SNDRV_PCM_RATE_16000, AT91RM9200_I2S_DIR,
-		SND_SOC_DAI_BFS_DIV, 750, SND_SOC_FSBD(3) , (7 << 16 | 133) },
+	{ 
+		.fmt = AT91RM9200_I2S_DAIFMT,
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
+		.pcmrate = SNDRV_PCM_RATE_16000,
+		.pcmdir = AT91RM9200_I2S_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 750, 
+		.bfs = SND_SOC_FSBD(3),
+		.flags (7 << 16 | 133),
+	},
 
 	/* 24k: BCLK = (MCLK/10) = (60MHz/50) = 1.2MHz */
-	{ AT91RM9200_I2S_DAIFMT, SND_SOC_DAITDM_LRDW(0,0),
-		SNDRV_PCM_FMTBIT_S16_LE, SNDRV_PCM_RATE_22050, AT91RM9200_I2S_DIR,
-		SND_SOC_DAI_BFS_DIV, 500, SND_SOC_FSBD(10), (25 << 16 | 24) },
+	{ 
+		.fmt = AT91RM9200_I2S_DAIFMT,
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE, 
+		.pcmrate = SNDRV_PCM_RATE_22050, 
+		.pcmdir = AT91RM9200_I2S_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 500, 
+		.bfs = SND_SOC_FSBD(10), 
+		.priv = (25 << 16 | 24),
+	},
 
 	/* 48kHz: BCLK = (MCLK/5) ~= (60MHz/26) = 2.3076923MHz */
-	{ AT91RM9200_I2S_DAIFMT, SND_SOC_DAITDM_LRDW(0,0),
-		SNDRV_PCM_FMTBIT_S16_LE, SNDRV_PCM_RATE_48000, AT91RM9200_I2S_DIR,
-		SND_SOC_DAI_BFS_DIV, 250, SND_SOC_FSBD(5), (13 << 16 | 23) },
+	{ 
+		.fmt = AT91RM9200_I2S_DAIFMT,
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
+		.pcmrate = SNDRV_PCM_RATE_48000, 
+		.pcmdir = AT91RM9200_I2S_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 250, 
+		.bfs SND_SOC_FSBD(5), 
+		.priv = (13 << 16 | 23),
+	},
 };
 
 
diff -r 98ae850eb995 soc/codecs/wm8731.c
--- a/soc/codecs/wm8731.c	Thu Oct 12 14:34:32 2006 +0200
+++ b/soc/codecs/wm8731.c	Fri Oct 13 10:54:13 2006 +0100
@@ -85,74 +85,160 @@ static struct snd_soc_dai_mode wm8731_mo
 static struct snd_soc_dai_mode wm8731_modes[] = {
 	/* codec frame and clock master modes */
 	/* 8k */
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_8000, WM8731_DIR, 0,
-		1536, SND_SOC_FSB(64)},
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_8000, WM8731_DIR, 0,
-		2304, SND_SOC_FSB(64)},
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_8000, WM8731_DIR, 0,
-		1408, SND_SOC_FSB(64)},
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_8000, WM8731_DIR, 0,
-		2112, SND_SOC_FSB(64)},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_8000, 
+		.pcmdir = WM8731_DIR,
+		.fs = 1536, 
+		.bfs = SND_SOC_FSB(64),
+	},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_8000, 
+		.pcmdir = WM8731_DIR,
+		.fs = 2304, 
+		.bfs = SND_SOC_FSB(64),
+	},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_8000, 
+		.pcmdir = WM8731_DIR,
+		.fs = 1408, 
+		.bfs = SND_SOC_FSB(64),
+	},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_8000, 
+		.pcmdir = WM8731_DIR,
+		.fs = 2112, 
+		.bfs = SND_SOC_FSB(64),
+	},
 
 	/* 32k */
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_32000, WM8731_DIR, 0,
-		384, SND_SOC_FSB(64)},
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_32000, WM8731_DIR, 0,
-		576, SND_SOC_FSB(64)},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_32000,
+		.pcmdir = WM8731_DIR,
+		.fs = 384, 
+		.bfs = SND_SOC_FSB(64),
+	},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_32000, 
+		.pcmdir = WM8731_DIR,
+		.fs = 576, 
+		.bfs = SND_SOC_FSB(64),
+	},
 
 	/* 44.1k & 48k */
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
-		WM8731_DIR, 0, 256, SND_SOC_FSB(64)},
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
-		WM8731_DIR, 0, 384, SND_SOC_FSB(64)},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+		.pcmdir = WM8731_DIR,
+		.fs = 256, 
+		.bfs = SND_SOC_FSB(64),
+	},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+		.pcmdir = WM8731_DIR,
+		.fs = 384, 
+		.bfs = SND_SOC_FSB(64),
+	},
 
 	/* 88.2 & 96k */
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
-		WM8731_DIR, 0, 128, SND_SOC_FSB(64)},
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
-		WM8731_DIR, 0, 192, SND_SOC_FSB(64)},
-
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
+		.pcmdir = WM8731_DIR,
+		.fs = 128, 
+		.bfs = SND_SOC_FSB(64),
+		
+	},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
+		.pcmdir = WM8731_DIR,
+		.fs = 192, 
+		.bfs = SND_SOC_FSB(64),
+	},
 
 	/* USB codec frame and clock master modes */
 	/* 8k */
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_8000, WM8731_DIR,
-		SND_SOC_DAI_BFS_DIV, 1500, SND_SOC_FSBD(1)},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_8000, 
+		.pcmdir = WM8731_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 1500, 
+		.bfs = SND_SOC_FSBD(1),
+	},
 
 	/* 44.1k */
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_44100, WM8731_DIR,
-		SND_SOC_DAI_BFS_DIV, 272, SND_SOC_FSBD(1)},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_44100, 
+		.pcmdir = WM8731_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV,
+		.fs = 272, 
+		.bfs = SND_SOC_FSBD(1),
+	},
 
 	/* 48k */
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_48000, WM8731_DIR,
-		SND_SOC_DAI_BFS_DIV, 250, SND_SOC_FSBD(1)},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_48000, 
+		.pcmdir = WM8731_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 250, 
+		.bfs = SND_SOC_FSBD(1),
+	},
 
 	/* 88.2k */
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_88200, WM8731_DIR,
-		SND_SOC_DAI_BFS_DIV, 136, SND_SOC_FSBD(1)},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, 
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_88200, 
+		.pcmdir = WM8731_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV,
+		.fs = 136, 
+		.bfs = SND_SOC_FSBD(1),
+	},
 
 	/* 96k */
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, SNDRV_PCM_RATE_96000, WM8731_DIR,
-		SND_SOC_DAI_BFS_DIV, 125, SND_SOC_FSBD(1)},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_96000, 
+		.pcmdir = WM8731_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 125, 
+		.bfs = SND_SOC_FSBD(1),
+	},
 
 	/* codec frame and clock slave modes */
-	{WM8731_DAIFMT | SND_SOC_DAIFMT_CBS_CFS, SND_SOC_DAITDM_LRDW(0,0),
-		WM8731_HIFI_BITS, WM8731_RATES, WM8731_DIR, SND_SOC_DAI_BFS_DIV,
-		SND_SOC_FS_ALL, SND_SOC_FSBD_ALL},
+	{
+		.fmt = WM8731_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
+		.pcmfmt = WM8731_HIFI_BITS, 
+		.pcmrate = WM8731_RATES, 
+		.pcmdir = WM8731_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV,
+		.fs = SND_SOC_FS_ALL, 
+		.bfs = SND_SOC_FSBD_ALL,
+	},
 };
 
 /*
diff -r 98ae850eb995 soc/codecs/wm8750.c
--- a/soc/codecs/wm8750.c	Thu Oct 12 14:34:32 2006 +0200
+++ b/soc/codecs/wm8750.c	Fri Oct 13 10:54:13 2006 +0100
@@ -97,102 +97,254 @@ static struct snd_soc_dai_mode wm8750_mo
 static struct snd_soc_dai_mode wm8750_modes[] = {
 	/* common codec frame and clock master modes */
 	/* 8k */
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_8000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 1536, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_8000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 1408, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_8000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 2304, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_8000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 2112, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_8000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 1500, WM8750_HIFI_FSB},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_8000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 1536, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_8000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 1408, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_8000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 2304, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_8000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 2112, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_8000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 1500, 
+		.bfs = WM8750_HIFI_FSB,
+	},
 
 	/* 11.025k */
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_11025,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 1024, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_11025,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 1536, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_11025,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 1088, WM8750_HIFI_FSB},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_11025,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 1024, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_11025,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 1536, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_11025,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 1088, 
+		.bfs = WM8750_HIFI_FSB,
+	},
 
 	/* 16k */
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_16000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 768, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_16000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 1152, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_16000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 750, WM8750_HIFI_FSB},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_16000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 768, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_16000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 1152, 
+		.bfs = WM8750_HIFI_FSB
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_16000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 750, 
+		.bfs = WM8750_HIFI_FSB,
+	},
 
 	/* 22.05k */
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_22050,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 512, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_22050,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 768, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_22050,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 544, WM8750_HIFI_FSB},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_22050,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 512, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_22050,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 768, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_22050,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 544, 
+		.bfs = WM8750_HIFI_FSB,
+	},
 
 	/* 32k */
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_16000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 384, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_16000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 576, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_16000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 375, WM8750_HIFI_FSB},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_32000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 384, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_32000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 576, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_32000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 375, 
+		.bfs = WM8750_HIFI_FSB,
+	},
 
 	/* 44.1k & 48k */
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_44100 |
-		SNDRV_PCM_RATE_48000, WM8750_DIR, SND_SOC_DAI_BFS_DIV, 256,
-		WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_44100 |
-		SNDRV_PCM_RATE_48000, WM8750_DIR, SND_SOC_DAI_BFS_DIV, 384,
-		WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_44100,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 272, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_48000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 250, WM8750_HIFI_FSB},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000, 
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 256,
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000, 
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 384,
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_44100,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 272, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_48000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 250, 
+		.bfs = WM8750_HIFI_FSB,
+	},
 
 	/* 88.2k & 96k */
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_88200 |
-		SNDRV_PCM_RATE_96000, WM8750_DIR, SND_SOC_DAI_BFS_DIV, 128,
-		WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_88200 |
-		SNDRV_PCM_RATE_96000, WM8750_DIR, SND_SOC_DAI_BFS_DIV, 192,
-		WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_88200,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 136, WM8750_HIFI_FSB},
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
-		SND_SOC_DAITDM_LRDW(0,0), WM8750_HIFI_BITS, SNDRV_PCM_RATE_96000,
-		WM8750_DIR, SND_SOC_DAI_BFS_DIV, 125, WM8750_HIFI_FSB},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000, 
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 128,
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000, 
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 192,
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_88200,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 136, 
+		.bfs = WM8750_HIFI_FSB,
+	},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBM_CFM,
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = SNDRV_PCM_RATE_96000,
+		.pcmdir = WM8750_DIR, 
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 125, 
+		.bfs = WM8750_HIFI_FSB,
+	},
 
 	/* codec frame and clock slave modes */
-	{WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBS_CFS, SND_SOC_DAITDM_LRDW(0,0),
-		WM8750_HIFI_BITS, WM8750_HIFI_RATES, WM8750_DIR,
-		SND_SOC_DAI_BFS_DIV, SND_SOC_FS_ALL, SND_SOC_FSBD_ALL},
+	{
+		.fmt = WM8750_HIFI_DAIFMT | SND_SOC_DAIFMT_CBS_CFS, 
+		.pcmfmt = WM8750_HIFI_BITS, 
+		.pcmrate = WM8750_HIFI_RATES, 
+		.pcmdir = WM8750_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = SND_SOC_FS_ALL, 
+		.bfs = SND_SOC_FSBD_ALL,
+	},
 };
 
 /*
diff -r 98ae850eb995 soc/codecs/wm9712.c
--- a/soc/codecs/wm9712.c	Thu Oct 12 14:34:32 2006 +0200
+++ b/soc/codecs/wm9712.c	Fri Oct 13 10:54:13 2006 +0100
@@ -44,8 +44,11 @@ static int ac97_write(struct snd_soc_cod
 
 /* may need to expand this */
 static struct snd_soc_dai_mode ac97_modes[] = {
-	{0, 0,	SNDRV_PCM_FMTBIT_S16_LE,	AC97_RATES},
-	{0, 0,	SNDRV_PCM_FMTBIT_S18_3LE,	AC97_RATES},
+	{
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE,	
+		.pcmrate = AC97_RATES,
+		.pcmdir = AC97_DIR,
+	},
 };
 
 /*
diff -r 98ae850eb995 soc/pxa/pxa2xx-i2s.c
--- a/soc/pxa/pxa2xx-i2s.c	Thu Oct 12 14:34:32 2006 +0200
+++ b/soc/pxa/pxa2xx-i2s.c	Thu Oct 12 17:22:33 2006 +0100
@@ -58,30 +58,77 @@ static struct pxa_i2s_port pxa_i2s;
 /* priv is divider */
 static struct snd_soc_dai_mode pxa2xx_i2s_modes[] = {
 	/* pxa2xx I2S frame and clock master modes */
-	{PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS, SND_SOC_DAITDM_LRDW(0,0),
-		SNDRV_PCM_FMTBIT_S16_LE, SNDRV_PCM_RATE_8000, PXA_I2S_DIR,
-		SND_SOC_DAI_BFS_DIV, 256, SND_SOC_FSBD(4), 0x48},
-	{PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS, SND_SOC_DAITDM_LRDW(0,0),
-		SNDRV_PCM_FMTBIT_S16_LE, SNDRV_PCM_RATE_11025, PXA_I2S_DIR,
-		SND_SOC_DAI_BFS_DIV, 256, SND_SOC_FSBD(4), 0x34},
-	{PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS, SND_SOC_DAITDM_LRDW(0,0),
-		SNDRV_PCM_FMTBIT_S16_LE, SNDRV_PCM_RATE_16000, PXA_I2S_DIR,
-		SND_SOC_DAI_BFS_DIV, 256, SND_SOC_FSBD(4), 0x24},
-	{PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS, SND_SOC_DAITDM_LRDW(0,0),
-		SNDRV_PCM_FMTBIT_S16_LE, SNDRV_PCM_RATE_22050, PXA_I2S_DIR,
-		SND_SOC_DAI_BFS_DIV, 256, SND_SOC_FSBD(4), 0x1a},
-	{PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS, SND_SOC_DAITDM_LRDW(0,0),
-		SNDRV_PCM_FMTBIT_S16_LE, SNDRV_PCM_RATE_44100, PXA_I2S_DIR,
-		SND_SOC_DAI_BFS_DIV, 256, SND_SOC_FSBD(4), 0xd},
-	{PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS, SND_SOC_DAITDM_LRDW(0,0),
-		SNDRV_PCM_FMTBIT_S16_LE, SNDRV_PCM_RATE_48000, PXA_I2S_DIR,
-		SND_SOC_DAI_BFS_DIV, 256, SND_SOC_FSBD(4), 0xc},
+	{
+		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE, 
+		.pcmrate = SNDRV_PCM_RATE_8000, 
+		.pcmdir = PXA_I2S_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 256, 
+		.bfs = SND_SOC_FSBD(4), 
+		.priv = 0x48,
+	},
+	{
+		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE, 
+		.pcmrate = SNDRV_PCM_RATE_11025, 
+		.pcmdir = PXA_I2S_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 256, 
+		.bfs = SND_SOC_FSBD(4), 
+		.priv = 0x34,
+	},
+	{
+		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE, 
+		.pcmrate = SNDRV_PCM_RATE_16000, 
+		.pcmdir = PXA_I2S_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV,
+		.fs = 256, 
+		.bfs = SND_SOC_FSBD(4), 
+		.priv = 0x24,
+	},
+	{
+		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE, 
+		.pcmrate = SNDRV_PCM_RATE_22050,
+		.pcmdir = PXA_I2S_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV,
+		.fs = 256, 
+		.bfs = SND_SOC_FSBD(4), 
+		.priv = 0x1a,
+	},
+	{
+		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE, 
+		.pcmrate = SNDRV_PCM_RATE_44100, 
+		.pcmdir = PXA_I2S_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 256, 
+		.bfs = SND_SOC_FSBD(4), 
+		.priv = 0xd,
+	},
+	{
+		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBS_CFS,
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE, 
+		.pcmrate = SNDRV_PCM_RATE_48000, 
+		.pcmdir = PXA_I2S_DIR,
+		.flags = SND_SOC_DAI_BFS_DIV, 
+		.fs = 256, 
+		.bfs = SND_SOC_FSBD(4),
+		.priv = 0xc,
+	},
 
 	/* pxa2xx I2S frame master and clock slave mode */
-	{PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBM_CFS, SND_SOC_DAITDM_LRDW(0,0),
-		SNDRV_PCM_FMTBIT_S16_LE, PXA_I2S_RATES, PXA_I2S_DIR, 0,
-		SND_SOC_FS_ALL, SND_SOC_FSB(64), 0x48},
-
+	{
+		.fmt = PXA_I2S_DAIFMT | SND_SOC_DAIFMT_CBM_CFS,
+		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE, 
+		.pcmrate = PXA_I2S_RATES,
+		.pcmdir = PXA_I2S_DIR,
+		.fs = SND_SOC_FS_ALL, 
+		.bfs = SND_SOC_FSB(64), 
+		.priv = 0x48,
+	},
 };
 
 static struct pxa2xx_pcm_dma_params pxa2xx_i2s_pcm_stereo_out = {

--=-0BDYGi2btha3Ss+N0k8q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-0BDYGi2btha3Ss+N0k8q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-0BDYGi2btha3Ss+N0k8q--
