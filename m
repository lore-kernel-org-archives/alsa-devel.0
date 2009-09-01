From: jassi brar <jassisinghbrar@gmail.com>
Subject: Debugged improper setting of PLL fields in WM8580
	driver
Date: Tue, 1 Sep 2009 11:35:08 +0900
Message-ID: <1b68c6790908311935l190e5912k974894974ed65a70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.148])
	by alsa0.perex.cz (Postfix) with ESMTP id D3F2C247D1
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 04:35:09 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so1012310qwf.56
	for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2009 19:35:08 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

   Bug was caught while trying to use WM8580 as I2S master on SMDK.
   Symptoms were lesser LRCLK read by CRO(41.02 instead of 44.1 KHz)
   Solved by referring to WM8580A manual and setting mask value correctly
   and making the code to not touch 'reserved' bits of PLL4 register.

   Signed-off-by: Jassi <jassi.brar@samsung.com>


diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index d547347..6bded8c 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -458,12 +458,12 @@ static int wm8580_set_dai_pll(struct snd_soc_dai
*codec_dai,
 		return 0;

 	snd_soc_write(codec, WM8580_PLLA1 + offset, pll_div.k & 0x1ff);
-	snd_soc_write(codec, WM8580_PLLA2 + offset, (pll_div.k >> 9) & 0xff);
+	snd_soc_write(codec, WM8580_PLLA2 + offset, (pll_div.k >> 9) & 0x1ff);
 	snd_soc_write(codec, WM8580_PLLA3 + offset,
 		     (pll_div.k >> 18 & 0xf) | (pll_div.n << 4));

 	reg = snd_soc_read(codec, WM8580_PLLA4 + offset);
-	reg &= ~0x3f;
+	reg &= ~0x1b;
 	reg |= pll_div.prescale | pll_div.postscale << 1 |
 		pll_div.freqmode << 3;
