From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 0/3] Tegra: Add internal speaker support
Date: Tue, 18 Jan 2011 16:29:37 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310955319@HQMAIL01.nvidia.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<20110119002513.GB4337@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id B1768244AB
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 01:29:48 +0100 (CET)
In-Reply-To: <20110119002513.GB4337@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Jan 18, 2011 at 04:37:36PM -0700, Stephen Warren wrote:
> 
> > a) Is this the right way to expose GPIO APIs from a codec? The tlv320aic3
> >    seems to do it this way, but wm8962.c uses the generic GPIO API. I shied
> >    away from the latter, since I wasn't sure how to name the WM8903's GPIOs
> >    in the gpio_* calls. I suppose it'd need a bunch of GPIO driver platform
> >    data to hook it all together and name GPIOs from a mach-tegra/include
> >    header file, but if this is the way to go, I need to read up on that more.
> 
> What naming is required for the GPIOs?  GPIOs are referred to by number
> in Linux.

Naming/numbering mean the same thing to me; I have to pass a number to
gpio_request/gpio_set_value, either by hard-coded number or name (i.e. #define
referring to some number).

I'll go read up on gpiolib some more to see how those API-level numbers get
mapped to a specific controller and GPIO number.

-- 
nvpublic
