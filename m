From: Fons Adriaensen <fons.adriaensen@skynet.be>
Subject: Re: jack crackles using ice1712 or es1968 recently intoduced? was: usx2y jack driver
Date: Sun, 26 Sep 2004 23:47:13 +0200
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <20040926214713.GC3519@linux>
References: <200409222228.38243.annabellesgarden@yahoo.de> <200409251911.44533.annabellesgarden@yahoo.de> <20040926091255.GA3526@linux> <200409261724.53800.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <jackit-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200409261724.53800.annabellesgarden@yahoo.de>
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 26, 2004 at 05:24:53PM +0200, Karsten Wiese wrote:
<alsa and jack readers may skip the first lines>

> I mean the data calculated at aeolus startup or on retune.

The actual wavetables. These depend on four things:

1. stop definitions
2. tuning
3. temperament
4. sample frequency

So there are a lot of possible combinations. Most users will
use the same one most of the time, so it would make sense to
cache the wavetables somehow. It's one of the things I may
implement some rainy day... 

> My setup looks alike, but aeolus still takes its minute to boot,
> which it shurely deserves ;-)

:-) A real organ takes some time to build up the air pressure :-)
(agreed, less than a minute)

> Are there some subtle changes in alsa/jack relating ice1712 and es1968 
> recently introduced?
> like in alsa pcm device syncing code, which jackd uses to simultaneously 
> start/stop capture and playback?

I strongly suspect there are, but it's difficult to point out what
exactly has changed. I recently upgraded to SL9.1. This didn't work
at all (for audio). After an on-line update of the kernel (now
2.6.5-7.104-default) and instaling a more recent JACK and qjackctl
things are usable again. I will upgrade the kernel again when the
dust settles down.

I think your suspicion of the syncing code is warranted. Also the
snd-usb-audio remapping from 48 frames to 2^n is suspect, but that's
of course one of the things usx2y is meant to solve (haven't tried
it yet).

Besides the Terratec (ice1712) I also have an Edirol UA-5, and this
actually worked better (with snd-usb-audio) before the upgrade than after.

Meanwhile I found out some more about the xruns reported in my previous
message. The ones I have when Aeolus is calculating its wavetables with
-p64 or -p128 are due to memory allocation in a non-RT thread (blocks of
about one Mbyte at a time). Probably an -mm kernel would fix that. 
The cracks that remain afterwards are triggered by qjackctl updating its
connection diplay every 10 seconds. No idea what's the mechanism here.

But all by all, the system I have now works quite well with -p256, and
that's about all I need ATM.

-- 
Fons







-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
