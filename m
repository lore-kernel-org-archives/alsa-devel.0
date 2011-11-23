From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Device tree support for WM8994 and WM9713.
Date: Wed, 23 Nov 2011 10:28:15 +0000
Message-ID: <20111123102814.GH4332@opensource.wolfsonmicro.com>
References: <CAJuYYwRZcbsRz-+2Swck=PUXT+iHeRWN3fu-R8C7tBYUb1Pgqw@mail.gmail.com>
	<20111122124212.GC30048@opensource.wolfsonmicro.com>
	<CAJuYYwSyTqPn3QfZrMx6_9jwtngOGW5B5pxjuTy4JtrTGgC6pw@mail.gmail.com>
	<20111122194335.GB25453@opensource.wolfsonmicro.com>
	<1322028233.1516.239.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0069243D0
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 11:28:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322028233.1516.239.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2011 at 11:33:53AM +0530, Vinod Koul wrote:
> On Tue, 2011-11-22 at 19:43 +0000, Mark Brown wrote:

> > Looking at those they're going to need the regulator bindings for device
> > tree to do anything useful.  I'd expect that to go into 3.3 but it'll be
> > hassle propagating the binding bits.

> I have a question here, how does using DT to a codec (which can be used
> even on a system where there is no DT present) be generic and break the
> assumption that codec does not know anything about the system it
> operates in?
> This should be done for machine or cpu driver which know if system has
> DT or not?

When drivers implement device tree support this should be done in
addition to rather than instead of platform data support so other
platforms should not be affected.  A very common way of implementing
this is that the device tree parsing code translates the device tree
into a platform data structure and then the driver runs off a copy of
the platform data structure.
