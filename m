From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] mfd: arizona: Call the runtime PM
 function if the state is runtime resumed
Date: Thu, 17 Sep 2015 09:25:42 +0100
Message-ID: <20150917082542.GB7694@ck-lbox>
References: <1442478527-29304-1-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442478527-29304-1-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2015 at 05:28:47PM +0900, Inha Song wrote:
> This patch call runtiem PM function manually if the state is runtime resumed
> before enter suspend.
> 
> This case has occurred when wake-up by the resume after entering to
> suspend during the playback.
> $ aplay -> runtime_resume() -> suspend() -> resume()
> 
> In this case, Can occurred an error when enter suspend.
> --
> [   82.559234] PM: suspend of devices complete after 57.252 msecs
> [   82.567978] arizona spi1.0: Failed to read IRQ status: -108
> [   82.567989] arizona spi1.0: Failed to read main IRQ status: -108
> [   82.568027] arizona spi1.0: Failed to read IRQ status: -108
> [   82.568036] arizona spi1.0: Failed to read main IRQ status: -108

Would it be possible to get some more detail on what is happening
here? A full log would be nice with DEBUG enabled in
arizona-core.c, also perhaps put some printk's in the SPI driver
suspend/resume as well.

It looks like what is happening is that the system is attempting
to handle an IRQ before the SPI has been resumed. But that is
exactly what the irq enables/disables in the system PM ops in
Arizona are trying to avoid.

> ....
> So, we should call runtime_suspend() manually when enter suspend
> if the state is runtime resume.

There are many use-cases where we want to leave the CODEC enabled
whilst the system is suspended so we really don't want to be
doing a runtime suspend with every system suspend.

Thanks,
Charles
