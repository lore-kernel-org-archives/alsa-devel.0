From: Brendan Pike <spike@spykes.net>
Subject: Re: How much of the X-Fi (emu20k1) chip has Creative
 documented?
Date: Mon, 18 Jan 2010 15:51:55 -0500
Message-ID: <20100118155155.0f954199@darius>
References: <760045.1231.qm@web52904.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 32094103818
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 21:51:58 +0100 (CET)
In-Reply-To: <760045.1231.qm@web52904.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 17 Jan 2010 16:43:08 -0800 (PST)
Chris Rankin <rankincj@yahoo.com> wrote:

> Hi,
> 
> I am thinking about upgrading my Audigy2 sound card, and was looking at the X-Fi. However, the feature matrix for X-Fi cards on the ALSA site only says "PCI". (I assume that also includes PCIe these days.) Given that there is a basic snd-ctxfi driver, it seems likely that this matrix should also include "ANALOGio", and so I was wondering if someone could tell me what the actual matrix entry for the X-Fi cards should be these days, please?
> 
> Would the documentation that Creative has released allow any additional features to be implemented in the future? I am obviously hoping at least for feature parity with the Audigy2, i.e. multi-voiced hardware mixing. That "crystalizer" would seem to be one of the cards main selling points, too. However, if the driver is "feature complete" as far as Creative's documentation goes, then one of the Xonar cards would seem better value for money.
> 
> Thanks for any assistance,
> Cheers,
> Chris
> 

The matrix is horribly out of date. Yes PCIe cards (emu20k2) are
supported. HWMix also exists and works perfectly, I can play
many things at once directly accessing ALSA, without the need of
pulseaudio or whatever meme of the year it is. Its probably the only
fancy feature that is supported on the chip.

There is no sequencer support, and no access to the DSP features,
which would be needed to put it in line with the old emu10k1 features.

I use an Auzentech X-Fi Forte myself, which works great. If all you
want is hardware mixing and record capabilities, then you can upgrade
without worry.

I would like to see DSP based equalizer support someday, but I'm not
counting on it happening. Creative would need to release more specs to
allow access to and use the DSP to load the necessary firmware that
provides these effects features. (Including crystalizer)
