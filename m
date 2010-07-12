From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Add Aquila sound driver
Date: Mon, 12 Jul 2010 10:41:58 +0100
Message-ID: <20100712094157.GD21840@rakim.wolfsonmicro.main>
References: <4C355AC2.8090502@samsung.com>
	<20100708070549.GA29850@opensource.wolfsonmicro.com>
	<4C368794.2040600@samsung.com>
	<20100709024215.GA13944@opensource.wolfsonmicro.com>
	<4C369DA7.6070902@samsung.com> <4C3AC30D.2000107@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EF45124362
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 11:41:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C3AC30D.2000107@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 12, 2010 at 04:23:57PM +0900, Chanwoo Choi wrote:

> After upgrading existing i2s CPU drivers to run sound on Aquila board,
> Should I post this patch to upstream kernel?
> Or,
> Now, I post this patch which haven't used i2sv5 CPU driver to upstream kernel.
> Then, I will implement it and post incremental patch using it to run
> on Aquila board.

> Could you give me the opinion about this question?

I think whatever is easiest for you guys is fine - whatever is done in
the board specific code is only really going to impact people who have
Aquilla boards so the main thing is it makes sense to those people.
