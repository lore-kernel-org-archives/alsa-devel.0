From: Christian Lambert <clambert@sgi.com>
Subject: Re: Playback stutters
Date: Tue, 19 Mar 2002 12:48:08 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.SGI.4.43.0203191240400.120045-100000@integra.csd.sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-user@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I am also having this problem with both my ensoniq es1371 and my
audiophile 2496 with kernel 2.4.18 and alsa 0.9beta12.  It seems
to be way worse in mplayer and also when playing tribes2 where it
just constanly shutters.    I have an es1371 at work where I installed
the same version of alsa but there it's working fine with the game,
the difference is that I'm running kernel 2.4.8 so I'm wondering if
something broke in kernel 2.4.18 that causes this?

I would really like to be able to get this running stable at home.
My machine config at work and home is almost identical in both
hardware and software except for the kernel version.

Each soundcard have their own IRQ so I'm pretty sure the hardware
I have at home is ok.  With OSS/free and OSS/commercial the sound is fine
so it's something between alsa and kernel 2.4.18.

When I was listening to music in xmms, if I move windows around or
just click buttons in netcape for example it seems to shutters everytime
I do that.

Anybody else seeing this?

> Hey,
>
> audio playback stutters on my system. All playback programms I have tested
> have this problem (with and without artsd). I use alsa driver 0.9.0beta12.
> The soundcard is a no-name ALS4000 soundcard. My system: Linux 2.4.18,
> Debian testing, Dual Athlon, Tyan S2460. I have read that often IRQ
> problems cause those kind of problems, but I already tried to disable as
> much as possible hardware to free up interrups. I also changed the order of
> the PCI cards and I tried it with and without MP Interrupts.
> The playback stutters if e.g. I drag around windows or a programm starts
> (even if the load is very low). It doesn't stutter if I do heavy
> calcualtion (like running kfract multiple times) and the load is above 4.
> What else should I try to narrow down the problem?
>
> regards,
> Roland Schulz


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
