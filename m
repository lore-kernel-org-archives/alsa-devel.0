From: Ryan Pavlik <rpav@nwlink.com>
Subject: Re: Re: MTP-AV problems (Re: intel8x0 sequencer &
 MTP-AV) - success
Date: Sun, 16 Feb 2003 13:06:54 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030216130654.16d44488.rpav@nwlink.com>
References: <1044258789.30428.61.camel@littlewolf2.littlewolf>
	<s5h3cn5ino4.wl@alsa2.suse.de>
	<1044273602.2013.6.camel@littlewolf2.littlewolf>
	<s5hheb8l05o.wl@alsa2.suse.de>
	<1045193186.10268.392.camel@littlewolf2.littlewolf>
	<s5h4r77jdmm.wl@alsa2.suse.de>
	<1045389509.6765.21.camel@littlewolf2.littlewolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1045389509.6765.21.camel@littlewolf2.littlewolf>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 16 Feb 2003 20:58:23 +1100
Allan Klinbail <allank@labyrinth.net.au> wrote:

> Okay Finally I am very very happy.. 
> 
> SO far I have only been able to test output (need to setup MIDI
> hardware again after a gig) 
> 
> From output using MusE CVS version. 

I need to try this, is it much different than the 0.6.x prerelease? I've
had a few issues with that ...

> I have been able to send MIDI output to:
> 
> individual ports 
> multiple ports relaying different information... 
> timecode... MIDI CLOCK, worked , MMC still to be tested

Yeah after poking around same here... when it works.  Seems to rely on
JACK (which I don't care for) or else it won't play back, but I was
happy to see a steady MIDI clock delivered (I was having trouble with
one of my synths that way).

> I did not get a good SMPTE lock and the time display on the MTP-AV
> only aligned itself properly on stop.. (typical when a sync lock isn't
> established properly) both the PC and the MTP-AV were set to a SMTPE
> rate of 25 frames per second. 

I'm not sure how SMPTE is delivered, it's been awhile since I looked at
that end of MIDI, but perhaps not all the right messages are being
delivered.  What I really wish is that the MTPAV itself would generate
MIDI clocks and timecode; I'm pretty sure it's supposed to do the
latter.

<snip> 
> One glitch I noticed was that the driver seemed to send the note
> information to all ports when the sequence I had only sent to one of
> the MTPAV ports... When I assigned a second to a different port it
> began behaving correctly.

This is the main reason I replied... I've seen this behavior too.  I
haven't had time to investigate, but it seems to happen in various
sequencers from time to time (seq24, MusE, pmidi, etc.), and I'm not
completely sure of the cause.  Usually it starts out fine for me, but
I'll do something "odd" and suddenly all output is broadcast.  I'm
having suspicions, but do you remember any detailed circumstances
regarding this when you've seen it?

> This is all however fantastic progress. 

Yeah, I've had all this stuff for years and I'm completely hyped to
finally be able to put it to use.  Kudos to the ALSA developers (and the
sequencer authors ;) for all the time they've spent.

-- 
Ryan Pavlik <rpav@users.sf.net>

"Why are we even *mentioning* semi-regular polyhedrons
 and real space?" - 8BT


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
