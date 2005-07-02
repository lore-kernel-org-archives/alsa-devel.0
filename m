From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Fix emu10k1 breakages in kernel 2.6.12
Date: Sat, 02 Jul 2005 19:12:33 -0400
Message-ID: <1120345953.21637.40.camel@mindpipe>
References: <1120273701.12256.30.camel@mindpipe>
	 <42C66D9D.9020203@superbug.co.uk> <1120328091.2196.16.camel@mindpipe>
	 <42C7192F.90705@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42C7192F.90705@superbug.co.uk>
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

On Sat, 2005-07-02 at 23:46 +0100, James Courtier-Dutton wrote:
> I suppose it depends what one wants to happen when the driver comes
> across a unrecognised sound card variant.
> For example, we have ac97 for the Audigy 2 LS (a ca0106 chip), but newer
> cards with the ca0106 chip have no ac97 codec. I thought that if we come
> across an unrecognised card, we should assume that it does not have
> external chips, and then add specific support into the driver if it does.
> So, now, if a new Audigy 2 arrives without any ac97 chip, the
> snd-emu10k1 module will fail to load at all. At least if the default
> unknown entry excluded the ac97 chip, the user would at least have sound
> playback, just no capture.
> 
> So, my general point is that people are going to get bitten no matter
> what we do for the "unknown" case, but my original method was going to
> have less of an impact that potentially yours will.

Right, if the user has hardware that we've never seen, I guess the
behavior is always undefined.  IMHO for the -stable series we should
default to whatever the driver from 2.6.11 would have done (if
possible).

My main point was not to handle any new devices that come along, but to
fix the regressions that users with known hardware are seeing.  The
simplest way seems to be to add the missing entries to the list but
default to assuming no ac97 etc. as you suggested.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
