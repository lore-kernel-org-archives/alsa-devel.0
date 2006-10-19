From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC AT91 DAI modes update
Date: Thu, 19 Oct 2006 14:33:48 +0100
Message-ID: <1161264828.22969.105.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-86t9r3T8r+ho0627Q1cc"
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
To: alsa-devel@lists.sourceforge.net
Cc: Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org


--=-86t9r3T8r+ho0627Q1cc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch by Frank Mandarino updates the AT91RM9200 I2S DAI audio modes
as follows:-

 o fixes a typo in the 16k mode
 o removes experimental 24k mode
 o adds a 32k mode.

Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


--=-86t9r3T8r+ho0627Q1cc
Content-Disposition: attachment; filename=asoc-at91-32k.patch
Content-Type: text/x-patch; name=asoc-at91-32k.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# HG changeset patch
# User fam@procyon
# Date 1161194387 14400
# Node ID 40826bcfd48745ed718250558a2ca3fb76beaed9
# Parent  0047a372140b81a748457ef05a6450ddff271d24
Fixed typo in 16k dai mode, removed bogus 24k dai mode
and added 32k mode.

diff -r 0047a372140b -r 40826bcfd487 soc/at91/at91rm9200-i2s.c
--- a/soc/at91/at91rm9200-i2s.c	Tue Oct 17 20:41:38 2006 +0200
+++ b/soc/at91/at91rm9200-i2s.c	Wed Oct 18 13:59:47 2006 -0400
@@ -71,22 +71,22 @@ static struct snd_soc_dai_mode at91rm920
 		.flags = SND_SOC_DAI_BFS_DIV,
 		.fs = 750,
 		.bfs = SND_SOC_FSBD(3),
-		.flags (7 << 16 | 133),
-	},
-
-	/* 24k: BCLK = (MCLK/10) = (60MHz/50) = 1.2MHz */
+		.priv = (7 << 16 | 133),
+	},
+
+	/* 32k: BCLK = (MCLK/3) ~= (60MHz/14) = 4.285714MHz */
 	{
 		.fmt = AT91RM9200_I2S_DAIFMT,
 		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = SNDRV_PCM_RATE_22050,
+		.pcmrate = SNDRV_PCM_RATE_32000,
 		.pcmdir = AT91RM9200_I2S_DIR,
 		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 500,
-		.bfs = SND_SOC_FSBD(10),
-		.priv = (25 << 16 | 24),
-	},
-
-	/* 48kHz: BCLK = (MCLK/5) ~= (60MHz/26) = 2.3076923MHz */
+		.fs = 375,
+		.bfs = SND_SOC_FSBD(3),
+		.priv = (7 << 16 | 66),
+	},
+
+	/* 48k: BCLK = (MCLK/5) ~= (60MHz/26) = 2.3076923MHz */
 	{
 		.fmt = AT91RM9200_I2S_DAIFMT,
 		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,

--=-86t9r3T8r+ho0627Q1cc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-86t9r3T8r+ho0627Q1cc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-86t9r3T8r+ho0627Q1cc--
