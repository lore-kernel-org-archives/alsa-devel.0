From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] Tegra: Add internal speaker support
Date: Wed, 19 Jan 2011 12:47:20 +0000
Message-ID: <1295441240.3328.95.camel@odin>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id CA32524469
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 13:47:24 +0100 (CET)
Received: by wyi11 with SMTP id 11so791320wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 04:47:24 -0800 (PST)
In-Reply-To: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-18 at 16:37 -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Harmony has headers on the board for an internal speaker and internal mic.
> I've started looking at enabling these, along with full jack detection etc.
> This first set of patches is an RFC (Request For Comments) on whether it's
> the correct direction, particularly with respect to:
> 
> a) Is this the right way to expose GPIO APIs from a codec? The tlv320aic3
>    seems to do it this way, but wm8962.c uses the generic GPIO API. I shied
>    away from the latter, since I wasn't sure how to name the WM8903's GPIOs
>    in the gpio_* calls. I suppose it'd need a bunch of GPIO driver platform
>    data to hook it all together and name GPIOs from a mach-tegra/include
>    header file, but if this is the way to go, I need to read up on that more.
> 
> b) Is the WM8903 platform_data handling full fleshed out; simply by having
>    platform_data, WM8903_WSEQ_ENA is set, whereas without any pdata, it
>    isn't. Should this be conditional, or should I always have specified some
>    platform data for Tegra, and I'm just getting lucky that it works without
>    any?
> 
> Thanks for any coments.
> 

2 & 3 look fine and

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
