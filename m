From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Add support for NULL
	default register	caches
Date: Mon, 10 Jan 2011 23:48:25 +0000
Message-ID: <20110110234824.GA5399@opensource.wolfsonmicro.com>
References: <1294654256-1012-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<4D2B83EC.4000400@freescale.com>
	<20110110222938.GD5886@opensource.wolfsonmicro.com>
	<4D2B8AC0.2010001@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1414224158
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 00:48:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D2B8AC0.2010001@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 10, 2011 at 04:40:00PM -0600, Timur Tabi wrote:

> The CS4270 registers are numbered from 1 through 8, so codec_reg should look
> like this:

>  1:   c3
>  2:    0
>  3:   30
>  4:    0
>  5:    0
>  6:    0
>  7:    0
>  8:    0

> What I don't know is why the bad output, but it's probably because the register
> cache code broke during the various changes applied to it since multi-component
> was introduced.  Originally, the driver handled the register cache completely
> internally.  Then, as register caching was added to ASoC itself, the driver was
> modified to use it.  I believe that those modifications were not really tested.

The issue is that you were using 1 based array indexing and the core
uses zero based indexing - nothing dramatically wrong and it should've
fallen through to using the hardware I/O when it went beyond the cache
so I'd expect things to work fine.  The read failure for register zero
was handled gracefully, so it looks like everything did what I'd expect
here.
