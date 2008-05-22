From: Geoffrey Wossum <geoffrey@pager.net>
Subject: Re: AT32AP7000 (AVR32) + WM8510
Date: Thu, 22 May 2008 14:57:41 -0500
Message-ID: <200805221457.41748.geoffrey@pager.net>
References: <200805221120.08815.geoffrey@pager.net>
	<20080522194621.GA12490@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (mail.pager.net [209.253.16.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 47FE02444D
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 21:57:22 +0200 (CEST)
Received: from [192.168.1.71] (localhost [127.0.0.1])
	by barracuda.pager.net (Spam Firewall) with ESMTP id CC650B4BA9
	for <alsa-devel@alsa-project.org>; Thu, 22 May 2008 14:57:20 -0500 (CDT)
Received: from [192.168.1.71] ([192.168.1.1]) by barracuda.pager.net with
	ESMTP id VWYpgVfFGX2Qm2T8 for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 14:57:20 -0500 (CDT)
In-Reply-To: <20080522194621.GA12490@sirena.org.uk>
Content-Disposition: inline
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

On Thursday 22 May 2008 02:46:21 pm Mark Brown wrote:
> On Thu, May 22, 2008 at 11:20:08AM -0500, Geoffrey Wossum wrote:

> Check that all the required DAPM widgets are powered up by looking in
> /sys/bus/platform/devices/soc-audio/dapm_widget during playback - if
> they aren't then enabling DAPM_DEBUG in sound/soc/soc-dapm.c will make
> DAPM display information about the decisions it's making.  If you can't
> see anything there could you please supply a register dump from during
> playback (availible in /sys/bus/platform/devices/soc-audio/codec_reg)?

Here's the DAPM widgets when I'm trying to play a file with aplay:
Ext Spk: On
Int Mic: Off
Mic Bias: Off
Boost Mixer: Off
Mic Boost: Off
Aux Boost: Off
Mic PGA: Off
Mono Out: Off
SpkP Out: On
SpkN Out: On
Aux Input: Off
ADC: Off
DAC: On
Mono Mixer: Off
Speaker Mixer: On
PM State: D0

Looks like it should work to me.  Note that I do hear a pop from the speaker 
the first time I try to play a file.  Here's a dump of the registers while 
I'm trying to play a file with aplay.  I'm combing through them right now to 
see if I can find anything that looks off.

 WM8510 registers
 0:    0
 1:  1ff
 2:  1ff
 3:  1ff
 4:   10
 5:    0
 6:  151
 7:    0
 8:    0
 9:    0
 a:    0
 b:   ff
 c:    0
 d:    0
 e:  100
 f:   ff
10:    0
11:    0
12:  12c
13:   2c
14:   2c
15:   2c
16:   2c
17:    0
18:   32
19:    0
1a:    0
1b:    0
1c:    0
1d:    0
1e:    0
1f:    0
20:   38
21:    b
22:   32
23:    0
24:    7
25:   2f
26:   e7
27:  10a
28:    0
29:    0
2a:    0
2b:    0
2c:    3
2d:   10
2e:    0
2f:    0
30:    0
31:    2
32:    1
33:    0
34:    0
35:    0
36:   39
37:    0
38:    0
-snip-
Bunch of bogus register reads equal to ffffffff after here.

Wish I had known about this register dump earlier today.  I added code to do 
the same thing with debugfs.

> > @@ -597,14 +597,14 @@ struct snd_soc_codec_dai wm8510_dai = {
> >  	.name = "WM8510 HiFi",
> >  	.playback = {
> >  		.stream_name = "Playback",
> > -		.channels_min = 1,
> > -		.channels_max = 1,
> > +		.channels_min = 2,
> > +		.channels_max = 2,
> >  		.rates = WM8510_RATES,
>
> I'll need to check this out in more detail - the WM8510 is a mono codec
> so it can only play one channel.

Not sure about this either, since I can't get it to play anything yet.  But it 
looks from the WM8510 data sheet that even though the WM8510 is mono, it 
expects a stereo I2S stream, and just ignores one of the channels based on 
the value of DACLRSWAP register bit.

Thanks,
---
Geoffrey
