From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA 0.9.3a sequencer/rawmidi oops
Date: Wed, 21 May 2003 16:09:30 +0930 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305210639.h4L6dUl03509@sprite.physics.adelaide.edu.au>
References: <Pine.LNX.4.44.0305190910560.21997-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0305190910560.21997-100000@pnote.perex-int.cz> from "Jaroslav Kysela" at May 19, 2003 09:12:13 AM
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > > > I grabbed an update at 1700 UT+0930 on 15 Mat 2003.  The kernel oops when
> > > > accessing /proc/asound/ is gone now.  However, there are still major
> > > > problems with this release:
> > > >  1) trying to access any of the pseudo files under /proc/asound results
> > > >     in "no such device" errors.
> > > 
> > > hmm, i saw this phenomenon once but after rebuilding the latest
> > > drivers it doesn't appear any more.
> > 
> > Ok.  I have some more information which I'm hoping will help us track this
> > problem down.
> > 
> > Firstly, I have grabbed a CVS snapshot at around 1500 UT+0930 on 18 May
> > 2003.  I have repeated all my tests with this snapshot.  The alsa-driver
> > was configured using
> >   ./configure --with-sequencer=yes --with-oss=yes \
> >      --with-kernel=/home/audio/src/linux-2.4.20 \
> >      --with-cards=mpu401,ens1370,dt019x
> > 
> > The tests were conducted with the ens1370 card - the dt019x components were
> > not loaded.  As can be seen, this is under kernel 2.4.20.
> > 
> > The machine loaded the alsa modules with no errors.
> > 
> > I have run the snddevices script to create the static alsa device nodes.
> > 
> > Doing an "ls" of /proc/asound does not produce the oops which plagued
> > earlier CVS versions.  In fact, that particular bug was also in 0.9.3a
> > release.  However, attempting to "cat" *any* file under the /proc/asound
> > hierarchy still produced "no such device".  The directory structure is
> > created fine and can be navigated with no trouble.  It's just that it's
> > impossible to view the contents of any of the pseudo-files displayed
> > therein.  In other words, simply compiling the latest version of the driver
> > has not cured this problem for me - there's obviously some other lingering
> > problem.
> > 
> > This latest snapshot has cured the kernel oops I reported earlier regarding
> > pmidi.  I have not yet checked to see if pmidi can actually output anything,
> > but not having "pmidi -l" oops is a good start.
> > 
> > However, there seems to be serious problems with the pcm components of the
> > current CVS version.  Using "wavplay" through the ALSA OSS emulation layer
> > produces an oops and locks the machine solid.  The oops is in __wake_up().
> > Using the native aplay is slightly better - it still oopses, but at least
> > the machine isn't locked solid.  The oops is still in __wake_up().  Both
> > decoded oopses are included at the end of this email.
> > 
> > Now, the interesting thing about the pcm oops is that it occurs in
> > __wake_up().  This is actually the same endpoint of the original oops I
> > reported with the sequencer.  This might have since been fixed (as mentioned
> > above), so it's likely that whatever fix was applied to the sequencer
> > component is also needed to the pcm interface.
> 
> Do you use same compiler for kernel sources and for ALSA driver? It seems 
> like incompatible stack problems (GCC 2.9 and 3.x is incompatible).

Ah.  Up until last night I thought I did.  However, when I double-checked I
discovered that the running kernel was indeed compiled with a pre-upgrade
gcc (2.95.x actually) whereas ALSA was compiled with the current gcc
(v3.2.2).  Obviously I never got around to recompiling even though I thought
I did.  After recompiling the kernel with gcc 3.2.2 the oopses disappeared
and things started working again.

Thanks for the gentle reminder. :)  Case closed.

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
