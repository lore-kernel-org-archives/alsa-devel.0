From: Ryan Pavlik <rpav@nwlink.com>
Subject: Re: Re: MTP-AV problems (Re: intel8x0 sequencer &
 MTP-AV) - success
Date: Sun, 16 Feb 2003 21:30:05 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030216213005.7b731da4.rpav@nwlink.com>
References: <1044258789.30428.61.camel@littlewolf2.littlewolf>
	<s5h3cn5ino4.wl@alsa2.suse.de>
	<1044273602.2013.6.camel@littlewolf2.littlewolf>
	<s5hheb8l05o.wl@alsa2.suse.de>
	<1045193186.10268.392.camel@littlewolf2.littlewolf>
	<s5h4r77jdmm.wl@alsa2.suse.de>
	<1045389509.6765.21.camel@littlewolf2.littlewolf>
	<20030216130654.16d44488.rpav@nwlink.com>
	<1045458034.3353.20.camel@littlewolf2.littlewolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1045458034.3353.20.camel@littlewolf2.littlewolf>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Allan Klinbail <allank@labyrinth.net.au>
Cc: alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On 17 Feb 2003 16:00:27 +1100
Allan Klinbail <allank@labyrinth.net.au> wrote:

<snip>
> Hi Ryan (hope you don't mind all the cutting otherwise it just gets
> too hard to read) 

Nope, cutting is good. ;)

<snip> 
> If you are saying that you are seeing this in multiple softwares it
> probably is a driver issue that needs to be investigated further...
> I'll keep my eyes wide open when I'm up and running again. 

Yeah, I'm pretty sure it's the driver, but I'm not sure what it's from. 
I have a hunch it may be how broadcast is handled, but I haven't
investigated.  Other possibilities are odd MIDI causing the mtpav to
broadcast, or just plain old bugs.

<snip>
> I've only been using CVS releases until today  (I'm having trouble
> compiling see other notes, don't know why though). I'm downloading
> that version now to see what happens.. but I was under the impression
> the mtpav code had only just been cleaned up in CVS.  

Actually, I meant the MusE CVS version as opposed to muse 0.6.0pre
something.  I'll check it out anyhow.  I've only been using ALSA CVS as
well, mostly due to the fact I want to fix the mtpav stuff where
possible.

<snip>
> With the version I used yesterday I was using a version of MusE
> without Jack. MIDI clock was streaming fine. 

Hmm, cool, I'll have to give it another try.  I also would like to get
the rtctimer module working in the latest 2.4 kernel, as this is
supposed to alleviate latency problems with an irregular clock.  Some
changes in the kernel's rtc seem to have similar modifications, so I
haven't gone through and seen what's what yet.

> I've had to experiment without having a manual (MOTU won't put up a
> pdf on the web and want a change of ownership kind of certificate
> thing), I had mine shipped over from the US second hand, I don't even
> have the details of the guy I bought it from. 

Silly Motu.  IP antics are for the RIAA/MPAA.  I'd like to know what
they expect when someone wants documentation... you made a copy of the
hardware?  Or you're considering buying it?  Or maybe you want to write
software so it's more useful and perhaps others purchase it?

I just wish Midiman made something like the mtpav.  They seem to be
great about open specs.

> As far as I understand it should generate SMTPE timecode from video
> sync, I don't know if it's possible for it to happen from MIDI clock.
> I can only get sync happening when it is set on Internal and the
> computer is sending sync... 

Hmm... I don't have any video gear to play with. :( ;)

> However, in my dim memory I'm sure I've seen it get a good lock from
> some little test apps Takashi developed to test it and also some RTC
> kernel patches (although they seem to have stopped at 2.4.20) ... As I
> couldn't get multiple ports working I've been using the box in
> standalone mode with a single port from another card being the
> interface to the PC that is until now...  
<snip>

Cool.  Good luck, I'll keep checking on progress.

-- 
Ryan Pavlik <rpav@users.sf.net>

"Why are we even *mentioning* semi-regular polyhedrons
 and real space?" - 8BT


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
