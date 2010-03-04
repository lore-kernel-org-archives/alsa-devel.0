From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add delay information for Samsung
 IISv2 DAIs
Date: Thu, 4 Mar 2010 14:01:15 +0000
Message-ID: <20100304140115.GA3277@rakim.wolfsonmicro.main>
References: <1267704358-31501-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1b68c6791003040518k21b0894ap150bcad6a1195da3@mail.gmail.com>
	<20100304132416.GB12350@sirena.org.uk>
	<1b68c6791003040538u2e6cac5bjd3cdb5fa642d3967@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2FFA5243B4
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 15:01:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003040538u2e6cac5bjd3cdb5fa642d3967@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 04, 2010 at 10:38:39PM +0900, jassi brar wrote:
> On Thu, Mar 4, 2010 at 10:24 PM, Mark Brown
> > On Thu, Mar 04, 2010 at 10:18:59PM +0900, jassi brar wrote:

> >> I am trying to make functions in s3c-i2s-v2.c re-entrant as much as possible,
> >> 'delay' too seems to be a good candidate.

> > Could you expand on what you mean by this?

> I mean, 'delay' is such a trival func that it can perhaps do
> controller specific stuff
> after checking some flag(new) in s3c_i2sv2_info.

OK, that's nothing to do with the normal definition of "reentrant" -
normally reentrancy means the ability to handle simultaneous calls from
multiple threads of execution which is not at all relevant here since
supporting more hardware is an orthogonal issue.

> > All we're doing here is
> > directly reporting a value read from a memory mapped register so there's
> > nothing to be worried about from a locking point of view unless there
> > were a multi-core system and the bus to the IP needed some locking,
> > which is vanishingly unlikely to ever happen.

> As I said, I am OK. I just see this func being modified soon to handle
> i2sv4 too.

Looking at the hardware I suspect that all you'd be able to do would be
try to take a guess as to which of the FIFOs you might want to report on
or faff around averaging them but given that everything is clocked in
lockstep I'm not sure it's worth bothering.
