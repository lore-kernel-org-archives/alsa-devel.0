From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: Re: [PATCH 2/5] [RFC]intel_hdmi_audio: interface	module
Date: Wed, 1 Dec 2010 15:25:21 +0530
Message-ID: <12D0C12AF19E15409D57F22566E88EF505ADEC2824@bgsmsx501.gar.corp.intel.com>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
	<1290433186-31628-2-git-send-email-ramesh.babu@intel.com>
	<20101122135812.GD15156@sirena.org.uk> <s5h8w0jnlby.wl%tiwai@suse.de>
	<4F93CB265C2E2E42A19CD9E994A1FA5D060B039F0A@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 7988C1039FF
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 10:57:20 +0100 (CET)
In-Reply-To: <4F93CB265C2E2E42A19CD9E994A1FA5D060B039F0A@bgsmsx501.gar.corp.intel.com>
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
Cc: "Wu, Fengguang" <fengguang.wu@intel.com>, "Bandarupalli,
	Sailaja" <sailaja.bandarupalli@intel.com>
List-Id: alsa-devel@alsa-project.org

> > > > + * had_hot_plug - to create sound card instance for HDMI audio
> > playabck
> > > > + *
> > > > + *
> > > > + * This function is called when the hdmi cable is plugged in. This
> > function
> > > > + * creates and registers the sound card with ALSA
> > > > + */
> > > > +static int had_hot_plug(void)
> > > > +{
> > >
> > > It would seem more natural for the HDMI device to be created and
> > > instatiated via the normal Linux device model - when a HDMI
> > connection
> > > is detected the thing doing the detection creates and registers a new
> > > device of some kind which the driver core then binds to a separate
> > > driver.
> >
> > Yeah, the driver structure here is somehow wacky, although it's not
> > to hard to trace.
> >
> >
> 
> Agree, we will work on this and revert back to you.
> 

We are planning to follow the USB audio driver model.  During _init
audio driver callbacks will be registered with display driver. Whenever
device is hot plugged, .probe will be invoked and sound card is created.
During un-plug, .disconnect will be invoked and sound card is removed.
Similarly .suspend and .resume will be called when the display device
getting suspended and resumed. Please provide your suggestions on this
driver model.

static struct hdmi_driver hdmi_audio_driver = {
    .probe =    hdmi_audio_probe,
    .disconnect =   hdmi_audio_disconnect,
    .suspend =  hdmi_audio_suspend,
    .resume =   hdmi_audio_resume,
 };
 
 static int __init alsa_card_intelhad_init(void)
 {
 	return hdmi_register(&hdmi_audio_driver);
 }

Thanks,
Ramesh & Sailaja
