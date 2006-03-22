From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ac3 in/out
Date: Thu, 23 Mar 2006 08:39:53 +1100
Message-ID: <1143063593.3823.21.camel@localhost.localdomain>
References: <1142936836.4759.3.camel@localhost>
	 <1142965025.4532.132.camel@mindpipe> <s5hbqvzzlss.wl%tiwai@suse.de>
	 <1143020483.11724.46.camel@localhost>  <s5hveu6yd2u.wl%tiwai@suse.de>
	 <1143024848.11724.64.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1143024848.11724.64.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>, ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-22 at 11:54 +0100, Johannes Berg wrote:

> Ok that's what I figured. Well, it has to change if I shall be able to
> write a driver for the digital output of above chip.

Well, you can be sneaky in the meantime :) If you use small buffers and
large dbdma command lists, you can have the dbdma command list skip the
status data but that mean one output command per sample (or packet),
fairly horribly inefficient if your ratio data/status is not high :)

But then, as I said, ac3 is fairly low throughput so it may be worth
just doing a conversion pass in the driver before the DMA...

> > The problem of compressed stream is that the rates of the input stream
> > and the output audio signal are different especially if the input
> > stream is VBR.  This style of input stream doesn't match with the
> > current ALSA style because ALSA PCM assumes the constant rate.
> > Changing this is more harder work. 
> 
> That's another issue, I haven't even started thinking about that.

It's very similar to the limitations of apple's old sound manager ;)
they never properly fixed it btw ... they just rewrote everything
completely for OS X ...

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
