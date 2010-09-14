From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Terratec EWS88D (ice1712) optical stuck on ADAT
	(no IEC958 optical i/o)
Date: Tue, 14 Sep 2010 10:17:49 +0100
Message-ID: <201009141017.49209.gineera@aspect135.co.uk>
References: <AANLkTik7=sY9VJ2QX9j=W4+qH5s6SfBKi-LGG2WeF3x1@mail.gmail.com>
	<201009132135.26733.gineera@aspect135.co.uk>
	<AANLkTimD6pJkkCTEM2mVGaix1KL8wKo_4Dkoqu63vzyk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip05ir2.opaltelecom.net (out1.ip05ir2.opaltelecom.net
	[62.24.128.241])
	by alsa0.perex.cz (Postfix) with ESMTP id B8C8F103861
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 11:17:52 +0200 (CEST)
In-Reply-To: <AANLkTimD6pJkkCTEM2mVGaix1KL8wKo_4Dkoqu63vzyk@mail.gmail.com>
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
To: Niels Mayer <nielsmayer@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 14 September 2010 02:13, you wrote:
> On Mon, Sep 13, 2010 at 1:35 PM, Alan Horstmann 
<gineera@aspect135.co.uk>wrote:
> > May be helpful to use alsamixer (command-line pseudo graphical) - that
>
> It's hard to cut and paste from alsamixer(1) which is why I used amixer(1)
> and scripting to show what happens in alsamixer(1). The controls of
> interest,  'IEC958 Input Optical' 'IEC958 Input Optical' 'ADAT External
> Master Clock' 'ADAT Output Optical' 'ADAT Through' 'Enable ADAT' -- all
> appear in alsamixer(1) and they're all "stuck" at the current settings.
>
> Using either 'm' or 'space' or any other means that would normally change a
> boolean value for other ALSA properties do nothing for the above values in
> alsamixer(1). Basically, it appears that the property toggles, and then
> flips right back to the previous state (because that's what ALSA says it's
> at).
>
> Similarly, when set from the commandline, the ALSA result indicates the
> value stays the same:

> > I am fairly sure that the ice1712 driver has no run-time mechanism for
> > enabling/disabling the paired digital streams that are ADAT on EWS88D,
> > and go
> > to/from the AK4524 codecs on most other versions.
>
> Seems like there's something of it in the code, and certainly the Windows
> drivers and the hardware itself support this functionality. See also

I am trying to explain that there are 2 parts to this.  The envy24 chip has 
config registers that are set up at init, in ice1712.c.  Look for the uses of 
'dxr_enable', and you will see that the ICE_EEP1_CODEC register is set to 
0x60 unless its a DMX6fire.  Terratec clearly change these at run-time (on 
Windows), as does the StAudio driver for DSP2000, but the Alsa driver sets 
this up at init only.  Thus I am saying there is no mechanism in the driver 
to disable the digital stream pairs.

The other part, however, is the controls to switch the SPDIF etc inputs, 
specific to the EWS88D (and similar functions for the other cards).  These 
are available to change at run-time.  As the control get/set funcs are unique 
to the EWS88D there may be previously undetected bugs in them.  The '6fire 
and DSP2000 controls do work fine, if comparison is any use.  It comes down 
to use of 'printk()' and careful tracing of the failures!


>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=blob_plain;f=sound/pci/ice
>1712/ews.c;hb=HEAD
>
> static struct snd_kcontrol_new snd_ice1712_ews88d_controls[] __devinitdata
> = {
> EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "IEC958 Input Optical", 0, 1,
> 0), /* inverted */
> EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "ADAT Output Optical", 1, 0, 0),
> EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "ADAT External Master Clock", 2,
> 0, 0),
> EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "Enable ADAT", 3, 0, 0),
> EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "ADAT Through", 4, 1, 0),
> };


Alan
