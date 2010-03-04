From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add delay information for
	Samsung	IISv2 DAIs
Date: Thu, 4 Mar 2010 14:37:41 +0000
Message-ID: <20100304143741.GC12350@sirena.org.uk>
References: <1267704358-31501-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1b68c6791003040518k21b0894ap150bcad6a1195da3@mail.gmail.com>
	<20100304132416.GB12350@sirena.org.uk>
	<1b68c6791003040538u2e6cac5bjd3cdb5fa642d3967@mail.gmail.com>
	<20100304140115.GA3277@rakim.wolfsonmicro.main>
	<1b68c6791003040616n6f13a926xa804ec06ff5de51b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CB0224385
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 15:37:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003040616n6f13a926xa804ec06ff5de51b@mail.gmail.com>
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

On Thu, Mar 04, 2010 at 11:16:37PM +0900, jassi brar wrote:
> On Thu, Mar 4, 2010 at 11:01 PM, Mark Brown

> > OK, that's nothing to do with the normal definition of "reentrant" -
> > normally reentrancy means the ability to handle simultaneous calls from
> > multiple threads of execution which is not at all relevant here since
> > supporting more hardware is an orthogonal issue.

> That is but one out of many criteria, another is that the func works
> only on the data
> provided to it by the caller.

Of course, but my point is that it's confusing to talk about additional
hardware support as reentrancy.
