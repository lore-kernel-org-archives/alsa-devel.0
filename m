From: "Jack O'Quin" <joq@io.com>
Subject: Re: Why do I get broken pipe on write to a pcm in  statePREPARED?
Date: 09 Oct 2002 13:13:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87ofa3mqfi.fsf@sulphur.joq.us>
References: <Pine.HPX.4.33n.0209171615490.1084-100000@studcom.urz.uni-halle.de>
	<200209181957.g8IJvS008300@d1o87.telia.com>
	<200210040814.g948E9015465@d1o87.telia.com>
	<s5hy99e4ayc.wl@alsa2.suse.de> <3D9DD810.7C3960C4@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D9DD810.7C3960C4@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Takashi Iwai <tiwai@suse.de>, Anders Torger <torger@ludd.luth.se>, Jaroslav Kysela <perex@suse.cz>, Tim Goetze <tim@quitte.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Abramo Bagnara <abramo.bagnara@libero.it> writes:

> For what it worths my objections are still there.
> 
> I'm strongly convinced that to have poll waiting for something that
> cannot happens is a big mistake (also as an optional behaviour).

The poll is waiting on some thread to start the PCM.  It is incorrect
to say that this "cannot happen".

> That apart I'm sure that to make a change in actual behaviour between
> rcX and 1.0 is a professional suicide. However it's _your_ professional
> suicide so... ;-)))

I am an advocate for high standards of compatibility.  But, this is
not a compatibility issue.

The current behavior fails in the case being discussed.  At worst, a
program that does not work under the current implementation will fail
differently after the change.  Some argue that the new failure symptom
is actually easier to debug, so even this may be an improvement.

The proposal permits appropriately programmed applications to do
something useful.  This behavior conforms to both the letter and
spirit of the X/Open standard, as far as I can see.

So, I think the change *should* be made, even at this late stage of
the release schedule.  (votes++)

Regards,
-- 
  Jack O'Quin
  Austin, Texas, USA



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
