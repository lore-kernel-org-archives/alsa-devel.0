From: ChernYue Kwok <chernyue@gdc-tech.com>
Subject: Re: Output levels on SBLive! 5.1 on ALSA vs WIndows
Date: Wed, 20 Jun 2007 17:12:39 +0800
Message-ID: <200706201712.40062.chernyue@gdc-tech.com>
References: <200706181737.47296.chernyue@gdc-tech.com>
	<s5hzm2wgqh6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helium.gdc-tech.com (www.gdc-tech.com [203.132.205.66])
	by alsa0.perex.cz (Postfix) with ESMTP id C1F83244A2
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 11:12:46 +0200 (CEST)
In-Reply-To: <s5hzm2wgqh6.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pranay Kumar <pranay@gdc-tech.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 19 June 2007 18:59:01 Takashi Iwai wrote:
> At Mon, 18 Jun 2007 17:37:46 +0800,
>
> ChernYue Kwok wrote:
> > Hello,
> >
> > I am using an SBLive! 5.1 sound card (emu10k1 chipset) with 6 channel
> > output. Due to the nature of my work, I need to be able to play sound
> > through all 6 channels at the same output level to an amplifier.
> >
> > Using Linux and the emu10k1 ALSA driver, I measured output voltage levels
> > on an oscilloscope while playing a sine wave on all 6 channels, and I got
> > three different output voltage amplitudes for the front, rear and
> > center/subwoofer channels.
> > Repeating the same test with the same card on WIndows using the Creative
> > SBLive drivers from their website, I am able to get the same output
> > voltage amplitude on all 6 channels.
> > For both tests, all output levels in the relevant mixers were set to
> > their maximum levels.
> >
> > I would like to know if this output normalizing 'feature' of the SBLive
> > Windows driver can be found in the emu10k1 ALSA driver, or in any other
> > ALSA driver. Failing that, is there any other solution to set output
> > levels in the driver, or am I doomed to twiddle in alsamixer to get the
> > output levels that I want?
>
> Did you check the dB level appearing in mixer?  The recent version of
> ALSA shows dB level in alsamixer and amixer.  Note that the "Master"
> and "PCM" controls are applied only for front channels.  So, set them
> to 0dB and control the volume via Wave* digital mixers.
>
>
> Takashi

Hi Takashi,

Thanks for your suggestions.
Based on your advice on dB levels, I set the PCM and Master channels to 0dB 
gain, and maxed the levels on the Center, LFE, and Surround channels.
The Wave* channels were set to 0 since I was playing surround and not stereo 
sound.

Playing the same 6-channel sine wave again, I was able to obtain the 
following, more evenly matched, results:

Front channels: 0.64V peak to peak
Rear channels: 0.68V peak to peak
Center and subwoofer: 0.48V peak to peak

The front and rear channel output voltages were more evenly matched, but the 
center/subwoofer channel shows a large difference from the other channels.
For comparison, the results I obtained in Windows using the Creative SB Live 
drivers are:

Front channels: 0.72V peak to peak
Rear channels: 0.68V peak to peak
Center and subwoofer: 0.64V peak to peak

Is there any way to increase output on the center and subwoofer channels in 
ALSA?
I already have the Center and LFE channels set to maximum gain in alsamixer, 
so any suggestions to further boost the output are most certainly welcome. :)

Thanks in advance.
