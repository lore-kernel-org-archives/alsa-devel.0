From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Dynamic CODEC DAI
Date: Fri, 2 Dec 2011 11:45:25 +0000
Message-ID: <20111202114524.GH8245@opensource.wolfsonmicro.com>
References: <4ED42C0E.2080300@codeaurora.org>
	<20111129134913.GB26800@opensource.wolfsonmicro.com>
	<4ED83E52.6080004@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0A26F2413F
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 12:45:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4ED83E52.6080004@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 01, 2011 at 06:56:18PM -0800, Patrick Lai wrote:

> driver developer. Instead, each slimbus port on the CODEC, by
> definition, is a mono CODEC DAI. Extending DAI link definition to take
> a list of CODEC dais allows machine driver to group the ports. Passing

Why do this in the machine driver?  That's going to be limiting, it'll
mean that you've got a fixed allocation of channels at the time the
driver is written and can't restructure things on the fly as you switch
between use cases.  I'd much rather just describe the Slimbus link (and
possibly even let it be automatically enumerated) and keep as much
flexibility as possible.

Like I say everything involved is going to have to understand that it's
constructing a multi-channel link (even a fairly dumb CODEC is going to
have to know that the samples for a given multi channel audio stream
should be synchronized) so it seems better to actually implement this
properly rather than trying to keep the knowledge out of the core.

>  I'm
> >not sure it's worth trying to be too non-invasive, anything controlling
> >hardware is going to have to understand what's going on at the physical
> >level anyway and the host side is going to have to interoperate with the's
> >Slimbus framework.  The core is also going to need to know about the
> >channel groups to allocate and destroy them as required.

> I presume you are referring to soc-core, with the approach I propose
> above, I think soc-core does not have to be aware of SLIMBUS framework.

I think it needs to be able to understand the concept of a multi-drop
flexible link; I don't think it needs to know anything specific about
Slimbus but I think to fully exploit Slimbus (and any similar buses that
come along) it's going to have to be extended.  If it were a case of
doing something tasteful that's transparent to the core but was limited
in feature set that'd be one thing but once we start to extend the core
specifically for the limited solution we should at the very least be
making sure that the APIs we're offering drivers will allow us to do a
good solution later on without churning them too much.

> >Also note that the work on submitting your Silmbus driver core to
> >mainline appears totally stalled, there was just an initial posting but
> >no followup.

> I guess slimbus driver guy is completely swamped now as SLIMBUS is new
> and it takes a lot of effort to stablize.

Well, it's pretty important that that stuff goes in - if the underlying
APIs for Slimbus turn out not to match the model we've come up with well
then that'd cause problems too.
