From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] cs46xx some few corrections
Date: Wed, 18 Dec 2002 15:39:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212181535450.550-100000@pnote.perex-int.cz>
References: <200212180800.50494.puetzk@iastate.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200212180800.50494.puetzk@iastate.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kevin Puetz <puetzk@iastate.edu>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 18 Dec 2002, Kevin Puetz wrote:

> > > Sumary of changes:
> > > - Some volume bug fixes
> > > - SPDIF input fix.
> > > - Clear sample buffer after closing IEC958 stream.
> > > - Ring buffer fix (see my previous mail)
> > > - Some other misses, corrections ....
> >
> > applied.  thanks for your patch!
> 
> nice, now alsa cvs and the cs46xx are best friends again :-)
> 
> Any chance of getting a 2.5 merge sometime soon (since it doesn't seem that 
> the current cs46xx builds if dropped into a 2.5 tree)? It sure would be nice 
> to have the phase problems fixed there as well.
> 
> If there's supposed to be a way to build the alsa cvs against 2.5, that would 
> be fine too, but I couldn't figure it out.

There's no direct way, but everything in alsa-kernel is propagated to 2.5
tree by hand (or better the ksync script - alsa-kernel/scripts/ksync - and
my manual verification), but you need a BK repository.

The BK repository at http://linux-sound.bkbits.net/linux-sound contains my 
last "sync" stuff, also patches against 2.5 kernel tree can be found at
ftp://ftp.alsa-project.org/pub/kernel-patches .

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
