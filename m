From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Re: [PATCH] Add support for Acer TravelMate and
Date: Thu, 2 Mar 2006 09:19:17 +1030 (CST)
Message-ID: <200603012249.k21MnHs8018585@auster.physics.adelaide.edu.au>
References: <44054E09.7070901@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <44054E09.7070901@akl.lt> from "Rimas Kudelis" at Mar 01, 2006 09:32:25 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rimas Kudelis <rq@akl.lt>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>
List-Id: alsa-devel@alsa-project.org

> >> I would not be surprised if some vendors were leaving out the DAC from
> >> their CD drives, and expect you to play audio CDs in digital mode.  I
> >> believe this is how Windows Media Player works by default (it also
> >> allows it to generate visual effects from the CD audio).
> >>     
> > Ah, right.  I wasn't aware of that.  If that's its default behaviour then
> > perhaps the Acers do expect the OS to use digital mode for playing CDs. If
> > this proves to be the case then we'll revise the "acer" model to omit the CD
> > controls.
> I believe the Gnome CD player and Sound Juicer applications do that too.
> I think they, just like all other Gnome apps, use the Gstreamer
> framework. And I can even see a reason for that - most soundcards only
> have one set of pins for a CD (i.e. only one cd channel) meanwhile many
> new desktops come with two CD drives. Add to this what Lee has
> mentioned, and you get quite a set of reasons to use software to extract
> audio.

Except it sucks CPU cycles away from more useful tasks and is less capable
of correcting errors in realtime (at least in my experience).

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
