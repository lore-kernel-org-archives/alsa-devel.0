From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Confusion about Playback/Capture, CODEC/CODEC	links,
	and snd_soc_dapm_link_dai_widgets()
Date: Tue, 5 Jun 2012 22:34:48 +0100
Message-ID: <20120605213447.GA12405@opensource.wolfsonmicro.com>
References: <4FC7F576.30101@wwwdotorg.org> <4FCE6B0F.6080106@wwwdotorg.org>
	<20120605204758.GA8486@opensource.wolfsonmicro.com>
	<4FCE775B.7020901@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD71924702
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 23:34:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4FCE775B.7020901@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 05, 2012 at 03:17:15PM -0600, Stephen Warren wrote:

> So, should the logic be something like this early-ish in
> snd_soc_instantiate_card():

> for every dai link:
>     if cpu side is a codec and it isn't probed
>         probe it
>     if codec side isn't probed
>         probe it
> something similar for aux devs
> something similar for platforms?

> And modify soc_probe_dai_link() to only probe DAIs, never anything else.

Yeah, something like this.

> Is the following loop still required:

> > 	/* early DAI link probe */
> > 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
> > 			order++) {

> I'm not sure what the probe ordering stuff is achieving, and whether
> it's really intended for just CPU DAIs, just all DAIs, just CODECS,
> everything...

The only user of that is OMAP, I can't remember if they've actually got
their users for that upstream or not.  IIRC it's there to resolve clock
order dependencies but I'm not sure there isn't a neater solution with
something like cache only register I/O especially now we've got better
infrastructure.  Or if we can add something based on having a usable
clock API, we can rely on but that doesn't seem too realistic in the
medium term.
