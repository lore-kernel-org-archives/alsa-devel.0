From: Ismael Valladolid Torres <ismael@sambara.org>
Subject: Re: Measuring latency on my Apple G3
Date: Tue, 22 Jul 2003 13:32:55 +0200
Message-ID: <3F1D20E7.6090002@sambara.org>
References: <3F1BB92C.6090600@sambara.org>	 <1058785796.28382.139.camel@thor.holligenstrasse29.lan>	 <3F1BD2A1.7030404@sambara.org> <1058833379.3754.71.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <bounce-debian-powerpc=debian-powerpc=m.gmane.org@lists.debian.org>
In-Reply-To: <1058833379.3754.71.camel@thor.holligenstrasse29.lan>
Resent-Message-ID: <RYC18C.A.IlH.QFSH_@murphy>
List-Post: <mailto:debian-powerpc@lists.debian.org>
List-Help: <mailto:debian-powerpc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-powerpc/>
To: =?ISO-8859-1?Q?Michel_D=E4nzer?= <daenzer@debian.org>
Cc: linux-audio-dev@music.columbia.edu, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net, debian-powerpc@lists.debian.org
List-Id: alsa-devel@alsa-project.org

Michel Dänzer escribio el 22/07/03 02:22:
> Probably a GTK bug, not related to this thread.

I know, I know... ;)

> Which isn't very surprising, as they can use parts of the graphics chip
> that we don't have specs for, for one.

Sure. Only I remember having installed Mandrake 9.1, and I think video 
performance was somewhat better. Maybe I am wrong and memory cheats...

> Beware that at least the low latency patch needs fiddling with
> arch/ppc/config.in to actually be enabled (check with grep LOLAT
> .config), and that the preempt patch (which I assume you mean by R.
> Love's) actually made things worse for me when I tried it on PPC a while
> ago. This may have been fixed in the meantime though.

You're right! First line in the patch file says:

arch/i386/config.in         |    3 +

So the patch to the config.in file is only applied automatically for the 
i386 architecture. Indeed CONFIG_LOLAT_SYSCTL was not in my .config, so 
should I paste this manually into arch/ppc/config.in? Would this be enough?

And about the preempt, patch, well, it seems I still have enough tests 
to perform so I can spend my holydays safely.

 > YMMV

IJLUW (indeed, just like using Windows!) ;)

Regards, Ismael
