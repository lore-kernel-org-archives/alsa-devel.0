From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] emu10k1: various (mostly trivial) small
 cleanups
Date: Sun, 13 Mar 2005 09:44:16 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503130943050.1755@pnote.perex-int.cz>
References: <1110661456.7723.13.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1110661456.7723.13.camel@mindpipe>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Sat, 12 Mar 2005, Lee Revell wrote:

> These patches fix a few minor issues with the emu10k1 driver that would
> be good to get fixed before the ALSA 1.0.9 release.  All are 100% safe
> to apply, they do not change the functionality at all.

Applied.

> remove-voice-alloc-printk.patch: silence the "BUG (or not enough
> voices)" message.  This does not in fact represent a bug; it's a normal
> ocurrence when the wavetable synth is in use.

Note that it might be useful to add some "alloc fail" statistics
(available via the procfs) for debugging.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
