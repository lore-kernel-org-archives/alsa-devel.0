From: Patrice Tisserand <Patrice.Tisserand@ircam.fr>
Subject: Re: snd-rme9652 fails
Date: 19 Dec 2003 10:37:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071826640.10230.2.camel@lithium.ircam.fr>
References: <3FE02BA2.8020900@emt.iis.fhg.de> <3FE1676C.40806@ifrance.com>
	 <1071738574.2020.24.camel@localhost.localdomain>
	 <1071777684.26967.5.camel@cmn37.stanford.edu>
	 <20031218225205.GA534@tuba.home>
	 <Pine.LNX.4.58.0312191021540.8959@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312191021540.8959@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Martin Langer <martin-langer@gmx.de>, Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Benouille <benouille@ifrance.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2003-12-19 at 10:22, Jaroslav Kysela wrote:
> On Thu, 18 Dec 2003, Martin Langer wrote:
> 
> > On Thu, Dec 18, 2003 at 12:01:24PM -0800, Fernando Pablo Lopez-Lezcano wrote:
> > > > > I confirm this fact:
> > > > > with kernel 2.4.23 and alsa 1.0rc2, the module snd-rme9652 can't be loaded
> > > > > althought the "old"  rme digi 9652 is perfectly working with alsa 0.9.6
> > > >
[cut]
> > I don't have that hardware and I'm not absolutely sure here
> > - but it looks like a bug for me.
> > 
> > martin
> > 
> > 
> > --- rme9652.c.ORIGINAL	Thu Dec 18 23:43:36 2003
> > +++ rme9652.c	Thu Dec 18 23:45:12 2003
> > @@ -1618,7 +1618,6 @@
> >  RME9652_SPDIF_RATE("IEC958 Sample Rate", 0),
> >  RME9652_ADAT_SYNC("ADAT1 Sync Check", 0, 0),
> >  RME9652_ADAT_SYNC("ADAT2 Sync Check", 0, 1),
> > -RME9652_ADAT_SYNC("ADAT3 Sync Check", 0, 2),
> >  RME9652_TC_VALID("Timecode Valid", 0),
> >  RME9652_PASSTHRU("Passthru", 0)
> >  };
> 
> Yes, duplicated controls ARE NOT ALLOWED NOW. Applied. Thanks.
> 
I have the card and everything is fine with this fix.
Thanks a lot for your bug fix.

Bye.
-- 
Patrice Tisserand <Patrice.Tisserand@ircam.fr>



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
