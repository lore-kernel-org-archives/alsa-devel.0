From: "Alex Austin" <circuitsoft.alex@gmail.com>
Subject: Re: Trying to get unsupported CODEC to work
Date: Fri, 12 Dec 2008 02:54:25 -0600
Message-ID: <53baa24a0812120054u6c605987seba0d3066b2d5fa7@mail.gmail.com>
References: <53baa24a0812111428j143c23berb8ba0819b6b55eac@mail.gmail.com>
	<s5hd4fxdgf7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by alsa0.perex.cz (Postfix) with ESMTP id 9FBF12433E
	for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2008 09:54:26 +0100 (CET)
Received: by gxk9 with SMTP id 9so1565260gxk.8
	for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2008 00:54:25 -0800 (PST)
In-Reply-To: <s5hd4fxdgf7.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Shoot. The DAE-3 is a controller for a 5-CH Amplifier card driving speakers
directly, but I still need the subwoofer output from the ALC888. I may be
able to get by without the ALC using high-level inputs on the sub amp. Even
without it, what do I need to do to enable the DAE-3? I'm comfortable in C,
but I don't know ALSA much, if at all, yet.

On Fri, Dec 12, 2008 at 1:02 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 11 Dec 2008 16:28:28 -0600,
> Alex Austin wrote:
> >
> > HelloI have an MSI Media Live DIVA motherboard. It has an AMD SB600 HD
> Audio
> > controller, and two CODECs on the HDA bus.
> >
> > First is an ALC888
> > Second is an Intersil DAE-3.
>
> The analog outputs on both codecs are really used at the same time?
> Then it doesn't work right now.  Simply "not implemented".  And no
> concrete plan to fix it yet.  This might require a fundamental
> re-design.
>
>
> Takashi
>
> >
> > Two alsa-info outputs in different circumstances
> >
> http://www.alsa-project.org/db/?f=20c86e755fdbbdbc8761c8c2f4de76bce2ea0c11
> >
> http://www.alsa-project.org/db/?f=15c5e5eab0104622a84b2dd0df03f26c17c7242d
> >
> > Output of codecgraph with "modprobe hda-intel probe_mask=2"
> > http://pastebin.com/f54b6a9b8
> >
> > What's the next step to get this supported?
> > --
> > - Alex Austin
> > (651) 238-9273
> >
> > "...and then I visited Wikipedia ...and the next 8 hours are a blur."
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>



-- 
- Alex Austin
(651) 238-9273

"...and then I visited Wikipedia ...and the next 8 hours are a blur."
