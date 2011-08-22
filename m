From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound/soc/mxs/mxs-saif.c: add missing kfree
Date: Mon, 22 Aug 2011 23:35:36 +0100
Message-ID: <20110822223535.GD29473@opensource.wolfsonmicro.com>
References: <1313820761-12042-3-git-send-email-julia@diku.dk>
	<20110820134439.GA2266@pengutronix.de>
	<Pine.LNX.4.64.1108201718200.30651@ask.diku.dk>
	<65EE16ACC360FA4D99C96DC085B3F7722212DF@039-SN1MPN1-001.039d.mgd.msft.net>
	<Pine.LNX.4.64.1108211318060.4072@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8AC5724337
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 00:35:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108211318060.4072@ask.diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Dong Aisheng-B29396 <B29396@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 21, 2011 at 01:18:45PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Move the test on pdev->id before the kzalloc to avoid requiring kfree when
> the test fails.  This fix was suggested by Wolfram Sang.
> 

Applied, thanks.
