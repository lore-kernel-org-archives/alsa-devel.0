From: Bauke Jan Douma <bjdouma@xs4all.nl>
Subject: How do I redirect sound from 1st soundacrd to 2nd soundcard?
Date: Wed, 3 Mar 2004 14:18:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040303131830.GA23448@xs4all.nl>
Reply-To: bjdouma@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

[Sorry about those earlier mails; something went wrong with
permissions on my mail-editor; the editor failed, but mail
was still sent out to some bogus (and some not so bogus)
addresses]



Hi,

I have two soundcards in my system, a cmipci(card) and
an intel8x0 (on board).
cmicpi is /dev/dsp0, intel8x0 is /dev/dsp1.

In .asoundrc I have:
pcm.cmipci   { type hw ; card 0 ; device 0 }
ctl.cmipci   { type hw ; card 0 ; device 0 }
pcm.intel8x0 { type hw ; card 1 ; device 0 }
ctl.intel8x0 { type hw ; card 1 ; device 0 }

I have the audio cable of my CD/ROM drive wired onto the
cmipci.  Attached to line-out of the cmipci is just my
headphones.

I also have a TV-card.
An audio cable runs from the TV-card to the intel8x0.
Attached to line-out of the intel8x0 is a speaker set.

So when I play an audio CD (with cdctrl or xmcd or xmms)
I usually listen to the audio on the headphones.  This is
intentional, because it suits me best.  TV audio goes to
the speaker set.

However, occasionally I want to have the audio from a CD
redirected to the speaker set.
Right now, to accomplish this I do something like:

$> cdrdao read-cd --driver generic-mmc --device /dev/sg0 --datafile /dev/stdout dummy-toc | \
   dd conv=swab | \
   aplay -D intel8x0 -f cd /dev/stdin

   or:

$> cdda2wav -S 1 -t 1+12 -D /dev/sg0 -O wav - | \
   aplay -D intel8x0 -f cd /dev/stdin

These work without a problem, for the better part.
But I was wondering if this cannot be done a bit more
elegantly with some configuration in ~/.asoundrc, such
that I can call aplay directly with that device as
parameter to -D.

I fiddled with that a bit and using the mixer, but could
not get it to work that way.

Can this be done at all, and if so is there anyone who
has an ~/.asoundrc fragment that will make it work?

Thanks for any tips.

BJ


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
