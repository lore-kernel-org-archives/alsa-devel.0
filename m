From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd_soc_jack_add_gpios vs. SOC_DAPM_PIN_SWITCH
Date: Tue, 1 Feb 2011 22:27:14 +0000
Message-ID: <20110201222713.GC12101@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E333@HQMAIL01.nvidia.com>
	<20110201113351.GB12743@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310C8E48A@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E9011037F3
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 23:26:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E48A@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 01, 2011 at 10:59:00AM -0800, Stephen Warren wrote:
> Mark Brown wrote at Tuesday, February 01, 2011 4:34 AM:

> > Using these two together makes no sense.  Either you manually control
> > the state of the output or you manage it automatically.

> I was thinking that the jack detect would be used to enable/disable widgets
> for power purposes, but with a manual override to allow SW to set up use
> cases where only the internal speakers were used, and never headphones.

> That said, if that isn't something that's ever typically done, I'm fine
> not supporting that.

It's really uncommon - generally if headphones are inserted you want to
play audio on them even if also using the speakers as when people have
headphones in they may not be able to hear the speakers.  Headphones are
often pretty good earplugs too.

> > Generally a PIN_SWITCH() should only be used to offer control if none is
> > availabile within the CODEC - in the case of Harmony it wouldn't make
> > much sense as there's plenty of control in the CODEC for what gets
> > routed to the various outputs.

> IIRC, the codec controls allow selecting only what gets routed, but there
> wasn't an overall "enable/disable speakers" switch (the mute switch does
> not disable the DAPM widgets). One would have to disable all the routing
> options to disable the speaker amplifiers, which would entail remembering
> what those routing options were to restore them once the speakers were
> desired again. A manual switch avoids this.

It may make sense to have a pin switch for the speakers, it's much more
of a userspace question if you want the speakers on when the headphones
are inserted so they probably shouldn't be connected to the jack at all
(as we discussed previously).  Bear in mind that in the *very* common
case where the outputs are connected to DACs only everything will get
powered off when there's no audio playing anyway.

Having looked at the WM8903 again this probably does make most sense for
the speakers.
