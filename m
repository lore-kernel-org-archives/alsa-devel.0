From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8804: fix error handling code
Date: Mon, 11 Oct 2010 13:59:34 +0100
Message-ID: <20101011125934.GM9231@rakim.wolfsonmicro.main>
References: <1286731745-18169-1-git-send-email-segooon@gmail.com>
	<20101011120014.GJ9231@rakim.wolfsonmicro.main>
	<20101011121555.GA32652@albatros>
	<20101011123609.GL9231@rakim.wolfsonmicro.main>
	<20101011125056.GA25041@albatros>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A618D10394C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 14:59:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20101011125056.GA25041@albatros>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasiliy Kulikov <segooon@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 11, 2010 at 04:50:56PM +0400, Vasiliy Kulikov wrote:

> It is not greppable situation to simply change the behavior of all
> drivers.  I was looking for memory leak bugs in drivers/net/ and fixed
> some of them.  Manual looking through _all_ drivers takes much more
> time.  In general I try to search for repeatable bugs with coccinelle,
> but it is rare case.

The method you're using to generate the patches is pretty much
orthogonal to anything else, except of course in the case where you're
also submitting the automation for checking (which is useful where
possible).
