From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mfd: arizona: Call the runtime PM function
 if the state is runtime resumed
Date: Fri, 18 Sep 2015 09:24:46 +0100
Message-ID: <20150918082446.GD7694@ck-lbox>
References: <1442478527-29304-1-git-send-email-ideal.song@samsung.com>
 <20150917082542.GB7694@ck-lbox>
 <20150917180530.346232ce@songinha-Samsung-DeskTop-System>
 <20150917091632.GC7694@ck-lbox>
 <20150918154903.549cf6d0@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 583F02604D3
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 10:48:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150918154903.549cf6d0@songinha-Samsung-DeskTop-System>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Inha Song <ideal.song@samsung.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, broonie@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 18, 2015 at 03:49:03PM +0900, Inha Song wrote:
> Hi,
> 
> I just change dev_err() to dev_info() in arizona-core.
> 
> 
> root@localhost:~# aplay test.wav
> [   42.731358] arizona spi1.0: Leaving AoD mode
> ....
> [   42.823514] s3c64xx_spi_runtime_resume
> [   42.828270] arizona spi1.0: ASRC underclocked
> [   42.828281] s3c64xx_spi_runtime_suspend
> ....
> -> suspend ()
> [   72.398152] arizona spi1.0: Suspend, disabling IRQ
> [   72.410471] s3c64xx_spi_runtime_resume
> [   72.429045] s3c64xx_spi_suspend
> -> spi suspended
> [   72.429905] PM: suspend of devices complete after 67.309 msecs
> [   72.440084] arizona spi1.0: Late suspend, reenabling IRQ
> -> try to access spi irq after spi suspend()
> [   72.440165] arizona spi1.0: Failed to read IRQ status: -108
> [   72.440174] arizona spi1.0: Failed to read main IRQ status: -108
> [   72.440242] arizona spi1.0: Failed to read IRQ status: -108
> [   72.440249] arizona spi1.0: Failed to read main IRQ status: -108
> [   72.440275] arizona spi1.0: Failed to read IRQ status: -108
> [   72.440282] arizona spi1.0: Failed to read main IRQ status: -108
> [   72.440304] arizona spi1.0: Failed to read IRQ status: -108

Ok so looking at the system PM code I think the problem here is
there is currently a small window between when we enable this IRQ
and when the suspend proceedure disables IRQs and this IRQ is
sneaking in at that point.

Can you try the following diff and let me know what happens:

--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -727,7 +727,7 @@ const struct dev_pm_ops arizona_pm_ops = {
                           NULL)
        SET_SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
 #ifdef CONFIG_PM_SLEEP
-       .suspend_late = arizona_suspend_late,
+       .suspend_noirq = arizona_suspend_late,
        .resume_noirq = arizona_resume_noirq,
 #endif

Thanks,
Charles
