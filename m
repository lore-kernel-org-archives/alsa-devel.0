From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Tue, 21 Jun 2011 11:40:42 +0100
Message-ID: <20110621104041.GD22177@opensource.wolfsonmicro.com>
References: <csg7ltyo2ntnnwkjy445wvqj.1308577935731@email.android.com>
	<BANLkTin7K_qO3ejJhOswjSjrLVh0cN2_Wg@mail.gmail.com>
	<s5hoc1s4iu3.wl%tiwai@suse.de> <4DFF904E.3090802@canonical.com>
	<20110621002917.GF1905@opensource.wolfsonmicro.com>
	<4E0040E3.9090309@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3E6CC103839
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 12:40:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E0040E3.9090309@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 21, 2011 at 08:57:39AM +0200, David Henningsson wrote:
> On 2011-06-21 02:29, Mark Brown wrote:

> >Of course given the potential for internal routing within the card you
> >can only really say that about the very edge controls that are fully
> >committed to a given path - hence my comment about exposing the all the
> >routing being much better.

> I'm ok with exposing all the routing. Perhaps we could then add some
> convenience functions in alsa-lib (and/or UCM?) that makes it easier
> for applications to figure out what they need to know without having
> to parse the entire graph.

I'd guess so unless the raw interface is just easy enough to use but
first we need to get the data in place, then we can worry about
convenience functions.

UCM wouldn't be an appropriate place to put this, it's all about
applying configurations something else has generated and has no reason
to care about routing itself.

> >I think that's too edge node focused, if we're going to define new
> >interfaces we may as well cover everything rather than doing half the
> >job.

> Rather, the ports are what we're missing. We already have PCM
> devices (which correspond to the DAC nodes) and mixer controls, so
> the ports are the only objects/nodes we're missing.

PCM devices correspond to digital links to the CPU, not to DACs and
ADCs.  You can have similar digital routing between these two to what
you can get in the analogue doman.

> We're also missing the links between the nodes (it's partially
> exposed through the mixer control naming, but that's error prone).

It's not just error prone, it just plain doesn't exist in any real sense
at the minute.  The name based approach can work only for the most basic
sound cards with simple routes, and even then it can't tell applications
how the controls are ordered in the audio paths.

> >>(Btw, I don't know much about DAPM and how well that scales to cope
> >>with these requirements, it looks very ASoC to me, but perhaps it's
> >>just the SND_SOC_DAPM_* naming that fools me. But can DAPM e g send
> >>events to userspace?)

> >No, there is no userspace visiblity of the routing map.  It's pretty
> >much exactly equivalent to the data HDA CODECs expose but shipped in
> >source rather than parsed out of the device at runtime.

> Sorry, I mixed up DAPM and the Media Controller API, but they seem
> partially overlapping to me (both are supposed to expose this codec
> graph).

No, DAPM is not supposed to expose anything to the application layer.
It's purely an implementation detail of the drivers and it is only
concerned with power so has no information about anything that doesn't
affect power.

> So, if we were to use the new Media Controller API (which I think
> you have suggested?), could you explain a little where the
> boundaries/intersections between this API and the current objects
> (ALSA PCM objects, ALSA mixer control objects) would be, and how the
> Media controller API would interact with the existing ALSA APIs?

My expectation would be that whatever interface we use for the graph
would in the first instance just point at the existing user visible
objects where they exist from the nodes and edges of the graph.  I'd not
expect any interaction as such otherwise we get an API break.
