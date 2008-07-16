From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] is this card supported by ALSA?
Date: Wed, 16 Jul 2008 16:40:20 +0200
Message-ID: <487E0854.6010203@keyaccess.nl>
References: <BLU137-W200E329BE55D7983681A9958F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A34D24458
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 16:38:28 +0200 (CEST)
In-Reply-To: <BLU137-W200E329BE55D7983681A9958F0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Landis McGauhey <b3zdomny@hotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, devel <alsa-devel@alsa-project.org>, ALSA@sc8-sf-spam2.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 16-07-08 15:38, Landis McGauhey wrote:

> "pop" in speaker as alsaconf loads snd-ens1371
> 
> running alsamixer-- no mute toggle underneath mic, that's a first
> 
> and just so you know,  there's no mute toggle under "master", 
> "master-m", and "PCM", either, but that's nominal.  There was one
> time, however, that "master" and/or "PCM" had a mute toggle.  Perhaps
> "master" and/or "PCM" are muted and we can't tell because there are
> supposed to be mute toggles there, but they are missing?  Something
> to consider...

I'm afraid that codec communication is just really messed up and the 
last two patches seem to have made things worse, so in preparation for 
any possible follow ups, you might as well revert those:

from /usr/src/linux-2.6.25.9:

# moodprobe -r  ens1371-ac97_reset_hack.diff
# moodprobe -r  ens1371-ac97.diff

do please again run "make" and "make modules_install" after this but 
that's just so that I'm satisfied you're back at the start. No need to 
test anything, you'd just find the old behaviour again.

One thing I am noticing now that we've been looking at the codec ID in 
ALSA in the OSS driver output there:

===
es1371: found chip, vendor id 0x1102 device id 0x8938 revision 0x00
es1371: found es1371 rev 0 at io 0xde80 irq 23
es1371: Enabling internal amplifier.
ac97_codec: AC97 Audio codec, id:  (Unknown)
gameport: ESS1371 Gameport is isa0218/gameport0, io 0x218, speed 1125kHz
===

is the "id: (Unknown)" bit. The OSS driver also definitely knows about 
the Sigmatel STAC9704 codec so it seems _this_ problam might not be 
unique to the ALSA driver. The OSS driver does produce sound, so perhaps 
we're chasing something not maximally productive right now...

It would be sort of interesting to have you look at the physical card 
and verify that it's indeed a Sigmatel STAC9704. It should be a tiny 
chip with a greek sigma sign and "STAC9704" in small enough letters that 
you might even need a magnifying glass. If it's hard or clumsy to take 
it out, don't bother though, it's not that important. You had 76058384 
as an ID and a STAC9704 is 83847605 (upper/lower 16-bit switched) but 
that will not have gotten to be there by accident.

Yes, before anyone wonders, I verified that the ALSA driver does that 
"Enabling internal amplifier" thing (that might be that pop that you 
hear; is the pop also present when loading the OSS driver?)

> Rene & Takashi: I fear this is taking up too much of our time and
> this effort may have long passed the point of diminishing returns. 
> Personally, my goal is to have audio with Skype, whether with OSS or
> ALSA, I don't care.  If you want to continue to work on this for the
> sake of the community at large and others who have this same card
> and this same problem, then I'm willing and would be honored to be
> the guinea pig and be an active participant in the community. I'm
> sorry this problem is so stubborn and if you have better things to
> do, I understand.  If you don't care to work on this anymore, I would
> understand and if you could perhaps just help me get sound in Skype
> (that is, to have /dev/dsp appear as I/O options in Skype
> configuration) with OSS, then I would be a happy camper indeed.

I'm afraid I don't know Skype. Older versions of it couldn't use ALSA 
but needed the OSS emulation. If newer version now can't use OSS but 
need ALSA, lovely...

I'll keep looking for a bit but ofcourse you don't have to wait around 
for anything. If I find anything with a good chance of success I'll let 
you know. Please conform that you've reverted the last two patches as 
mentioned above.

Rene.
