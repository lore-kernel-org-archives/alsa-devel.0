From: Randolph Chung <rchung42@gmail.com>
Subject: Re: Problem with MX27 ASoC audio
Date: Wed, 18 Aug 2010 11:44:03 +0800
Message-ID: <AANLkTi=Jst17bqqH6H=jdPYZSGdz5G7yiOJQ=aRLm-3x@mail.gmail.com>
References: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>
	<20100812125625.GA27749@pengutronix.de>
	<AANLkTinCWxRNBeXxTHRFBDgmgM6vZTqTKgoCubNYSV5u@mail.gmail.com>
	<20100812150145.GC11362@sirena.org.uk>
	<AANLkTiks+PBmKf6UrxwfLR2jGHO47-p4=o10Y-EE0kJw@mail.gmail.com>
	<4C690693.80706@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 574D724554
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 05:44:05 +0200 (CEST)
Received: by iwn8 with SMTP id 8so167825iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2010 20:44:04 -0700 (PDT)
In-Reply-To: <4C690693.80706@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> Any ideas? I do not see any in-tree drivers that use MX27+I2S codecs,
>> only MX27+AC97, which goes through a different path. Just wondering if
>> the I2S path works for others in the capture case?
>>
> it's working (at least was working a few weeks ago) here on an i.MX27 using
> a TLV320AIC23B which is the I2S master, check :
> sound/soc/imx/eukrea-tlv320.c

Thanks for the pointer. I was able to get this to work better after I
applied your changes related to I2S slave register settings to
imx-ssi.c.

Nonetheless, the system still doesn't behave properly when record and
playback are happening at the same time. Here's a simple test:

In one session, do:
# time arecord -D hw:0,0 -f S16_LE -c 2 -d 60 /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
real    1m 0.32s
user    0m 0.18s
sys     0m 8.65s

This works fine. But if you repeat the test, while in another session
do some audio output (e.g. speaker-test or aplay), the record will get
a lot of overruns and will finish prematurely:
# time arecord -D hw:0,0 -f S16_LE -c 2 -d 60 /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
overrun!!! (at least 0.659 ms long)
overrun!!! (at least 0.204 ms long)
overrun!!! (at least 0.324 ms long)
overrun!!! (at least 1.225 ms long)
overrun!!! (at least 0.597 ms long)
overrun!!! (at least 0.081 ms long)
overrun!!! (at least 0.881 ms long)
overrun!!! (at least 0.168 ms long)
overrun!!! (at least 0.691 ms long)
overrun!!! (at least 0.528 ms long)
overrun!!! (at least 0.672 ms long)
overrun!!! (at least 3.534 ms long)
overrun!!! (at least 1.264 ms long)
overrun!!! (at least 0.019 ms long)
overrun!!! (at least 0.514 ms long)
real    0m 13.39s
user    0m 0.16s
sys     0m 9.04s

It appears the DMA is not able to keep up (or we are missing
interrupts?) when there are two channels running simultaneously. The
xrun stacktrace looks like this:
[  501.680000] [<c0287e70>] (xrun+0x0/0xec) from [<c02889a8>]
(snd_pcm_update_state+0x104/0x10c)
[  501.680000]  r6:0000dac0 r5:cf745100 r4:cf133000
[  501.680000] [<c02888a4>] (snd_pcm_update_state+0x0/0x10c) from
[<c0288c1c>] (snd_pcm_update_hw_ptr0+0x26c/0x7a0)
[  501.680000]  r5:7d000000 r4:0000e678
[  501.680000] [<c02889b0>] (snd_pcm_update_hw_ptr0+0x0/0x7a0) from
[<c02891f0>] (snd_pcm_period_elapsed+0xa0/0xf0)
[  501.680000] [<c0289150>] (snd_pcm_period_elapsed+0x0/0xf0) from
[<c029f468>] (imx_ssi_dma_progression+0x38/0x3c)
[  501.680000]  r6:00004829 r5:00000009 r4:c041fa74
[  501.680000] [<c029f430>] (imx_ssi_dma_progression+0x0/0x3c) from
[<c0034014>] (dma_irq_handler+0x254/0x348)
[  501.680000] [<c0033dc0>] (dma_irq_handler+0x0/0x348) from
[<c006f538>] (handle_IRQ_event+0x48/0x11c)

I have also noticed that the DMA watchdog timer sometimes triggers.
I've increased the timeout to 2s for testing.

Will do more digging around, but maybe somebody else has an idea.

randolph
