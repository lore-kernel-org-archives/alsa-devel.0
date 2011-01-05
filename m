From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: soc-cache: Use reg_def_copy
 instead of reg_cache_default
Date: Wed, 5 Jan 2011 17:08:20 -0600
Message-ID: <4D24F9E4.1080704@freescale.com>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
	<AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
	<20110105230339.GB5476@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by alsa0.perex.cz (Postfix) with ESMTP id 8B76424434
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 00:08:29 +0100 (CET)
In-Reply-To: <20110105230339.GB5476@opensource.wolfsonmicro.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> In general the expectation is that unless it's got a good reason not to
> a well written CODEC driver will use all the standard register cache
> infrastructure, including providing a set of defaults.  Good reasons for
> this include things like not having any registers and indeterminate
> default hardware state.

My concern is that I think it's unwise to hard-code the default values of the
registers in the source file.  Who's to say that a newer version of the chip
won't have different power-on defaults?

I do want to support a register cache, but I don't want to hard-code the default
values into cs4270.c.  Is this supported?

> As you will doubtless have seen when you looked at the code every other
> reference to reg_cache_default checks to see if it's set before using
> it.  This does rather suggest that the intention of the code is that it
> be optional.

So are you saying that there's a bug in this patch?  Perhaps that code should
look like this:

if (codec_drv->reg_cache_default)
	codec->reg_def_copy = kmemdup(codec_drv->reg_cache_default, reg_size, GFP_KERNEL);
else {
	codec->reg_def_copy = kmalloc(reg_size, GFP_KERNEL);
	// here we somehow tell the codec driver to initialize reg_def_copy
}

-- 
Timur Tabi
Linux kernel developer at Freescale
