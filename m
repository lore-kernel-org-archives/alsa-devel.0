From: Inha Song <ideal.song@samsung.com>
Subject: Re: [alsa-devel] [PATCH] mfd: arizona: Call the runtime PM function if
 the state is runtime resumed
Date: Mon, 21 Sep 2015 11:16:42 +0900
Message-ID: <20150921111642.112dc0c2@songinha-Samsung-DeskTop-System>
References: <1442478527-29304-1-git-send-email-ideal.song@samsung.com>
 <20150917082542.GB7694@ck-lbox>
 <20150917180530.346232ce@songinha-Samsung-DeskTop-System>
 <20150917091632.GC7694@ck-lbox>
 <20150918154903.549cf6d0@songinha-Samsung-DeskTop-System>
 <20150918082446.GD7694@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150918082446.GD7694@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi, Charles,

I've already tried to change.
If I change to that, we can't enter the suspen during the playback.

-
[   72.538263] arizona spi1.0: Suspend, disabling IRQ
...
[   72.585823] arizona spi1.0: Late suspend, reengabling IRQ
[   72.585904] arizona spi1.0: Early resume, disabling IRQ
...
[   72.646770] PM: noirq suspend of devices failed
		<- because of "spi1.0" pm_wakeup_pending() in suspend_noirq()
...
[   72.663623] s3c64xx_spi_resume
[   72.851089] arizona spi1.0: Late resume, reenabling IRQ


Best Regards,
Inha Song.


On Fri, 18 Sep 2015 09:24:46 +0100
Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:

> On Fri, Sep 18, 2015 at 03:49:03PM +0900, Inha Song wrote:
> > Hi,
> > 
> > I just change dev_err() to dev_info() in arizona-core.
> > 
> > 
> > root@localhost:~# aplay test.wav
> > [   42.731358] arizona spi1.0: Leaving AoD mode
> > ....
> > [   42.823514] s3c64xx_spi_runtime_resume
> > [   42.828270] arizona spi1.0: ASRC underclocked
> > [   42.828281] s3c64xx_spi_runtime_suspend
> > ....
> > -> suspend ()
> > [   72.398152] arizona spi1.0: Suspend, disabling IRQ
> > [   72.410471] s3c64xx_spi_runtime_resume
> > [   72.429045] s3c64xx_spi_suspend
> > -> spi suspended
> > [   72.429905] PM: suspend of devices complete after 67.309 msecs
> > [   72.440084] arizona spi1.0: Late suspend, reenabling IRQ
> > -> try to access spi irq after spi suspend()
> > [   72.440165] arizona spi1.0: Failed to read IRQ status: -108
> > [   72.440174] arizona spi1.0: Failed to read main IRQ status: -108
> > [   72.440242] arizona spi1.0: Failed to read IRQ status: -108
> > [   72.440249] arizona spi1.0: Failed to read main IRQ status: -108
> > [   72.440275] arizona spi1.0: Failed to read IRQ status: -108
> > [   72.440282] arizona spi1.0: Failed to read main IRQ status: -108
> > [   72.440304] arizona spi1.0: Failed to read IRQ status: -108
> 
> Ok so looking at the system PM code I think the problem here is
> there is currently a small window between when we enable this IRQ
> and when the suspend proceedure disables IRQs and this IRQ is
> sneaking in at that point.
> 
> Can you try the following diff and let me know what happens:
> 
> --- a/drivers/mfd/arizona-core.c
> +++ b/drivers/mfd/arizona-core.c
> @@ -727,7 +727,7 @@ const struct dev_pm_ops arizona_pm_ops = {
>                            NULL)
>         SET_SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
>  #ifdef CONFIG_PM_SLEEP
> -       .suspend_late = arizona_suspend_late,
> +       .suspend_noirq = arizona_suspend_late,
>         .resume_noirq = arizona_resume_noirq,
>  #endif
> 
> Thanks,
> Charles
