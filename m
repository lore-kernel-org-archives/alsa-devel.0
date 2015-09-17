From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mfd: arizona: Call the runtime PM function
 if the state is runtime resumed
Date: Thu, 17 Sep 2015 10:16:32 +0100
Message-ID: <20150917091632.GC7694@ck-lbox>
References: <1442478527-29304-1-git-send-email-ideal.song@samsung.com>
 <20150917082542.GB7694@ck-lbox>
 <20150917180530.346232ce@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A5652651D3
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 11:40:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150917180530.346232ce@songinha-Samsung-DeskTop-System>
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

On Thu, Sep 17, 2015 at 06:05:30PM +0900, Inha Song wrote:
> Hi,
> 
> 
> It is a log:
> 
> # aplay
> [   79.590767] s3c64xx_spi_runtime_resume
> [   79.592288] arizona spi1.0: ASRC underclocked
> [   79.592331] s3c64xx_spi_runtime_suspend
> ---
> -> suspend ()
> 
> [   83.348754] s3c64xx_spi_runtime_resume
> [   83.367711] s3c64xx_spi_suspend
> [   83.368420] PM: suspend of devices complete after 59.666 msecs
> [   83.375584] arizona spi1.0: Failed to read IRQ status: -108
> [   83.375595] arizona spi1.0: Failed to read main IRQ status: -108
> [   83.375672] arizona spi1.0: Failed to read IRQ status: -108
> [   83.375679] arizona spi1.0: Failed to read main IRQ status: -108
> [   83.375749] arizona spi1.0: Failed to read IRQ status: -108
> .....
> [   83.580360] Call trace:
> [   83.580369] [<ffffffc000089f8c>] dump_backtrace+0x0/0x12c
> [   83.580373] [<ffffffc00008a0c8>] show_stack+0x10/0x1c
> [   83.580380] [<ffffffc0009f10e4>] dump_stack+0x78/0xc8
> [   83.580386] [<ffffffc00009ade8>] warn_slowpath_common+0x98/0xd0
> [   83.580390] [<ffffffc00009ae6c>] warn_slowpath_fmt+0x4c/0x58
> [   83.580394] [<ffffffc0000e7f1c>] __enable_irq+0x40/0x8c
> [   83.580399] [<ffffffc0000e7f9c>] enable_irq+0x34/0x74
> [   83.580404] [<ffffffc0004d00d0>] arizona_resume+0x10/0x20
> [   83.580410] [<ffffffc0004b6bac>] dpm_run_callback+0x50/0x1a0
> [   83.580414] [<ffffffc0004b728c>] device_resume+0x90/0x268
> [   83.580418] [<ffffffc0004b88cc>] dpm_resume+0x120/0x350
> [   83.580422] [<ffffffc0004b8f1c>] dpm_resume_end+0x10/0x28
> [   83.580426] [<ffffffc0000e1bec>] suspend_devices_and_enter+0x138/0x7f4
> [   83.580430] [<ffffffc0000e25bc>] pm_suspend+0x314/0x5bc
> [   83.580435] [<ffffffc0000e0bc8>] state_store+0x7c/0xf0
> [   83.580441] [<ffffffc00035ee58>] kobj_attr_store+0x10/0x24
> [   83.580448] [<ffffffc00020e1e0>] sysfs_kf_write+0x40/0x4c
> [   83.580452] [<ffffffc00020d664>] kernfs_fop_write+0xb8/0x180
> [   83.580458] [<ffffffc0001a2ef4>] __vfs_write+0x2c/0x11c
> [   83.580463] [<ffffffc0001a38f0>] vfs_write+0x90/0x170
> [   83.580467] [<ffffffc0001a422c>] SyS_write+0x40/0xa0

OK so this is definitely that the SPI driver hasn't resumed
yet. Could we also get DEBUG turned on in arizona-core here. I am
interested to check where in the process the arizona
suspend/resume ops are being called.

Thanks,
Charles
