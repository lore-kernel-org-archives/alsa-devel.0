From: alsa-devel@robdye.net
Subject: RE: MIDI getting killed by Jack?
Date: Tue, 23 Sep 2003 18:00:38 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1064365238.3f70ecb69eb71@scorpio.lunarpages.com>
References: <NDBBLGIKBJENLAMOLFHGOENADDAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <NDBBLGIKBJENLAMOLFHGOENADDAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: Alsa-Devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hello,

Sorry I didn't follow-up on this sooner; I must have been
distrcted by some shiny object.  I haven't had any problems
with MIDI and Jack.  I've tested routing MIDI in the following
ways:
    HDSP port 0 loopback
    HDSP port 1 -> port 0
    HDSP port 0 -> aseqview -> HDSP port 0
    HDSP port 1 -> aseqview -> HDSP port 0
    All of the above plus playback on port 0 using pmidi
I don't have another card with MIDI I/O. I tried starting Jack
both before and after doing the MIDI routing (not for every
possible combination).  I ran Jack overnight with the
port 1 -> port 0 setup.  No problem.

I am running Jack 0.80.0, compiled locally, kernel 2.4.21,
unpatched, compiled locally, and ALSA as described below.  I
wonder if the problem you found has something to do with
low-latency or preemptibility patches.

--Rob


Quoting Mark Knecht <mknecht@controlnet.com>:

> Rob,
>    I wondered if you tried finding the MIDI/Jack problem? I actually
> haven't
> revisited the issue as I'm using a MidiSport to get around the
> issue.
> 
>    I just wanted to drop you a note before I lost your email. ;-)
> 
> Cheers,
> Mark
> 
> > -----Original Message-----
> > From: alsa-devel@robdye.net [mailto:alsa-devel@robdye.net]
> > Sent: Thursday, September 11, 2003 3:40 PM
> > To: Mark Knecht
> > Subject: RE: [Alsa-devel] MIDI getting killed by Jack?
> >
> >
> > Quoting Mark Knecht <mknecht@controlnet.com>:
> >
> > > Hi,
> > >    I wanted to remind people that the version of Alsa that I am
> using is
> > > 0.9.6, but the hdsp 9652 driver is not the one in CVS. It's the
> > one Thomas
> > > developed remotely at his place and has been tested on my machine
> and
> > > possibly a few others. I think a patch was supplied to
> > asla-devel but I'm
> > > not sure about that.
> >
> > Yes.  The patch was posted.  I applied it to what was mostly alsa
> 0.9.5
> > but with the latest CVS hdsp.c at the time.  There was one conflict
> in the
> > patch (an extra firmware version case that was already in there),
> and the
> > hdsp.h posted was missing a macro for one of the ioctls (I have a
> very
> > small patch sitting somewhere, but it is probably irrelevant by
> > now anyway).
> >
> > The upshot is that audio I/O seems to be working great on my HDSP
> 9652
> > (Thanks!).  I haven't done any extensive multichannel testing;
> maybe I'll
> > get a chance this weekend.  However, hdspmixer still causes the
> > same message
> > from the driver via syslogd about hardware metering not supported.
> >
> > MIDI also works, at least on the first IN/OUT.  I haven't tried
> using JACK
> > and MIDI at the same time.  I'll give that a try tonight.
> >
> > --Rob Dye
> >
> >
> >
> 
> 
> 





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
