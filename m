From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 18:36:15 +0000
Message-ID: <20110110183615.GC26137@opensource.wolfsonmicro.com>
References: <1294675292-6289-1-git-send-email-timur@freescale.com>
	<1294676990.11031.10.camel@dplaptop.localdomain>
	<4D2B34C1.7050209@freescale.com>
	<1294677365.11031.13.camel@dplaptop.localdomain>
	<4D2B4376.101@freescale.com>
	<20110110182302.GB26137@opensource.wolfsonmicro.com>
	<4D2B50FA.9060102@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC35D2458D
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 19:38:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D2B50FA.9060102@freescale.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 10, 2011 at 12:33:30PM -0600, Timur Tabi wrote:

> static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
> 				       unsigned int reg)
> {
> ...
> 	ret = snd_soc_cache_read(codec, reg, &val);
> 	if (ret < 0)
> 		return -1;

> What's wrong with:

> 	if (ret < 0)
> 		return ret;

Note that the return value of the read functions is an unsigned int
rather than an int.
