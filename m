From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: Re: MTP-AV problems (Re: intel8x0 sequencer &
	MTP-AV) - success
Date: 17 Feb 2003 16:00:27 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045458034.3353.20.camel@littlewolf2.littlewolf>
References: <1044258789.30428.61.camel@littlewolf2.littlewolf>
	<s5h3cn5ino4.wl@alsa2.suse.de>
	<1044273602.2013.6.camel@littlewolf2.littlewolf>
	<s5hheb8l05o.wl@alsa2.suse.de>
	<1045193186.10268.392.camel@littlewolf2.littlewolf>
	<s5h4r77jdmm.wl@alsa2.suse.de>
	<1045389509.6765.21.camel@littlewolf2.littlewolf>
	<20030216130654.16d44488.rpav@nwlink.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030216130654.16d44488.rpav@nwlink.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@nwlink.com>
Cc: Alsa-dev <alsa-devel@lists.sourceforge.net>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-02-17 at 08:06, Ryan Pavlik wrote:
> On 16 Feb 2003 20:58:23 +1100
> Allan Klinbail <allank@labyrinth.net.au> wrote:
> 
Hi Ryan (hope you don't mind all the cutting otherwise it just gets too
hard to read) 

> > One glitch I noticed was that the driver seemed to send the note
> > information to all ports when the sequence I had only sent to one of
> > the MTPAV ports... When I assigned a second to a different port it
> > began behaving correctly.
> 
> This is the main reason I replied... I've seen this behavior too.  I
> haven't had time to investigate, but it seems to happen in various
> sequencers from time to time (seq24, MusE, pmidi, etc.), and I'm not
> completely sure of the cause.  Usually it starts out fine for me, but
> I'll do something "odd" and suddenly all output is broadcast.  I'm
> having suspicions, but do you remember any detailed circumstances
> regarding this when you've seen it?

Unfortunately, I have not had enough chance to test this except that I
noticed it was happening when only one MIDI Port  had been assigned and
only before a second port was assigned , but it seemed to move smoothly
after this.  .. .. today was supposed to be the day but I can't even
install alsa properly today (ggrrrr help somebody  see my last post) 

If you are saying that you are seeing this in multiple softwares it
probably is a driver issue that needs to be investigated further... I'll
keep my eyes wide open when I'm up and running again. 


> I need to try this, is it much different than the 0.6.x prerelease? I've
> had a few issues with that ...

I've only been using CVS releases until today  (I'm having trouble
compiling see other notes, don't know why though). I'm downloading that
version now to see what happens.. but I was under the impression the
mtpav code had only just been cleaned up in CVS.  

 
> Yeah after poking around same here... when it works.  Seems to rely on
> JACK (which I don't care for) or else it won't play back, but I was
> happy to see a steady MIDI clock delivered (I was having trouble with
> one of my synths that way).

With the version I used yesterday I was using a version of MusE without
Jack. MIDI clock was streaming fine. 

> 
> > I did not get a good SMPTE lock and the time display on the MTP-AV
> > only aligned itself properly on stop.. (typical when a sync lock isn't
> > established properly) both the PC and the MTP-AV were set to a SMTPE
> > rate of 25 frames per second. 
> 
> I'm not sure how SMPTE is delivered, it's been awhile since I looked at
> that end of MIDI, but perhaps not all the right messages are being
> delivered.  What I really wish is that the MTPAV itself would generate
> MIDI clocks and timecode; I'm pretty sure it's supposed to do the
> latter.

I've had to experiment without having a manual (MOTU won't put up a pdf
on the web and want a change of ownership kind of certificate thing), I
had mine shipped over from the US second hand, I don't even have the
details of the guy I bought it from. 

As far as I understand it should generate SMTPE timecode from video
sync, I don't know if it's possible for it to happen from MIDI clock. I
can only get sync happening when it is set on Internal and the computer
is sending sync... 

However, in my dim memory I'm sure I've seen it get a good lock from
some little test apps Takashi developed to test it and also some RTC
kernel patches (although they seem to have stopped at 2.4.20) ... As I
couldn't get multiple ports working I've been using the box in
standalone mode with a single port from another card being the interface
to the PC that is until now...  


cheers

Allan 

> 
> <snip> 

> 
> > This is all however fantastic progress. 
> 
> Yeah, I've had all this stuff for years and I'm completely hyped to
> finally be able to put it to use.  Kudos to the ALSA developers (and the
> sequencer authors ;) for all the time they've spent.
> 
> -- 
> Ryan Pavlik <rpav@users.sf.net>
> 
> "Why are we even *mentioning* semi-regular polyhedrons
>  and real space?" - 8BT
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
