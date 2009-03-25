From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: dapm - Add DAPM for
	always	active DAC or ADC
Date: Wed, 25 Mar 2009 11:52:39 +0000
Message-ID: <20090325115239.GE20936@sirena.org.uk>
References: <49C8D8B0.8030807@samsung.com>
	<20090324161510.GD5990@sirena.org.uk>
	<49C9ECB1.9030005@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 07C38103852
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2009 12:52:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49C9ECB1.9030005@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, '?????????' <kyungmin.park@samsung.com>, ????????? <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 25, 2009 at 05:34:57PM +0900, Joonyoung Shim wrote:

> Activating always DAC or ADC widget doesn't mean powering it on all the
> time. To power on DAC or ADC activated, we need one or more complete path
> connecting with DAC or ADC because the power of widgets is controlled by
> DAPM automatically. If complete path is no, DAC or ADC will be powered off
> , so we can control the power of DAC or ADC using controls at user space.

That will only work in a limited number of systems - it means there's no
facility provided to configure the DAI (I've no idea if the CODEC you're
interested in has any configuration there).  It also has problems in
situations where the voice DAC is hooked up to the CPU since no DAI is
provided.  Some systems will hook multiple DAIs in the CODEC up to the
CPU and then use this to either allow multiple streams to be played back
with mixing being done in the CODEC rather than by software or to allow
the different streams to be routed to different outputs.

> Thanks, but i think hooking in using events on the widgets is impossible
> because voice call is different operation with record or playback.

As, so you don't have any digital bypass paths (the fact that you're
also talking about ADCs suggested that you did)?  Like I said in reply
to the TWL4030 patch this sounds like you should be representing this as
a normal DAI.

> > When the core gains support for digital routing this can be replaced.
> > Alternatively, if there is no integration with record or playback
> > required then there's no reason to represent them as DACs and ADCs, they
> > could be done as some other path element that DAPM does know about.

> Hmm, I think additional support needs for voice call operation at ASoC, so
> i suggested a way of this patch.

This sort of configuration has been supported in ASoC for some time.
See the OpenMoko Neo1973 for a public example of how this can be
implemented.  It's not the nicest solution possible but it means that
when we do get something better the CODEC drivers won't require updates
and scenarios where the voice interface is connected to the CPU can be
supported.
