From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 12:33:30 -0600
Message-ID: <4D2B50FA.9060102@freescale.com>
References: <1294675292-6289-1-git-send-email-timur@freescale.com>
	<1294676990.11031.10.camel@dplaptop.localdomain>
	<4D2B34C1.7050209@freescale.com>
	<1294677365.11031.13.camel@dplaptop.localdomain>
	<4D2B4376.101@freescale.com>
	<20110110182302.GB26137@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 3AD392458D
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 19:33:38 +0100 (CET)
In-Reply-To: <20110110182302.GB26137@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> It's supposed to be 1 for change, 0 for no change or an error - if you
> look at the core functions you'll see that they generally all follow
> this idiom of using the return value from snd_soc_update_bits() directly.

Ok, so that all works then.

I found another issue.  snd_soc_update_bits() breaks if snd_soc_read() returns a
negative number, so I'll fix that.  But why do the I/O functions in soc-cache.c
do this:

static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
				       unsigned int reg)
{
...
	ret = snd_soc_cache_read(codec, reg, &val);
	if (ret < 0)
		return -1;


What's wrong with:

	if (ret < 0)
		return ret;

-- 
Timur Tabi
Linux kernel developer at Freescale
