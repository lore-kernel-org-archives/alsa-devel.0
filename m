From: Inha Song <ideal.song@samsung.com>
Subject: Re: [alsa-devel] [PATCH] mfd: arizona: Call the runtime PM function if
 the state is runtime resumed
Date: Fri, 18 Sep 2015 15:49:03 +0900
Message-ID: <20150918154903.549cf6d0@songinha-Samsung-DeskTop-System>
References: <1442478527-29304-1-git-send-email-ideal.song@samsung.com>
 <20150917082542.GB7694@ck-lbox>
 <20150917180530.346232ce@songinha-Samsung-DeskTop-System>
 <20150917091632.GC7694@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150917091632.GC7694@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

I just change dev_err() to dev_info() in arizona-core.


root@localhost:~# aplay test.wav
[   42.731358] arizona spi1.0: Leaving AoD mode
....
[   42.823514] s3c64xx_spi_runtime_resume
[   42.828270] arizona spi1.0: ASRC underclocked
[   42.828281] s3c64xx_spi_runtime_suspend
....
-> suspend ()
[   72.398152] arizona spi1.0: Suspend, disabling IRQ
[   72.410471] s3c64xx_spi_runtime_resume
[   72.429045] s3c64xx_spi_suspend
-> spi suspended
[   72.429905] PM: suspend of devices complete after 67.309 msecs
[   72.440084] arizona spi1.0: Late suspend, reenabling IRQ
-> try to access spi irq after spi suspend()
[   72.440165] arizona spi1.0: Failed to read IRQ status: -108
[   72.440174] arizona spi1.0: Failed to read main IRQ status: -108
[   72.440242] arizona spi1.0: Failed to read IRQ status: -108
[   72.440249] arizona spi1.0: Failed to read main IRQ status: -108
[   72.440275] arizona spi1.0: Failed to read IRQ status: -108
[   72.440282] arizona spi1.0: Failed to read main IRQ status: -108
[   72.440304] arizona spi1.0: Failed to read IRQ status: -108
....
[   72.465525] s3c64xx_spi_resume
[   72.650760] arizona spi1.0: Late resume, reenabling IRQ
[   72.650819] [<ffffffc000089f8c>] dump_backtrace+0x0/0x12c
[   72.650824] [<ffffffc00008a0c8>] show_stack+0x10/0x1c
[   72.650832] [<ffffffc0009f1398>] dump_stack+0x78/0xc8
[   72.650838] [<ffffffc00009ade8>] warn_slowpath_common+0x98/0xd0
[   72.650842] [<ffffffc00009ae6c>] warn_slowpath_fmt+0x4c/0x58
[   72.650847] [<ffffffc0000e7f1c>] __enable_irq+0x40/0x8c
[   72.650851] [<ffffffc0000e7f9c>] enable_irq+0x34/0x74
[   72.650858] [<ffffffc0004d013c>] arizona_resume+0x24/0x38
[   72.650865] [<ffffffc0004b6bac>] dpm_run_callback+0x50/0x1a0
[   72.650870] [<ffffffc0004b728c>] device_resume+0x90/0x268
[   72.650874] [<ffffffc0004b88cc>] dpm_resume+0x120/0x350
[   72.650878] [<ffffffc0004b8f1c>] dpm_resume_end+0x10/0x28
[   72.650884] [<ffffffc0000e1bec>] suspend_devices_and_enter+0x138/0x7f4
[   72.650887] [<ffffffc0000e25bc>] pm_suspend+0x314/0x5bc
[   72.650893] [<ffffffc0000e0bc8>] state_store+0x7c/0xf0
[   72.650901] [<ffffffc00035ee58>] kobj_attr_store+0x10/0x24
[   72.650910] [<ffffffc00020e1e0>] sysfs_kf_write+0x40/0x4c
[   72.650914] [<ffffffc00020d664>] kernfs_fop_write+0xb8/0x180
[   72.650922] [<ffffffc0001a2ef4>] __vfs_write+0x2c/0x11c
[   72.650926] [<ffffffc0001a38f0>] vfs_write+0x90/0x170
[   72.650931] [<ffffffc0001a422c>] SyS_write+0x40/0xa0
-----

This irq failed errors are occured in enable_irq() that in arizona_suspend_late().
Becase of access the irq after spi suspend. (arizona->irq == spi->irq)

Best Regards,
Inha Song.

On Thu, 17 Sep 2015 10:16:32 +0100
Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:

> 
> OK so this is definitely that the SPI driver hasn't resumed
> yet. Could we also get DEBUG turned on in arizona-core here. I am
> interested to check where in the process the arizona
> suspend/resume ops are being called.
> 
> Thanks,
> Charles
