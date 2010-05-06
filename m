From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tpa6130a2: Support for limiting gain
Date: Thu, 06 May 2010 15:03:53 +0100
Message-ID: <1273154633.2992.40.camel@odin>
References: <1273131438-2716-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100506094942.GB30491@rakim.wolfsonmicro.main>
	<201005061421.29408.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id CB14B2472B
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 16:03:54 +0200 (CEST)
Received: by wyf23 with SMTP id 23so47143wyf.38
	for <alsa-devel@alsa-project.org>; Thu, 06 May 2010 07:03:54 -0700 (PDT)
In-Reply-To: <201005061421.29408.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-05-06 at 14:21 +0300, Peter Ujfalusi wrote:
> On Thursday 06 May 2010 12:49:42 ext Mark Brown wrote:
> > On Thu, May 06, 2010 at 10:37:18AM +0300, Peter Ujfalusi wrote:
> > > Add support for platform dependent gain limiting on the
> > > tpa6130a2 (and tpa6140a2) Headset amplifier.
> > > 
> > > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Thanks,
> 
> > but we should really provide a generic implementation of this.
> 
> Yeah, would be really useful.
> What I was wondering about is the cases when you have a codec + amp in a 
> system..
> If we take for example twl4030 and the tpa6130 connected together:
> than we have 4 levels of gain control inside of twl, than one additional level 
> on the tpa side.
> What would be nice is to somehow limit the whole chain, but it seams really 
> complicated thing because of the big amount of combinations that you can 
> actually achieve the same level at the output.
> 
> So the gain-chain limitation is really holistic problem IMHO.
> 
> But I guess the core could gain support for limiting individual volume controls.
> Some soc-limit-gain("kcontrol name", min, max)
> Than it goes through the controls on the card, finds the kcontrol, and fixers up 
> the limits..
> So machine drivers can fix up the gain limits on their cards with ease, and no 
> additional support from the codec/amp drivers are going to be needed
> Hmm, this would be neat!
> 
> Sounds  interesting, I might look at this ;)

Applied. We can always update this when core has this feature.

Thanks

Liam
