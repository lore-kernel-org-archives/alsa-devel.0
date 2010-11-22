From: Vaclav Peroutka <vaclavpe@gmail.com>
Subject: SND-SOC - how to test drivers ?
Date: Mon, 22 Nov 2010 22:24:55 +0100
Message-ID: <AANLkTikE9aF38vg9WkYAVWTSXY23E7qxkQRyfsBJas6Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A945724427
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 22:24:56 +0100 (CET)
Received: by wyg36 with SMTP id 36so7496396wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 13:24:56 -0800 (PST)
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

Hello all,

I am trying to develop ALSA driver for audio subsystem for one Android
mobile phone. I already have some messages in the kernel log - please
see below.

It means that I have s3c-i2s connected to MAX9880 (source code was not
IMHO tested). And then the output from MAX9880 goes into unknown
switching matrix ( for which I even don't have a datasheet - only
register list and names of bits in registers - I can guess what
purpose they serve to).

What I want is to make some testbench driver and an application which
can set switching matrix registers through IOCTL. In MAX9880 I want to
preset microphone path to output and switch matrix until I hear my
voice from microphone in speaker or headphones. Or, is there any
better method how to do that ?

AFAIK there is no alsamixer application for Android. What do you use
for path and gain settings in this case ?

And last question so far - where to look to fix this message: "Failed
to add route LMICIN->Mic Input" ? All other routes were added so far.

Thank you very much in advance,
Vaclav

<6>[    2.932154] Advanced Linux Sound Architecture Driver Version 1.0.18a.
<4>[    2.953782] No device for DAI MAX9880
<4>[    2.962009] No device for DAI s3c-i2s
<4>[    3.003635] I2S off
<4>[    3.019939] I2S off
<4>[    3.027948] Maxim MAX9880 Audio CODEC 0.12
<6>[    3.054919] max9880: max9880_init
<4>[    3.063481] Entered s3c24xx_pcm_new
<4>[    3.071566] Entered s3c24xx_pcm_preallocate_dma_buffer
<4>[    3.080354] Entered s3c24xx_pcm_preallocate_dma_buffer
<6>[    3.088901] asoc: MAX9880 <-> s3c-i2s mapping ok
<6>[    3.097441] max9880: max9880_dapm_event 769
<6>[    3.124311] max9880: max9880_dapm_event 0
<6>[    3.140593] max9880: max9880_add_widgets
<3>[    3.156166] Failed to add route LMICIN->Mic Input
<6>[    3.164204] max9880: max9880_add_controls
<6>[    3.203234] ALSA device list:
<6>[    3.210962]   #0: S3C6410 MAX9880 (MAX9880)
