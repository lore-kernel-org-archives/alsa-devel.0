From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: WM8903: Add wm8903_set_gpio
Date: Wed, 19 Jan 2011 00:21:02 +0000
Message-ID: <20110119002102.GA4337@opensource.wolfsonmicro.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295393859-3396-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 743EC244A4
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 01:21:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295393859-3396-2-git-send-email-swarren@wwwdotorg.org>
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

On Tue, Jan 18, 2011 at 04:37:37PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>

This should be implemented using gpiolib - see WM8962 for an example of
this.  That way the control can be plugged into more other subsystems in
the kernel (probably including whenever I or someone else gets around to
it a widget like the one you open code in a later patch).  I know some
of the drivers do export the GPIOs using custom APIs but that's
something that should be fixed.

> Also, fix platform_data handling to have an explicit "don't touch this pin"
> option.

This should've been a separate patch since it's OK to go in as-is.

> Temporarily hack out the mic detection platform_data handling for simplicity

There's no patch restoring the functionality...

> tesing the GPIO changes. Should the write-sequencer enabling be conditional?

Yes.  It's not actually enabling the write sequencer itself, it's
enabling a low rate clock that's shared between a number of functions in
the device including jack detection.  Without the clock jack detection
will not function.
