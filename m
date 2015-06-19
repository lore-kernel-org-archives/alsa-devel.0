From: Andrea Venturi <andrea.venturi.axel@gmail.com>
Subject: question about dapm-routes and uda1380.c
Date: Fri, 19 Jun 2015 10:42:43 +0200
Message-ID: <5583D603.8050905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 5407426065F
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 10:42:56 +0200 (CEST)
Received: by wicnd19 with SMTP id nd19so12146110wic.1
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 01:42:56 -0700 (PDT)
Received: from [10.0.0.5] ([31.177.43.87])
 by mx.google.com with ESMTPSA id ma15sm2625758wic.20.2015.06.19.01.42.55
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jun 2015 01:42:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hello,

i'm working on integrating on an Allwinner A20 based SBC an external 
codec based on  NXP UDA1380 through I2S DAI;
the SBC is Olime Olinuxino Lime2,
the codec board is this one, as it's pretty cheap on usual china sites:

http://www.wvshare.com/product/UDA1380-Board.htm

i'm using mainline kernel, 4.0.x from here: 
https://github.com/jwrdegoede/linux-sunxi/tree/sunxi-wip

i'm planning to just port the I2S DAI from the legacy allwinner 
linux-sunxi 3.4 and use a "simple-audio-card" approach.

i have more or less the setup in place with my 3 modules and DTS someway 
hacked to work out the connection between SOC/CPU + DAI + CODEC.

now i load the three modules in the kernel this way (i'm wondering if 
there's a way for autoloading, i'll look for when it's stable..):
  # insert the platform/DAI driver
  modprobe snd-soc-sunxi-i2s
  sleep 1
  modprobe snd-soc-simple-card
  sleep 1
  modprobe snd-soc-uda1380
  sleep 1

then , i've a number of warning and error (it's normal as i'm in early 
debugging now..).

the one for which i'm posting is related to "dapm routes" in the 
.../codecs/uda1380.c, these are errors in the log:

[   33.876179] uda1380-codec 1-0018: Control not supported for path Right PGA -> [Mic + Line R] -> Right ADC
[   33.885756] uda1380-codec 1-0018: ASoC: no dapm match for Right PGA --> Mic + Line R --> Right ADC
[   33.894719] uda1380-codec 1-0018: ASoC: Failed to add route Right PGA -> Mic + Line R -> Right ADC
[   33.903669] uda1380-codec 1-0018: Control not supported for path Right PGA -> [Line] -> Right ADC
[   33.912542] uda1380-codec 1-0018: ASoC: no dapm match for Right PGA --> Line --> Right ADC
[   33.920807] uda1380-codec 1-0018: ASoC: Failed to add route Right PGA -> Line -> Right ADC

to clear them out, i had to patch the dapm_route structure of uda1380.c  
with:

--- sound/soc/codecs/uda1380-orig.c     2015-05-26 12:41:58.650111434 +0200
+++ sound/soc/codecs/uda1380.c  2015-06-18 22:38:51.845892195 +0200
@@ -403,8 +403,11 @@
        {"Input Mux", "Line", "Left PGA"},

        /* right input */
-       {"Right ADC", "Mic + Line R", "Right PGA"},
-       {"Right ADC", "Line", "Right PGA"},
+       {"Right ADC", NULL, "Input Mux"},
+       {"Input Mux", "Mic", "Mic LNA"},
+       {"Input Mux", "Mic + Line R", "Right PGA"},
+       {"Input Mux", "Line L", "Left PGA"},
+       {"Input Mux", "Line", "Right PGA"},

        /* inputs */
        {"Mic LNA", NULL, "VINM"},


i added the same "Input Mux" DAPM widget as it's done on the left input 
of the codec, that's already bound to this "dapm widget" and is managing 
the couple of codec register bits at 0x22, SEL_LNA and SEL_MIC, that 
select one of the many input path (see the PDF to better understand.. i 
could add a shot but i don't know if it's policy permitted )
http://www.nxp.com/documents/data_sheet/UDA1380.pdf

as far as i can see, it should be an issue independent by my 
"development" setup, but should happening, at module load time, to all 
the devices having such a codec and using a fairly recent mainline 
kernel in an ASOC environment;

is that right? could you confirm this feeling?

let me sincerely tell you that there's not that much documentation about 
Alsa ASoC, simple-audio-card, codec, DAIs, dapm, dts, up to date, or at 
least is scattered here and there.
so it takes a bit of time to read, understand (maybe), code, test and 
debug this kind of drivers, really!

i can understand there's lot's ongoing here, and API are on flux, for 
example i had to put together stuff from different card drivers as i'm 
willing to use also Dmaengine and regmap and don't remember whatever 
else, but many drivers are still frozen on previous API (i understand it 
would take lot's of janitoring effort and testing on regression cases..)

of course, i still can't say this patch is good for something until i've 
worked out all the other issues and finally listened some good music out 
of this combo SOC+codec! :-)

hope to post more about this setup when it's working..

bests
