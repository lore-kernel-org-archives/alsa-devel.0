From: "Bandarupalli, Sailaja" <sailaja.bandarupalli@intel.com>
Subject: Re: [PATCH 1/5] [RFC]intel_hdmi_audio:include header
Date: Thu, 25 Nov 2010 10:29:35 +0530
Message-ID: <4F93CB265C2E2E42A19CD9E994A1FA5D060B039E65@bgsmsx501.gar.corp.intel.com>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
	<20101122134859.GC15156@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 2198E103951
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 06:00:35 +0100 (CET)
In-Reply-To: <20101122134859.GC15156@sirena.org.uk>
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
Cc: "Wu, Fengguang" <fengguang.wu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Babu,
	Ramesh" <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark and Takashi,
Thanks a lot for providing review comments for RFC patches.

> 
> > +#define AUD_SAMPLE_RATE_32	HAD_MIN_RATE
> > +#define AUD_SAMPLE_RATE_44_1	44100
> > +#define AUD_SAMPLE_RATE_48	48000
> > +#define AUD_SAMPLE_RATE_88_2	88200
> > +#define AUD_SAMPLE_RATE_96	96000
> > +#define AUD_SAMPLE_RATE_176_4	176400
> > +#define AUD_SAMPLE_RATE_192	HAD_MAX_RATE
> 
> The defines for the individual rates don't seem to serve any purpose
> here - they're just defined to the sample rate as an integer, and the
> one place they're used looks to be a switch statement where I found
> myself wondering why either standard ALSA defines or the raw numbers
> weren't being used.

We will use the standard ALSA macros if available otherwise will use 
raw numbers. Overall, we will use the standard definitions where ever
possible and clean the global variables.

Thanks,
Sailaja and Ramesh.
