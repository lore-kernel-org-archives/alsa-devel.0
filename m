From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Problem adding support for digital mixer in codec
Date: Thu, 25 Mar 2010 09:13:36 +0000
Message-ID: <1269508416.3758.19.camel@odin>
References: <2256F256009DAA4CBE661E9F41EAC84B904BD8A0@dlee01.ent.ti.com>
	<201003250917.59531.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 61C8924555
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 10:13:43 +0100 (CET)
Received: by vws9 with SMTP id 9so1779651vws.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 02:13:40 -0700 (PDT)
In-Reply-To: <201003250917.59531.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-25 at 09:17 +0200, Peter Ujfalusi wrote:
> Hi,
> 
> On Thursday 25 March 2010 04:33:54 ext Candelaria Villarreal, Jorge wrote:
> > Hi,
> > 
> > I am trying to add support for a digital mixer. The digital mixer is
> > connected like the following example:
> > 
> > 
> > Path 1 -------\
> > Path 2 --------\
> >                    MIXER ------> DAC----> ...
> > Path 3 --------/
> > Path 4 -------/
> > 
> > 
> > 
> > However, I think ALSA does not support this configuration, as the DAC
> > should be the first element in a route. I tried adding the DAC to the
> > route first, and connected its output to the mixer inputs, like this:
> > 
> > 	  {"Mixer", "Multimedia Ext Switch", "HSDAC Left"},
> >         {"Mixer", "Multimedia Ext Switch", "HSDAC Right"},
> > 
> >         {"Mixer", "Voice Switch", "HSDAC Left"},
> >         {"Mixer", "Voice Switch", "HSDAC Right"},
> > 
> >         {"Mixer", "Multimedia Uplink Switch", "HSDAC Left"},
> >         {"Mixer", "Multimedia Uplink Switch", "HSDAC Right"},
> > 
> >         {"Mixer", "Multimedia Switch", "HSDAC Left"},
> >         {"Mixer", "Multimedia Switch", "HSDAC Right"},
> > 
> > But this does not seem to work. Can anyone give me some tips? Any comment
> > would be appreciated.

The DAC is traditionally an endpoint (or source) widget within DAPM.
This means it is does not have a source widget to supply it with audio.

> 
> Hmm, how these paths are connected, and where?
> What I mean is I suppose you have one path, which is connected to the main CPU, 
> than I suspect you have a connection to a modem (voice?), than you have 
> possibility to connect some other components via digital link?
> 
> What I did with the TWL4030 codec, is that I have moved the actual DAC power 
> control from the DAPM_DAC to different widget (the DAPM_DAC is kind of a fake 
> one). This was needed to support the digital loopback functionality.
> 
> So if you reorder the DAPM widgets (making sure that the switch order still OK), 
> than I think you can treat one of the paths as normal playback path (fake 
> DAPM_DAC -> mixer (have the DAC power bit handled here) -> ...).
> Than you might consider of adding the rest of the paths as DAPM_INPUT, and 
> connect them to the mixer (which after the fake DAC).
> So you kind of have digital loopback from those to the analog domain.
> 

This approach currently works well on the twl4030. However, you may want
to consider using SND_SOC_DAPM_AIF_IN() for your input paths here. e.g.

AIF_IN -> MIXER -> DAC -> rest of codec

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
