From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH] dma: add support for reporting pause and resume
 separately
Date: Fri, 6 Jul 2018 11:30:36 +0530
Message-ID: <20180706060036.GR22377@vkoul-mobl>
References: <CGME20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65@eucas1p2.samsung.com>
 <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
 <20180704070033.GA22377@vkoul-mobl>
 <CAHp75Vfy8=i3dSYoQ5Uto-RtmU6E8BVWU1dmG8BihN=Wtkr+_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vfy8=i3dSYoQ5Uto-RtmU6E8BVWU1dmG8BihN=Wtkr+_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, dmaengine <dmaengine@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 04-07-18, 13:38, Andy Shevchenko wrote:
> On Wed, Jul 4, 2018 at 10:00 AM, Vinod <vkoul@kernel.org> wrote:
> > Hi Marek,
> >
> > On 02-07-18, 15:08, Marek Szyprowski wrote:
> >> 'cmd_pause' DMA channel capability means that respective DMA engine
> >> supports both pausing and resuming given DMA channel. However, in some
> >> cases it is important to know if DMA channel can be paused without the
> >> need to resume it. This is a typical requirement for proper residue
> >> reading on transfer timeout in UART drivers. There are also some DMA
> >> engines with limited hardware, which doesn't really support resuming.
> >
> > Am curious given that your hardware does not support resume, what was motivation
> > for adding pause?
> >
> >> Reporting pause and resume capabilities separately allows UART drivers to
> >> properly check for the really required capabilities and operate in DMA
> >> mode also in systems with limited DMA hardware. On the other hand drivers,
> >> which rely on full channel suspend/resume support, should now check for
> >> both 'pause' and 'resume' features.
> >>
> >> Existing clients of dma_get_slave_caps() have been checked and the only
> >> driver which rely on proper channel resuming is soc-generic-dmaengine-pcm
> >> driver, which has been updated to check the newly added capability.
> >> Existing 'cmd_pause' now only indicates that DMA engine support pausing
> >> given DMA channel.
> >
> > The change looks fine to me. I was hoping that serial would also check
> > this..
> 
> AFAIU serial does not need to resume.

I meant the serial should check for Pause capability..

-- 
~Vinod
