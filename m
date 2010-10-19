From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/25] ASoC: Overhaul Samsung drivers
Date: Tue, 19 Oct 2010 01:52:52 -0700
Message-ID: <20101019085252.GB10381@opensource.wolfsonmicro.com>
References: <1287471805-17952-1-git-send-email-jassisinghbrar@gmail.com>
	<053901cb6f5f$76b9dea0$642d9be0$%kim@samsung.com>
	<20101019110015.49dcb79b@anarsoul-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EF36F10387D
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 11:54:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20101019110015.49dcb79b@anarsoul-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, 'Jassi Brar' <jassi.brar@samsung.com>, 'Jassi Brar' <jassisinghbrar@gmail.com>, ben-linux@fluff.org, june.bae@samsung.com, sw.youn@samsung.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 19, 2010 at 11:00:15AM +0300, Vasily khoruzhick wrote:
> Kukjin Kim <kgene.kim@samsung.com> wrote:

> > > I suggest the patches 13,14,16 & 17 go via Kgene's Tree, and the rest via
> > > ASoC
> > > tree due to tight dependencies.

> > Hmm...in my opinion, it would be better to me if could send arch/arm/ stuff
> > to upstream via my tree even though there are dependencies.
> > Mark, how do you think?

> As for me, that's not a good idea. We'll get massive breakage during
> 2.6.37 merge window then. Here's example: my sound-related changes to
> machine files are merged through Ben's tree, but these changes aren't
> in asoc tree, so Jassi is no aware of them, but now these changes are
> outdated a bit due to device renaming. And this introduce compile
> breakage.

Since my primary development platforms are Samsung reference boards I'm
especially unenthusiastic about anything which creates cross-tree
issues.  My stock answer to things like this is that if we can't split
things up so that dependencies are avoided then we should create a
branch which can be pulled into both trees.
