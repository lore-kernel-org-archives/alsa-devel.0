From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [ASoC] Mic record is not working with wm9713
	ASoC	driver
Date: Wed, 09 May 2007 11:42:11 +0100
Message-ID: <1178707331.3740.28.camel@a10072.wolfsonmicro.main>
References: <8d6898730705090032k375babefl973819bd3d9d85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id A79F424434
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 12:42:12 +0200 (CEST)
In-Reply-To: <8d6898730705090032k375babefl973819bd3d9d85@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-05-09 at 13:02 +0530, Nobin Mathew wrote:
> I am trying to record mic with AsoC wm9713 driver. My Mic is connected "Mic 1".
> 
> My settings
> 
> 'Mic A Source' -> "Mic 1"
> 'Mic Boost (+20dB)' [on]
> 'Capture' [on]
> 'Left Capture Source' "Mic 1"
> 'Right Capture Source' "Mic 1"
> 
> 
> i am issuing following command to record
> "arecord -M -f S16_LE sound.wav"
> 
> But what i found is driver is not enabling "Mic bias" and "Mic A PGA"
> 
> this dump of /sys/devices/platform/soc-audio/dapm_widget while
> "arecord" is running is given below
> 
> 
> Mic Bias: Off
> Mic B Pre Amp: Off
> Mic A Pre Amp: On
> Mic B PGA: Off
> Mic A PGA: Off
> Mono In: Off
> Right Line In: Off
> Left Line In: Off
> Mono Out: Off
> Out 4: Off
> Out 3: Off
> Right Speaker: Off
> Left Speaker: Off
> Right Headphone: Off
> Left Headphone: Off
> Right ADC: On
> Left ADC: On
> Aux DAC: Off
> Voice DAC: Off
> Capture Mixer: Off
> HP Mixer: Off
> AC97 Mixer: Off
> Right DAC: Off
> Left DAC: Off
> Speaker Mixer: Off
> Mono Mixer: Off
> Right HP Mixer: Off
> Left HP Mixer: Off
> PM State: D0
> 
> In idea why this is happening?
> what is going wrong with my settings?

It looks like there is an incomplete audio path from Mic1 --> ADC, hence
DAPM will power down all unused components. Fwiw, I have captured from
WM9713 Mic1 in the past on Mainstone. Machine driver is here for
reference :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=blob;f=sound/soc/pxa/mainstone_wm9713.c;h=65c6517e60bc88478796c67fbbfe9c2243c14a88;hb=dev


Can you post your machine driver. It may help with debugging.

Liam
