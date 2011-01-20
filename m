From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/4] ASoC: WM8903: Expose GPIOs through
	gpiolib
Date: Thu, 20 Jan 2011 20:33:45 +0000
Message-ID: <20110120203344.GA1555@opensource.wolfsonmicro.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295470205-26501-2-git-send-email-swarren@nvidia.com>
	<20110120115317.GC2551@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF03109556B6@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 91166243DE
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 21:33:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF03109556B6@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 20, 2011 at 09:23:45AM -0800, Stephen Warren wrote:

> Although mainly, I just made it consistent with wm8962.h, which I assume
> picked that value for the same reason.

8962 has a very different register map as it has compatiblity with some
very old devices.

> That said, the original value was OK for the GPIO registers, so I can revert
> that if you want.

It did stick out as a bit random.

> > These should also set GPn_FN - to zero for GPIO output, 3 for GPIO
> > input.  Otherwise changing between input and output mode at runtime
> > won't do the right thing.  As a side effect of that you probably
> > wouldn't need to specify the GPIO configuration in platform data.

> Ooops. I didn't notice that. How does this interact with bit 7; GPn_DIR? I
> assume both need to be set appropriately since they're both defined bits.

Yes, one controls the function and the other controls the pad mode.
