From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels on
 OMAP MCBSP
Date: Fri, 06 Nov 2009 14:25:20 +0000
Message-ID: <1257517520.3624.564.camel@odin>
References: <1257357235.2887.499.camel@odin>
	<20091104185534.GA22055@xora.vm.bytemark.co.uk>
	<1257364009.2887.665.camel@odin>
	<20091105095143.995beeea.jhnikula@gmail.com>
	<1257432930.3603.902.camel@odin>
	<20091105212822.2fab9974.jhnikula@gmail.com>
	<1257451710.3576.292.camel@odin> <20091106132024.GA4938@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146])
	by alsa0.perex.cz (Postfix) with ESMTP id CC45F24705
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 15:25:22 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so255943eyh.16
	for <alsa-devel@alsa-project.org>; Fri, 06 Nov 2009 06:25:21 -0800 (PST)
In-Reply-To: <20091106132024.GA4938@sirena.org.uk>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-11-06 at 13:20 +0000, Mark Brown wrote:
> On Thu, Nov 05, 2009 at 08:08:30PM +0000, Liam Girdwood wrote:
> > On Thu, 2009-11-05 at 21:28 +0200, Jarkko Nikula wrote:
> 
> > > Would be nice if both the divider and frame size are calculated
> > > dynamically based on CLKSRG frequency and sample rate.
> 
> > This does sound like a useful feature and should probably exist in
> > soc-core for other platforms too.
> 
> A lot of drivers would probably have trouble using this due to the
> number of different constraints in the dividers that can be set up that
> random hardware has - it'd probably take more effort to finesse things
> than it's worth - but a utility function for mostly unconstrained
> hardware would be good.

I was thinking more generic here. e.g. additions to soc.h :-

static inline int snd_soc_get_framesize(int clock, struct snd_pcm_hw_params *params);

A caller could vary clock based upon it's divider options. Error would
be returned if there was not enough bandwidth.

and

static inline int snd_soc_get_divider(int clock, struct snd_pcm_hw_params *params);

This would return the integer divider required or bandwidth error.

and

static inline int snd_soc_get_min_clock(struct snd_pcm_hw_params *params);

return min bit clock required for params.

Liam
