From: "Bandarupalli, Sailaja" <sailaja.bandarupalli@intel.com>
Subject: Re: [PATCH 3/5] [RFC]intel_hdmi_audio: driver
	module	-	ALSA intereaction
Date: Thu, 25 Nov 2010 11:47:14 +0530
Message-ID: <4F93CB265C2E2E42A19CD9E994A1FA5D060B039F44@bgsmsx501.gar.corp.intel.com>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
	<1290433186-31628-3-git-send-email-ramesh.babu@intel.com>
	<s5h7hg3nkti.wl%tiwai@suse.de>
	<4F93CB265C2E2E42A19CD9E994A1FA5D060B039EEC@bgsmsx501.gar.corp.intel.com>
	<s5hvd3mlzp2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DE70103B96
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 07:17:23 +0100 (CET)
In-Reply-To: <s5hvd3mlzp2.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wu,
	Fengguang" <fengguang.wu@intel.com>, "Babu,
	Ramesh" <ramesh.babu@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

> > > > +
> > > > +/* hardware capability structure */
> > > > +static const struct snd_pcm_hardware snd_intel_hadstream = {
> > > > +	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
> > > > +		SNDRV_PCM_INFO_DOUBLE |
> > > > +		SNDRV_PCM_INFO_PAUSE |
> > > > +		SNDRV_PCM_INFO_RESUME |
> > >
> > > You have to implement corresponding stuff if you mark the driver as
> > > RESUME-able.
> >
> > Yes we have implemented SNDRV_PCM_TRIGGER_PAUSE_RELEASE
> 
> PAUSE != RESUME.
> For implementing the PM resume, you need more works.
> 
> Also I don't remember whether you implemented PM suspend/resume
> callbacks, did you...?

We will remove SNDRV_PCM_INFO_RESUME capability as the driver is 
not resume-able.
RFC patches didn't have PM suspend/resume.  However we will 
implement platform PM functionality before submitting final patches.
