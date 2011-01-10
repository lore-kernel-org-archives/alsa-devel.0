From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Add support for NULL
 default register caches
Date: Mon, 10 Jan 2011 22:29:38 +0000
Message-ID: <20110110222938.GD5886@opensource.wolfsonmicro.com>
References: <1294654256-1012-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<4D2B83EC.4000400@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D95E24647
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 23:29:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D2B83EC.4000400@freescale.com>
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

On Mon, Jan 10, 2011 at 04:10:52PM -0600, Timur Tabi wrote:

> # cat ./devices/platform/soc-audio/playback/codec_reg
> cs4270-codec.0-004f registers
>  0: <no data: -5>
>  1:   c3
>  2:    0
>  3:   30
>  4:    0
>  5:    0
>  6:    0
>  7:    0

> So both patches need to be applied, however, I can't say whether Dimitris' patch
> is sufficient for handling NULL default register maps, since I removed that from
> my driver.

You've not identified what the issue is with the above?  Is it just that
nothing else ensured the cache was set up (eg, by doing reads from the
hardware)?
