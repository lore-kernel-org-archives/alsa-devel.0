From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: Device tree support for WM8994 and WM9713.
Date: Wed, 23 Nov 2011 11:33:53 +0530
Message-ID: <1322028233.1516.239.camel@vkoul-udesk3>
References: <CAJuYYwRZcbsRz-+2Swck=PUXT+iHeRWN3fu-R8C7tBYUb1Pgqw@mail.gmail.com>
	<20111122124212.GC30048@opensource.wolfsonmicro.com>
	<CAJuYYwSyTqPn3QfZrMx6_9jwtngOGW5B5pxjuTy4JtrTGgC6pw@mail.gmail.com>
	<20111122194335.GB25453@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 9620910382F
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 07:07:29 +0100 (CET)
In-Reply-To: <20111122194335.GB25453@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-11-22 at 19:43 +0000, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 08:09:49PM +0530, Thomas Abraham wrote:
> 
> > Though platform data of wm8994 is not required for smdkv310, there are
> > other boards 'goni' and 'aquila' which use the platform data. So to
> > start with, we can ignore the platform data of wm8994 but having full
> > dt support would be required for other boards.
> 
> Looking at those they're going to need the regulator bindings for device
> tree to do anything useful.  I'd expect that to go into 3.3 but it'll be
> hassle propagating the binding bits.
I have a question here, how does using DT to a codec (which can be used
even on a system where there is no DT present) be generic and break the
assumption that codec does not know anything about the system it
operates in?
This should be done for machine or cpu driver which know if system has
DT or not?

-- 
~Vinod
