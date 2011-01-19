From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] Tegra: Add internal speaker support
Date: Wed, 19 Jan 2011 00:25:14 +0000
Message-ID: <20110119002513.GB4337@opensource.wolfsonmicro.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AFB7824434
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 01:25:14 +0100 (CET)
Content-Disposition: inline
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
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 18, 2011 at 04:37:36PM -0700, Stephen Warren wrote:

> a) Is this the right way to expose GPIO APIs from a codec? The tlv320aic3
>    seems to do it this way, but wm8962.c uses the generic GPIO API. I shied
>    away from the latter, since I wasn't sure how to name the WM8903's GPIOs
>    in the gpio_* calls. I suppose it'd need a bunch of GPIO driver platform
>    data to hook it all together and name GPIOs from a mach-tegra/include
>    header file, but if this is the way to go, I need to read up on that more.

What naming is required for the GPIOs?  GPIOs are referred to by number
in Linux.

> b) Is the WM8903 platform_data handling full fleshed out; simply by having
>    platform_data, WM8903_WSEQ_ENA is set, whereas without any pdata, it
>    isn't. Should this be conditional, or should I always have specified some
>    platform data for Tegra, and I'm just getting lucky that it works without
>    any?

Ah, your comment about the sequencer is clearer now.  This is not
enabling the write sequencer, that'll be done transiently when required
if it's not set here.  It's enabling a clock which is used by several
parts of the chip including the write sequencer all the time so that the
mic detection can function in the absence of any other software managing
it.  This is why it's conditional on microphone detection being
configured, other functions can have this clock disabled most of the
time.
