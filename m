From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] hda: ALC260 test model implementation
Date: Tue, 7 Feb 2006 09:52:25 +1030 (CST)
Message-ID: <200602062322.k16NMPda015556@auster.physics.adelaide.edu.au>
References: <1139266943.2041.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1139266943.2041.4.camel@mindpipe> from "Lee Revell" at Feb 06, 2006 06:02:22 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > The following patch adds a "test" ALC260 model specification to the
> > patch_realtek.c driver if CONFIG_SND_DEBUG is set.  This is similar to
> > the "test" ALC880 model in that it sets up mixer controls for almost
> > everything to make it easier for people to test their laptop/soundcard
> > when working out what pin widgets are connected to which real-world
> > devices.
> 
> Man, these Intel HDA codecs are becoming a huge PITA... is there any end
> in sight, or will users have to resort to trial and error every time any
> vendor releases a new laptop?

A good question.  It's probaby marginally unfair blaming Intel though; The
codec chips have their output pins named by the maker (Mic1, Line1 etc). 
The problem is that it is clear that not all laptop makers use the same
mapping of pin names to the real world.  The S7020 series from Fujitsu for
example uses the "Headphone" pin to drive the internal speaker and the
"Line1" pin to drive the headphone jack (although based on what I found last
night there is probably a very good technical reason for this choice). 
In any case Intel really doesn't have a lot of control over that.

My gut feeling is that things will settle down - there really is only a
certain number of ways these things can be sensibly connected, and I really
don't see manufacturers using crazy combinations such as the Line2 pin being
the mic input for example (then again, craziness hasn't stopped them in the
past :) ).  Down the track, once the dust has settled I suspect we'll find
that things will probably be coverable with a small number of well
thought-out "base" models with the odd tweak here and there.  Another
possibility is that the auto configuration with pin sense will mature to the
point of "just working" for most people (although auto-retasking is a pain
for some applications).

In the meantime, having a "test" model will open up the testing to a larger
number of people who don't want to get involved with patching from scratch.

I guess this is why Realtek recommend using drivers provided by the
card/laptop manufacturer rather than the generic drivers - they have no
control over what gets connected to what.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
