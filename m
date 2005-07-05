From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: Fix emu10k1 breakages in kernel 2.6.12
Date: Tue, 05 Jul 2005 12:22:52 -0400
Message-ID: <1120580572.17355.27.camel@mindpipe>
References: <1120273701.12256.30.camel@mindpipe>
	 <42C66D9D.9020203@superbug.co.uk> <1120328091.2196.16.camel@mindpipe>
	 <42C7192F.90705@superbug.co.uk> <1120577617.17355.15.camel@mindpipe>
	 <s5hslytdzxq.wl%tiwai@suse.de> <1120578104.17355.17.camel@mindpipe>
	 <s5hpstxdzo2.wl%tiwai@suse.de>  <ad2655cb0507050916277995a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <ad2655cb0507050916277995a4@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>, Arnaud Patard <arnaud.patard@rtp-net.org>, Mikael Magnusson <mikaelmagnusson@glocalnet.net>, Peter Zubaj <pzad@pobox.sk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-07-05 at 17:16 +0100, James Courtier-Dutton wrote:
> I don't know about stable stuff.
> I currently only have access to the alsa cvs, so I put fixes in their
> and let other people migrate those into kernel xyz.
> I will look at the "model" option when I get a chance next weekend.
> 

I think for -stable we need to just apply the original patch that I
sent.  We just need the minimal change to restore the mic and line in on
Audigy 1 devices that resulted from the incorrect setting of ac97.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
