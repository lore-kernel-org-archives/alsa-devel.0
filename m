From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA 0.9.3a sequencer/rawmidi oops
Date: Fri, 16 May 2003 08:48:49 +0930 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305152318.h4FNInq19726@sprite.physics.adelaide.edu.au>
References: <s5h8yt9fyeh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yt9fyeh.wl@alsa2.suse.de> from "Takashi Iwai" at May 14, 2003 03:31:02 PM
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > > > Over the weekend I thought I'd give ALSA 0.9.3a a go.  For the most part it
> > > > worked fine.  However, there seems to be a bug in the sequencer or rawmidi
> > > > components.
> > > > 
> > > > If any application connects to a sequencer port, a oops results and the
> > > > machine is locked solid.  An example decoded oops is given at the end of
> > > > this email.  Initially I was testing using jazz++ 4.1.3 and OSS emulation,
> > > > but the oops occurs if pmidi is used.  Because pmidi is a native ALSA app,
> > > > it tends to suggest the problem is within the sequencer and/or MPU401
> > > > rawmidi components.  The oops given occurred when pmidi was invoked as:
> > > >   pmidi -p 64:0
> > > > where "64:0" was the port corresponding to the ens1370's external midi
> > > > interface.
> > > > 
> > > > ALSA 0.9.2 gives no trouble at all.
> > > > 
> > > > The soundcard in use is an Ensoniq AudioPCI (ens1370).
> > > > 
> > > > Does anyone have any ideas here?
> > > 
> > > does this still happen on the cvs version?
> > 
> > The current CVS version is worse.  I grabbed a version at around 0900
> > UT+0930 today (Wed 14 May).  I have just compiled this and loaded it.  When 
> >   pmidi -l
> > or
> >   pmidi -p 64:0
> > is run, we now get an error about being unable to open the sequencer.  Then
> > when 
> >   ls /proc/asound
> > is executed the kernel oopses.  It's not a hard lock - the machine keeps
> > going - but it's an oops non-the-less which clearly shouldn't happen.  It
> > seems that there is something strange lurking in the sequencer.  The decoded
> > oops is reproduced below.
> 
> yep, there is a bug in the recent cvs version.
> right now i fixed it and committed.  please update your tree again.

I grabbed an update at 1700 UT+0930 on 15 Mat 2003.  The kernel oops when
accessing /proc/asound/ is gone now.  However, there are still major
problems with this release:
 1) trying to access any of the pseudo files under /proc/asound results
    in "no such device" errors.
 2) using
      pmidi -l
    or
      pmidi -p 64:0
    still results in the "cannot open sequencer" error message
 3) attempting to play a wav file using wavplay via the OSS emulation layer
    results in a kernel oops and a hard lockup.  I didn't have time to copy
    the oops down and decode it last night - sorry.

So I still can't test whether the original problem with the sequencer is
fixed.  Since audio playing is broken, my guess is that the sequencer
problem still exists, but until things start behaving again I can't test
that.

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
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
