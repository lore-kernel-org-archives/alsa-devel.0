From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [PATCH] Add support for Acer TravelMate and
Date: Sat, 04 Mar 2006 16:37:19 -0500
Message-ID: <1141508239.14714.9.camel@mindpipe>
References: <200603012249.k21MnHs8018585@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200603012249.k21MnHs8018585@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Rimas Kudelis <rq@akl.lt>, alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-03-02 at 09:19 +1030, Jonathan Woithe wrote:
> > >> I would not be surprised if some vendors were leaving out the DAC from
> > >> their CD drives, and expect you to play audio CDs in digital mode.  I
> > >> believe this is how Windows Media Player works by default (it also
> > >> allows it to generate visual effects from the CD audio).
> > >>     
> > > Ah, right.  I wasn't aware of that.  If that's its default behaviour then
> > > perhaps the Acers do expect the OS to use digital mode for playing CDs. If
> > > this proves to be the case then we'll revise the "acer" model to omit the CD
> > > controls.
> > I believe the Gnome CD player and Sound Juicer applications do that too.
> > I think they, just like all other Gnome apps, use the Gstreamer
> > framework. And I can even see a reason for that - most soundcards only
> > have one set of pins for a CD (i.e. only one cd channel) meanwhile many
> > new desktops come with two CD drives. Add to this what Lee has
> > mentioned, and you get quite a set of reasons to use software to extract
> > audio.
> 
> Except it sucks CPU cycles away from more useful tasks and is less capable
> of correcting errors in realtime (at least in my experience).

I think the "killer app" for this setup is players like iTunes that let
you pop in a CD and play and rip it simultaneously.  It also seems like
it would be easier on the battery to rip the CD at full speed then play
it back from RAM than to keep the drive spinning at 1x for the duration.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
