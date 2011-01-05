From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: soc-cache: Use reg_def_copy
 instead of reg_cache_default
Date: Wed, 5 Jan 2011 23:03:39 +0000
Message-ID: <20110105230339.GB5476@opensource.wolfsonmicro.com>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
	<AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BA5D32442F
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 00:03:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
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

On Wed, Jan 05, 2011 at 03:04:31PM -0600, Timur Tabi wrote:

> Unlike all the other codec drivers, the CS4270 driver does not
> initialize codec_drv->reg_cache_default, so the pointer is NULL during
> the kmemdup() call.

> What is the criteria for defining reg_cache_default?  Many drivers
> don't define it:

In general the expectation is that unless it's got a good reason not to
a well written CODEC driver will use all the standard register cache
infrastructure, including providing a set of defaults.  Good reasons for
this include things like not having any registers and indeterminate
default hardware state.

As you will doubtless have seen when you looked at the code every other
reference to reg_cache_default checks to see if it's set before using
it.  This does rather suggest that the intention of the code is that it
be optional.
