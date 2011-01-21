From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: UCM questions
Date: Fri, 21 Jan 2011 16:43:29 +0000
Message-ID: <20110121164329.GB6200@opensource.wolfsonmicro.com>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
	<AANLkTinxwo_GErQroF4S-_z3G0UyT2sD4nBVbXVJz122@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85E4A1037F5
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 17:43:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTinxwo_GErQroF4S-_z3G0UyT2sD4nBVbXVJz122@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 21, 2011 at 09:12:51AM -0600, pl bossart wrote:

> > The device/use case names there are just defaults, systems can add their
> > own. =A0The default set of use cases and devices are likely to handle
> > most cases but there's going to be a dependence on the system
> > integration.

> I am fine with a system-specific configuration file for each use case,
> but if I have to change the defines in alsa-lib it's a bit of a pain.
> It'll imply branches and specific packages just for a stupid include
> file.

If the define isn't there you should just be able to use a string - no
need to update the header file unless the thing being added is
sufficiently general that it seems like a good idea.

> >> - has anyone generated a typical configuration file for USB and
> >> HDAudio? I only see an OMAP conf.

> > Someone asked this at LPC as well - my thought there is that probably
> > PC systems would be happier trying to work without explicit use case
> > configuration as they are currently.

> Humm, not sure people are totally happy with audio on Linux PC
> systems... we still don't have a simple solution for
> routing/configuration/policy, UCM could provide simple hooks for users
> (or PulseAudio) to do what they do most, e.g for a voice call the
> headset is used while for movies the HDMI output is used.

It's certainly useful for overriding the default behaviour - I'm more
worried about the idea of using it for the default.
