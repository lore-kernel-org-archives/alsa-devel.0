From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: OSS midi emulation bug: 1.0.0pre3
Date: Thu, 4 Dec 2003 17:41:49 +1030 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312040711.hB47BnH21275@sprite.physics.adelaide.edu.au>
References: <Pine.HPX.4.33n.0312021137010.10104-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0312021137010.10104-100000@studcom.urz.uni-halle.de> from "Clemens Ladisch" at Dec 02, 2003 11:42:32 AM
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens wrote:
> Jonathan Woithe wrote:
> > Under Jazz++, any "hold on" controller event which occurs within the first
> > bar played gets turned off too quickly (assuming playback starts at beat one
> > of a bar).  In fact, even if there are no subsequent "hold off" events
> > within the entire midi file the "hold on" is still turned "off".  The
> > turning off happens very soon after the "hold on" is transmitted - the "hold
> > on" has some effect but it's very short lived.
> 
> Apparently, an Active Sensing message is being sent at the start of
> the file.  ALSA sends one when a rawmidi port is closed, but I don't
> know why this should happen at the start of the file.
> 
> Does this still happen when you use aconnect to connect some dummy
> port (e.g. 0:0) to your sound card's output port before starting
> Jazz++?

I'm not entirely sure I understand what you mean by "dummy port".  What I
did last night was insert the snd-seq-dummy.o module (or whatever it's
called) which created a midi through interface which the system labelled
62:0.  I then used aconnect to route this to the external port:

  aconnect 62:0 64:0

Then I started Jazz+ which still had its output directed to the MPU401 (64:0
under ALSA on my system).  When I started playing, hold events suddenly
worked as expected.  Directing Jazz++ to the midi through gave the same
result.  If I exitted, removed the connection using "aconnect -d 62:0 64:0"
and restarted Jazz++ then the hold events were broken again (note: the dummy
module was still loaded).  Simply having this connection suddenly made midi
hold controller events work.

There was one other thing - even though hold controller events worked as
expected when the "midi through" was connected to the MPU401, there was one
other side effect - the tempo over the first half of the first bar to be
played was too fast.  This is exactly the same symptom exhibited by playmidi
with or without the "midi through" connection in place.  So:

  With 62:0 connected to 64:0 and Jazz++/playmidi set to output to
  /dev/sequencer (64:0 after OSS emulation's done its thing):
    * hold controller events work as expected in both playmidi and jazz++
    * the first half of the first bar played is sent to the MPU401
      too quickly in both playmidi and jazz++

  Without anything connected to 64:0 and Jazz++/playmidi still set as
  before:
    * hold controller events are broken around the first bar played 
      from jazz++, but still seem to work from playmidi
    * playmidi's tempo is still too fast over the first half of the first bar
      played, but jazz++'s tempo is fine over the whole piece.

This seems to have raised more questions than it answered.  Is there
anything else I can do to help track down this problem?

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
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
