From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd-rme9652 fails
Date: Fri, 19 Dec 2003 10:22:47 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312191021540.8959@pnote.perex-int.cz>
References: <3FE02BA2.8020900@emt.iis.fhg.de> <3FE1676C.40806@ifrance.com>
 <1071738574.2020.24.camel@localhost.localdomain> <1071777684.26967.5.camel@cmn37.stanford.edu>
 <20031218225205.GA534@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031218225205.GA534@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Patrice Tisserand <Patrice.Tisserand@ircam.fr>, Benouille <benouille@ifrance.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 18 Dec 2003, Martin Langer wrote:

> On Thu, Dec 18, 2003 at 12:01:24PM -0800, Fernando Pablo Lopez-Lezcano wrote:
> > > > I confirm this fact:
> > > > with kernel 2.4.23 and alsa 1.0rc2, the module snd-rme9652 can't be loaded
> > > > althought the "old"  rme digi 9652 is perfectly working with alsa 0.9.6
> > >
> > > I have found after a lot of printk that if I comment lines 1645 to 1648
> > > of rme9652.c, the driver could be load and I can play music with jMax ;)
> > > 
> > > Here are the part to comment:
> > > if (rme9652->ss_channels == RME9652_NCHANNELS)
> > >   if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_rme9652_adat3_check, rme9652))) < 0)
> > >      return err;
> > 
> > Did you by any chance printk what is the value of ss_channels? So that
> > the error can be corrected?
> > 
> 
> I don't have that hardware and I'm not absolutely sure here
> - but it looks like a bug for me.
> 
> martin
> 
> 
> --- rme9652.c.ORIGINAL	Thu Dec 18 23:43:36 2003
> +++ rme9652.c	Thu Dec 18 23:45:12 2003
> @@ -1618,7 +1618,6 @@
>  RME9652_SPDIF_RATE("IEC958 Sample Rate", 0),
>  RME9652_ADAT_SYNC("ADAT1 Sync Check", 0, 0),
>  RME9652_ADAT_SYNC("ADAT2 Sync Check", 0, 1),
> -RME9652_ADAT_SYNC("ADAT3 Sync Check", 0, 2),
>  RME9652_TC_VALID("Timecode Valid", 0),
>  RME9652_PASSTHRU("Passthru", 0)
>  };

Yes, duplicated controls ARE NOT ALLOWED NOW. Applied. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
