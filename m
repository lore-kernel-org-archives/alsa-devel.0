From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: UCM questions
Date: Fri, 21 Jan 2011 09:12:51 -0600
Message-ID: <AANLkTinxwo_GErQroF4S-_z3G0UyT2sD4nBVbXVJz122@mail.gmail.com>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BD6561037F5
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 16:12:54 +0100 (CET)
Received: by iwb12 with SMTP id 12so1948897iwb.38
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 07:12:52 -0800 (PST)
In-Reply-To: <20110121113744.GA18682@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Thanks Mark for your answers.

> The device/use case names there are just defaults, systems can add their
> own. =A0The default set of use cases and devices are likely to handle
> most cases but there's going to be a dependence on the system
> integration.

I am fine with a system-specific configuration file for each use case,
but if I have to change the defines in alsa-lib it's a bit of a pain.
It'll imply branches and specific packages just for a stupid include
file.

>> I make a difference between a USB headset and USB speakers?
>
> You'd probably need to handle identifying the different classes USB
> devices in whatever owns the use case configuration for the system.
> I'm not sure that's been looked at in much detail, USB host support is
> fairly unusual in the embedded systems this targets.

I am thinking netbooks and tablets where USB is more likely to be
present. For handsets I am not sure.

>> - has anyone generated a typical configuration file for USB and
>> HDAudio? I only see an OMAP conf.
>
> Someone asked this at LPC as well - my thought there is that probably
> PC systems would be happier trying to work without explicit use case
> configuration as they are currently.

Humm, not sure people are totally happy with audio on Linux PC
systems... we still don't have a simple solution for
routing/configuration/policy, UCM could provide simple hooks for users
(or PulseAudio) to do what they do most, e.g for a voice call the
headset is used while for movies the HDMI output is used.
-Pierre
