From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How do I redirect sound from 1st soundacrd to 2nd
 soundcard?
Date: Fri, 05 Mar 2004 18:07:09 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403051648330.20612-100000@studcom.urz.uni-halle.de>
References: <20040303131830.GA23448@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040303131830.GA23448@xs4all.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bauke Jan Douma <bjdouma@xs4all.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bauke Jan Douma wrote:
> I have two soundcards in my system, a cmipci(card) and
> an intel8x0 (on board).
>
> I have the audio cable of my CD/ROM drive wired onto the
> cmipci.  Attached to line-out of the cmipci is just my
> headphones.
>
> I also have a TV-card.
> An audio cable runs from the TV-card to the intel8x0.
> Attached to line-out of the intel8x0 is a speaker set.
>
> So when I play an audio CD (with cdctrl or xmcd or xmms)
> I usually listen to the audio on the headphones.  This is
> intentional, because it suits me best.  TV audio goes to
> the speaker set.
>
> However, occasionally I want to have the audio from a CD
> redirected to the speaker set.
> Right now, to accomplish this I do something like:
>
> $> cdda2wav -S 1 -t 1+12 -D /dev/sg0 -O wav - | \
>    aplay -D intel8x0 -f cd /dev/stdin
>
> These work without a problem, for the better part.
> But I was wondering if this cannot be done a bit more
> elegantly with some configuration in ~/.asoundrc, such
> that I can call aplay directly with that device as
> parameter to -D.

aplay always reads its input from a file.  IMHO, your pipe already is
the most elegant way to provide a file for aplay.  You can put it into
a script.

I would suggest to connect all input and output devices to one card,
and to change the mixer settings appropriately.  At least your onboard
chip should be able to do this.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
