From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add flag to ignore
 pmdown_time at pcm_close
Date: Fri, 21 Oct 2011 14:40:04 +0530
Message-ID: <12D0C12AF19E15409D57F22566E88EF50A81369249@bgsmsx501.gar.corp.intel.com>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
	<1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
	<12D0C12AF19E15409D57F22566E88EF50A813690AD@bgsmsx501.gar.corp.intel.com>
	<20111021085303.GB3513@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 85BA1103A8A
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 11:11:01 +0200 (CEST)
In-Reply-To: <20111021085303.GB3513@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Misael@alsa-project.org, Liam Girdwood <lrg@ti.com>, Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

> > I feel ignore_pmdown_time needs to be part of snd_soc_dai_driver
> structure.
> > It will give flexibility to control individual dai.  Individual dai's
> can choose to
> > Ignore power down delay.
> 
> Why do you need to do this?
> 
> > Would it make sense?
> 
> > In my codec, I need to ignore the power down delay for voice dais,
> but retain the delay
> > for HiFi dai's.
> 
> I'm not sure associating it with DAIs is a good idea, I'd expect any
> issues to be with the analouge outputs not DAIs.

In my device, clock to the codec is coming from modem (for voice call use case).  After voice call termination, application
Calls snd_pcm_close for voice device and then turns off the modem clock.  Since clock is turned-off while
Widgets are still on (power down deferred by pmdown_time), I am noticing the glitches.

I thought, having ignore_pmdown_time for individual codec device would allow flexibility.
