From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] mfd: arizona: Call the runtime PM
 function if the state is runtime resumed
Date: Wed, 23 Sep 2015 15:43:12 +0100
Message-ID: <20150923144312.GA5432@ck-lbox>
References: <1442478527-29304-1-git-send-email-ideal.song@samsung.com>
 <20150917082542.GB7694@ck-lbox>
 <20150917180530.346232ce@songinha-Samsung-DeskTop-System>
 <20150917091632.GC7694@ck-lbox>
 <20150918154903.549cf6d0@songinha-Samsung-DeskTop-System>
 <20150918082446.GD7694@ck-lbox>
 <20150921111642.112dc0c2@songinha-Samsung-DeskTop-System>
 <20150922074618.GA11647@ck-lbox>
 <20150923110404.1b484284@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150923110404.1b484284@songinha-Samsung-DeskTop-System>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com, cw00.choi@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 23, 2015 at 11:04:04AM +0900, Inha Song wrote:
>  Hi, Charles,
> 
> I saw the log with LOG_DEVICE in regmap. But, I'm not sure the reason that suspend noirq failed is IRQ occuring.
> 
> Here is my log:
> --
> root@localhost:~# aplay test.wav 
> [   41.049072] s3c64xx_spi_runtime_suspend
> [   41.056043] arizona spi1.0: ASRC underclocked
> ....
> [   72.308238] arizona spi1.0: Suspend, disabling IRQ
> [   72.320286] arizona spi1.0: 400 <= 0
> [   72.320310] s3c64xx_spi_runtime_resume
> [   72.336047] arizona spi1.0: 51a <= 0
> [   72.336217] arizona spi1.0: 101 <= 8604
> [   72.336401] arizona spi1.0: 171 <= 3
> [   72.336425] arizona spi1.0: 171 <= 2
> [   72.336731] arizona spi1.0: 171 <= 0
> [   72.336751] arizona spi1.0: SYSCLK cleared
> [   72.338584] arizona spi1.0: SYSCLK cleared

This bit looks likely related to your problem, it looks like the
FLL is being turned off. My guess here would be that you haven't
called snd_soc_dapm_ignore_suspend from your machine driver, you
need to call this for all end points that may want to stay
powered up during system suspend and also set the ignore_suspend
flag on any DAI links you want to remain active during system
suspend.

Likely what is happening here is that you are disabling the FLL
and this is causing some IRQ which is then causing a wake event
thus aborting the suspend.

Thanks,
Charles
