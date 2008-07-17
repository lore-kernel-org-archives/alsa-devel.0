From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] ALSA SoC: Add Texas
	Instruments	TLV320AIC26 codec driver
Date: Thu, 17 Jul 2008 17:31:53 -0600
Message-ID: <20080717233153.GA8187@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<1214995713.4882.54.camel@localhost.localdomain>
	<20080712060018.GB23213@secretlab.ca>
	<20080712173609.GA6523@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by alsa0.perex.cz (Postfix) with ESMTP id D46DB24396
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 01:31:56 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so103922wfg.23
	for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2008 16:31:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080712173609.GA6523@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 12, 2008 at 06:36:10PM +0100, Mark Brown wrote:
> On Sat, Jul 12, 2008 at 12:00:18AM -0600, Grant Likely wrote:

> It wouldn't be the only driver not to implement PLL configuration in
> this way so that's probably be OK for an initial merge.  What's expected
> for PLL configuration is that you implement the DAI set_pll() operation
> in the codec driver, allowing machine drivers to configure the PLL when
> they wish.

okay

> The power configuration should be fixed, though.  Normally drivers
> either fully implement DAPM (including set_bias_level()) or power
> everything in the codec up when the driver is loaded.  At the minute
> what the driver is doing appears to be powering the codec up in both
> _hw_params() and _probe() but never powering anything down - if that is
> the case then probably all you need to do is remove the extra power up
> from hw_params(), giving you the simple option.

done

> > Hmmm, I haven't been able to find this; either in the code or on a live
> > running system.  Where is the common reg dump implemented.
> 
> /sys/bus/platform/devices/soc-audio/codec_reg

Yikes.  The AIC26 has registers all over the place and most of them are
empty.  The codec_reg attribute handling means I need to maintain a
cache of the entire register file; not just the part that is actually
used.  Oh well; I can work around it.

Thanks,
g.
