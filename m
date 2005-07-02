From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Fix emu10k1 breakages in kernel 2.6.12
Date: Sat, 02 Jul 2005 19:20:49 -0400
Message-ID: <1120346449.21637.49.camel@mindpipe>
References: <1120273701.12256.30.camel@mindpipe>
	 <42C66D9D.9020203@superbug.co.uk> <1120328091.2196.16.camel@mindpipe>
	 <42C71581.4070504@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42C71581.4070504@superbug.co.uk>
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

On Sat, 2005-07-02 at 23:30 +0100, James Courtier-Dutton wrote:
> I don't believe my changes to emu10k1 caused this to change. It was
> something independent that changed.

Ugh, you are right, this is alsactl's problem.  So it looks like users
who upgrade to alsa-utils 1.0.9+ will lose their mixer settings...

I prefer the SB*** names, because they uniquely identify the hardware,
and users seem to know them.  AFAICT it's possible for 'Audigy2' to have
an ac97 codec and 'Audigy2_1' not, resulting in different & incompatible
mixer settings.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
