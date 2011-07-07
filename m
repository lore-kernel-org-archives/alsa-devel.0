From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm - Add API calls to query valid
	DAPM paths.
Date: Thu, 7 Jul 2011 09:38:43 -0700
Message-ID: <20110707163842.GF16325@opensource.wolfsonmicro.com>
References: <1309981768-3201-1-git-send-email-lrg@ti.com>
	<20110707033250.GC13154@opensource.wolfsonmicro.com>
	<4E15DC67.70803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8EBED103A00
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jul 2011 18:38:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E15DC67.70803@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 07, 2011 at 05:18:47PM +0100, Liam Girdwood wrote:

[Please fix your mailer to word wrap within paragraphs, I've reflowed
all your text.]

> The reason for using a separate walk here was because this code is
> taken from my old auto-router and it was to avoid the extra logic
> introduced by the auto-router. The auto-router did need to check for
> loops and always select the shortest path when > 1 path was viable
> (interesting as WM9713 has both loops and multiple paths). Let me see
> how cleanly I can merge it into the current walk.

Alternatively could we replace the current walk?  It's O(n^2) or so in
the number of widgets so it's not the greatest treasure ever.  So long
as we only have one walk and it works I'm happy.

> > It does also occur to me that perhaps what we want to do here is allow
> > widgets to find out about paths when they're being activated anyway?

> For dynamic PCM, we need to also work out which DAIs are active based
> on the graph. Hence for playback we can supply the DAC/AIF and find
> out all the connected output AIF/Speakers/Pins/etc. This is required
> at the start of open() in order that we can call the other PCM ops for
> each DAI, codec and platform.

Right, that's not really what I'm saying though - I'm saying that
widgets in general could be interested in this information.  For
example, some charge pumps can save additional power with some input
signal paths (which is currently handled but this would make that code
more general).

> >> + * snd_soc_dapm_get_connected_widgets_type - query audio path and it's widgets.
> >> + * @dapm: the dapm context.
> >> + * @stream_name: stream name.
> >> + * @list: list of active widgets for this stream.
> >> + * @stream: stream direction.
> >> + * @type: Initial widget type.
> >> + *
> >> + * Queries DAPM graph as to whether an valid audio stream path exists for
> >> + * the DAPM stream and initial widget type specified. This takes into account
> >> + * current mixer and mux kcontrol settings. Creates list of valid widgets.
> > 
> > Why would someone want to query by type?  That seems surprising.  Name
> > and/or direction yes but type seems hard to find a use for.

> We query by type so that we can qualify the root widget for a shared
> common stream name. i.e. Dynamic DSP needs to find the AIF rather than
> a DAC for stream X.

It does?  Hrm.  Perhaps it would make life simpler if we just mandated
the use of explicit AIF widgets?
