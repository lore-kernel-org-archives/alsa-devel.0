From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: [PATCH] ASoC: WM8940: incorrect mask for BCLKDIV
Date: Fri, 01 Oct 2010 10:23:43 +0200
Message-ID: <4CA59A8F.3000800@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout.mailmx.agnat.pl
	[193.239.44.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D02E1039E2
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 10:23:49 +0200 (CEST)
Received: from smtp.agnat.pl ([193.239.44.82])
	by mailmxout.mailmx.agnat.pl with esmtp (Exim 4.72)
	(envelope-from <g.daniluk@elproma.com.pl>) id 1P1auB-0005F5-Kt
	for alsa-devel@alsa-project.org; Fri, 01 Oct 2010 10:23:47 +0200
Received: from [83.19.137.3] (helo=[192.168.1.79])
	by smtp.agnat.pl with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.71) (envelope-from <g.daniluk@elproma.com.pl>)
	id 1P1auB-0004xF-AV
	for alsa-devel@alsa-project.org; Fri, 01 Oct 2010 10:23:47 +0200
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

corrected bitmask in BCLKDIV setting (wm8940_set_dai_clkdiv) and
bias_level in wm8940 register function.

best regards,
Grzegorz Daniluk

----
diff -urN a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
--- a/sound/soc/codecs/wm8940.c    2010-04-16 11:10:10.000000000 +0000
+++ b/sound/soc/codecs/wm8940.c    2010-09-29 14:12:17.263497290 +0000
@@ -514,7 +514,7 @@

     if ((Ndiv < 6) || (Ndiv > 12))
         printk(KERN_WARNING
-            "WM8940 N value %d outwith recommended range!d\n",
+            "WM8940 N value %d outwith recommended range!\n",
             Ndiv);

     pll_div.n = Ndiv;
@@ -604,7 +604,7 @@

     switch (div_id) {
     case WM8940_BCLKDIV:
-        reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFFEF3;
+        reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFFE3;
         ret = snd_soc_write(codec, WM8940_CLOCK, reg | (div << 2));
         break;
     case WM8940_MCLKDIV:
@@ -800,9 +800,10 @@

     wm8940_dai.dev = codec->dev;

-    wm8940_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+    wm8940_set_bias_level(codec, SND_SOC_BIAS_PREPARE);

-    ret = snd_soc_write(codec, WM8940_POWER1, 0x180);
+    reg = snd_soc_read(codec, WM8940_POWER1);
+    ret = snd_soc_write(codec, WM8940_POWER1, reg | 0x180);
     if (ret < 0)
         return ret;
