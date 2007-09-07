From: Rene Herman <rene.herman@gmail.com>
Subject: Re: full duplex AD1848 (was SC-6000 driver)
Date: Fri, 07 Sep 2007 14:00:59 +0200
Message-ID: <46E13D7B.4030206@gmail.com>
References: <46dfa2e7d6be4@wp.pl>	<46DFD29A.6020601@gmail.com>	<46DFE268.7080404@gmail.com>	<46e008be72b6c@wp.pl>	<46E01A2F.2080106@gmail.com>
	<20070907103447.226b5ae3.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 01808103869
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Sep 2007 14:07:37 +0200 (CEST)
In-Reply-To: <20070907103447.226b5ae3.krzysztof.h1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/07/2007 10:34 AM, Krzysztof Helt wrote:

> According to a datasheet, the AD1848K (which was a popular version of
> AD1848) is full-duplex (can work in single-dma mode or with two dma
> channels).

Yes, I see...

> The AD1848 in my SC-6000 is not the K version (at least it is not marked
> on the chip) but I saw a photo on the net with SC-6000 and AD1848K (it
> had no YMF-262 chip but a different one).
> 
> I am looking for the AD1848 datasheet  for the pre-K version (or list of 
> differences between K and earlier versions).

Can also only find the K datasheet. Not sure what's up with that -- the 
existing ad1848 driver is simplex only.

> Also, I would like to know how you put your SG card into full-duplex
> mode.

That may be the easiest test yes. Try setting bit 2 of mss_config (| 4). 
This seems to be the generic way to enable duplex on mss/wss and it works 
here. The capture channel is fixed for a fiven playback channel:

P = 0 ==> C = 1
P = 1 ==> C = 0
P = 3 ==> C = 0

By the way -- I'm running into a bug somewhere in cs4231_lib where sometimes 
the playback IRQ stops firing when you start a capture. Stopping both the 
capture and playback and then re-starting the playback works, after which 
things may or may not hang again at re-starting the capture.

Could also be a hardware bug I guess -- will need to test further again 
(sigh). But just in case you'd also run into this, don't give up on 
ful-duplex if it only sometimes doesn't work right, as there might very well 
be a bug lurking in cs4231_lib.

(bug cannot be in my own code, as that's just setup and nowhere to be found 
anymore when things are running).

Rene.
