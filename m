From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [pulseaudio-discuss] Using UCM with PulseAudio
Date: Fri, 15 Jun 2012 20:38:08 +0300
Message-ID: <1339781888.3007.153.camel@laptop>
References: <1339728813.5228.48.camel@localhost>
	<1339762287.3007.127.camel@laptop> <1339781331.7609.36.camel@odin>
	<20120615173441.GN4482@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 8A26E103FD4
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 19:38:11 +0200 (CEST)
In-Reply-To: <20120615173441.GN4482@opensource.wolfsonmicro.com>
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
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>, jankovac503@gmail.com, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-06-15 at 18:34 +0100, Mark Brown wrote:
> On Fri, Jun 15, 2012 at 06:28:51PM +0100, Liam Girdwood wrote:
> > On Fri, 2012-06-15 at 15:11 +0300, Tanu Kaskinen wrote:
> 
> > > This sort of hardware causes trouble for the planned routing system, at
> > > least as I have envisioned it to behave. My vision has been that the
> > > routing logic in pulseaudio would enable and disable ports based on the
> > > streams that exist and their properties. In the OMAP4 case, there aren't
> > > any streams created when a cellular call starts, and therefore the
> > > routing logic doesn't know that it should do something.
> 
> > This is quite common in the smartphone voice call use case. A lot of
> 
> It's more than common, I'm only aware of one phone design which does
> route the audio via the CPU on call (the N900).  Anything that can't
> cope with bypassed on call audio is going to struggle.

N9 also routes the audio via the CPU. Now you know two phone designs :)

-- 
Tanu
