From: Raffaele Recalcati <lamiaposta71@gmail.com>
Subject: Re: HDA irq understanding
Date: Mon, 6 Feb 2012 18:22:01 +0000
Message-ID: <CAFU7RzNE_TfciknWMC2-HuDi0ATHsAmhwga6MJ7PowjPq6gaVQ@mail.gmail.com>
References: <CAFU7RzPKtt1-jJTgCWV1XgB+Fk-CA8FGeTCorW7cypBGFNoj7w@mail.gmail.com>
	<4F2F8C0F.5010901@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f44.google.com (mail-qw0-f44.google.com
	[209.85.216.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 847FC103EDC
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 19:22:02 +0100 (CET)
Received: by qafi29 with SMTP id i29so2378382qaf.17
	for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2012 10:22:01 -0800 (PST)
In-Reply-To: <4F2F8C0F.5010901@canonical.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

> Sorry, is your problem that you *do* get broken audio when you load the
> system, or that you *don't* get broken audio when you load the system?

I don't

> Either way, PulseAudio uses RT prio to get higher priority than your load
> scripts, so this is used in PulseAudio <=> ALSA communication, but not in
> mplayer <=> PulseAudio communication.

In fact the first problems appears in gnome interface
I'll do some SCHED_RR cpu loads applications.

> For the 10 msec frequency, it looks like timer-based scheduling is turned
> off (or possibly mplayer is using very small buffer sizes?). You might get
> help with this in the pulseaudio-discuss mailinglist.
>
> --
> David Henningsson, Canonical Ltd.
> http://launchpad.net/~diwic

I'll do some test changing mplayer buffer.

Thx,
-- 
Raffaele
www.opensurf.it
