From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Fix emu10k1 breakages in kernel 2.6.12
Date: Sat, 02 Jul 2005 23:46:07 +0100
Message-ID: <42C7192F.90705@superbug.co.uk>
References: <1120273701.12256.30.camel@mindpipe>	 <42C66D9D.9020203@superbug.co.uk> <1120328091.2196.16.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1120328091.2196.16.camel@mindpipe>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Mikael Magnusson <mikaelmagnusson@glocalnet.net>, Peter Zubaj <pzad@pobox.sk>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> 
>>If there are loss of features during the upgrade, I would be very
>>suprised. I suspect that the same problems one sees now with some cards,
>>has been there all along. If that is not the case, please report them in
>>the bug tracker in the normal way.
>>
> 
> 
> The big one is that several emu10k2 based devices like "Audigy 1 or 2
> [Unknown]", "Audigy 2 Value [Unknown]", and "Audigy 1 [SB0090]" failed
> to set ac97_chip, resulting in non-working mic/line in.  Here's pzad's
> fix:
> 
> http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c?r1=1.52&r2=1.53
> 
> Users are already getting bitten, here's a bug report:
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1218
> 
> In addition to 2.6.12, it looks like FC4 shipped with this bug.
> 
> Lee
> 

I suppose it depends what one wants to happen when the driver comes
across a unrecognised sound card variant.
For example, we have ac97 for the Audigy 2 LS (a ca0106 chip), but newer
cards with the ca0106 chip have no ac97 codec. I thought that if we come
across an unrecognised card, we should assume that it does not have
external chips, and then add specific support into the driver if it does.
So, now, if a new Audigy 2 arrives without any ac97 chip, the
snd-emu10k1 module will fail to load at all. At least if the default
unknown entry excluded the ac97 chip, the user would at least have sound
playback, just no capture.

So, my general point is that people are going to get bitten no matter
what we do for the "unknown" case, but my original method was going to
have less of an impact that potentially yours will.

James


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
