From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Fix emu10k1 breakages in kernel 2.6.12
Date: Sat, 02 Jul 2005 14:14:50 -0400
Message-ID: <1120328091.2196.16.camel@mindpipe>
References: <1120273701.12256.30.camel@mindpipe>
	 <42C66D9D.9020203@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42C66D9D.9020203@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Mikael Magnusson <mikaelmagnusson@glocalnet.net>, Peter Zubaj <pzad@pobox.sk>
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-07-02 at 11:34 +0100, James Courtier-Dutton wrote:
> Lee Revell wrote:
> > This set of critical fixes did not make it into the 2.6.12 kernel.
> > 
> > To better handle the large variety of devices it supports, the emu10k1
> > driver was recently cleaned up by moving all hardware details into a
> > table keyed by PCI ID; unfortunately some IDs were missing from the
> > table.
> > 
> > The typical effect is loss of mixer settings, mic not working, or no
> > sound at all when upgrading to 2.6.12.
> > 
> 
> Hold on. It is supposed to be done in a backwards compatible way
> already. Before all card varients we handled as being the same card,
> except for a few special cases. The first version of the patch took the
> general case and named it "Audigy Unknown" and gave it the correct
> parameters as were used before in the general case of all card varients
> being the same. Then, I looked through the code, and extracted all the
> special cases, and created specific recognition of those cards and set
> the correct feature variables, so they were also handled.
> The result of this should have been that there were no performance
> change between either versions. Then, as more card types were
> identified, I added special cases for them, but in their case, they used
> all the default parameters for the general case, the only difference was
> that the correct Model name was recorded and displayed in
> /proc/asound/cards. This is mainly just to help users identify their
> particular card, without having to remove the case of their PC. So this
> helps them report bugs better.
> 

Right, but if the name does not match, alsactl cannot restore the
previous mixer settings, so the mixer is reset to the default state, ie
no sound.

> If there are loss of features during the upgrade, I would be very
> suprised. I suspect that the same problems one sees now with some cards,
> has been there all along. If that is not the case, please report them in
> the bug tracker in the normal way.
> 

The big one is that several emu10k2 based devices like "Audigy 1 or 2
[Unknown]", "Audigy 2 Value [Unknown]", and "Audigy 1 [SB0090]" failed
to set ac97_chip, resulting in non-working mic/line in.  Here's pzad's
fix:

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c?r1=1.52&r2=1.53

Users are already getting bitten, here's a bug report:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1218

In addition to 2.6.12, it looks like FC4 shipped with this bug.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
