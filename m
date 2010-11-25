From: "Bandarupalli, Sailaja" <sailaja.bandarupalli@intel.com>
Subject: Re: [PATCH 2/5] [RFC]intel_hdmi_audio: interface	module
Date: Thu, 25 Nov 2010 11:24:37 +0530
Message-ID: <4F93CB265C2E2E42A19CD9E994A1FA5D060B039F0A@bgsmsx501.gar.corp.intel.com>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
	<1290433186-31628-2-git-send-email-ramesh.babu@intel.com>
	<20101122135812.GD15156@sirena.org.uk> <s5h8w0jnlby.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D9C7A103B8A
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 06:55:19 +0100 (CET)
In-Reply-To: <s5h8w0jnlby.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Wu, Fengguang" <fengguang.wu@intel.com>, "Babu,
	Ramesh" <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

 
> > > +/**
> > > + * had_hot_plug - to create sound card instance for HDMI audio
> playabck
> > > + *
> > > + *
> > > + * This function is called when the hdmi cable is plugged in. This
> function
> > > + * creates and registers the sound card with ALSA
> > > + */
> > > +static int had_hot_plug(void)
> > > +{
> >
> > It would seem more natural for the HDMI device to be created and
> > instatiated via the normal Linux device model - when a HDMI
> connection
> > is detected the thing doing the detection creates and registers a new
> > device of some kind which the driver core then binds to a separate
> > driver.
> 
> Yeah, the driver structure here is somehow wacky, although it's not
> to hard to trace.
> 
> 

Agree, we will work on this and revert back to you.

Thanks,
Sailaja & Ramesh.
