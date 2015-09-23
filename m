From: Inha Song <ideal.song@samsung.com>
Subject: Re: [alsa-devel] [PATCH] mfd: arizona: Call the runtime PM function if
 the state is runtime resumed
Date: Wed, 23 Sep 2015 11:04:04 +0900
Message-ID: <20150923110404.1b484284@songinha-Samsung-DeskTop-System>
References: <1442478527-29304-1-git-send-email-ideal.song@samsung.com>
 <20150917082542.GB7694@ck-lbox>
 <20150917180530.346232ce@songinha-Samsung-DeskTop-System>
 <20150917091632.GC7694@ck-lbox>
 <20150918154903.549cf6d0@songinha-Samsung-DeskTop-System>
 <20150918082446.GD7694@ck-lbox>
 <20150921111642.112dc0c2@songinha-Samsung-DeskTop-System>
 <20150922074618.GA11647@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150922074618.GA11647@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com, cw00.choi@samsung.com
List-Id: alsa-devel@alsa-project.org

 Hi, Charles,

I saw the log with LOG_DEVICE in regmap. But, I'm not sure the reason that suspend noirq failed is IRQ occuring.

Here is my log:
--
root@localhost:~# aplay test.wav 
[   40.831047] arizona spi1.0: Leaving AoD mode
[   40.834448] s3c64xx_spi_runtime_resume
[   40.834876] arizona spi1.0: d23 => 1
[   40.835029] s3c64xx_spi_runtime_suspend
[   40.846040] s3c64xx_spi_runtime_resume
[   40.846423] arizona spi1.0: d23 => 100
[   40.846557] s3c64xx_spi_runtime_suspend
[   40.846771] arizona spi1.0: d04 <= 100
[   40.846956] s3c64xx_spi_runtime_resume
[   40.852145] s3c64xx_spi_runtime_suspend
[   40.852386] s3c64xx_spi_runtime_resume
[   40.852894] s3c64xx_spi_runtime_suspend
[   40.854307] s3c64xx_spi_runtime_resume
[   40.858375] arizona spi1.0: d40 => 3
[   40.858410] s3c64xx_spi_runtime_suspend
[   40.865429] s3c64xx_spi_runtime_resume
[   40.869637] arizona spi1.0: d02 <= 2040
[   40.869671] s3c64xx_spi_runtime_suspend
[   40.876836] s3c64xx_spi_runtime_resume
[   40.880749] arizona spi1.0: Spurious HPDET IRQ
[   40.880773] arizona spi1.0: FLL1: Fref=24000000 Fout=135475200
[   40.880787] arizona spi1.0: FLL1: Fvco=90316800Hz
[   40.880793] s3c64xx_spi_runtime_suspend
[   40.880803] arizona spi1.0: FLL1: GCD=19200
[   40.880817] arizona spi1.0: FLL1: N=7 THETA=149 LAMBDA=271
[   40.880831] arizona spi1.0: FLL1: FRATIO=0(0) OUTDIV=2 REFCLK_DIV=1
[   40.880842] arizona spi1.0: FLL1: GAIN=4
[   40.880886] arizona spi1.0: 171 <= 1
[   40.880944] s3c64xx_spi_runtime_resume
[   40.881218] s3c64xx_spi_runtime_suspend
[   40.930152] s3c64xx_spi_runtime_resume
[   40.934071] arizona spi1.0: d26 => 1
[   40.934140] s3c64xx_spi_runtime_suspend
[   40.941237] arizona spi1.0: Mixer dropped sample
[   40.945901] s3c64xx_spi_runtime_resume
[   40.950067] arizona spi1.0: d40 => 3
[   40.950091] s3c64xx_spi_runtime_suspend
[   40.957025] s3c64xx_spi_runtime_resume
[   40.960971] arizona spi1.0: d04 <= 1
[   40.961006] s3c64xx_spi_runtime_suspend
[   40.968106] s3c64xx_spi_runtime_resume
[   40.971956] arizona spi1.0: FLL1: clock OK
[   40.971987] s3c64xx_spi_runtime_suspend
[   40.979751] arizona spi1.0: SYSCLK set to 135475200Hz
[   40.984742] wm5110-codec wm5110-codec: AIF1: BCLK 1411200Hz LRCLK 44100Hz
[   40.992144] arizona spi1.0: SYSCLK set to 135475200Hz
[   40.996646] arizona spi1.0: 101 <= 8644
[   41.000360] s3c64xx_spi_runtime_resume
[   41.004300] arizona spi1.0: 51a <= 1
[   41.004357] s3c64xx_spi_runtime_suspend
[   41.011499] s3c64xx_spi_runtime_resume
[   41.015689] arizona spi1.0: 400 <= 8
[   41.015692] s3c64xx_spi_runtime_suspend
[   41.022581] s3c64xx_spi_runtime_resume
[   41.026735] arizona spi1.0: d40 => 3
[   41.026737] s3c64xx_spi_runtime_suspend
[   41.033687] s3c64xx_spi_runtime_resume
[   41.037765] arizona spi1.0: d02 <= 40
[   41.037800] s3c64xx_spi_runtime_suspend
[   41.044883] s3c64xx_spi_runtime_resume
[   41.049054] arizona spi1.0: d26 => 8
[   41.049072] s3c64xx_spi_runtime_suspend
[   41.056043] arizona spi1.0: ASRC underclocked
....
[   72.308238] arizona spi1.0: Suspend, disabling IRQ
[   72.320286] arizona spi1.0: 400 <= 0
[   72.320310] s3c64xx_spi_runtime_resume
[   72.336047] arizona spi1.0: 51a <= 0
[   72.336217] arizona spi1.0: 101 <= 8604
[   72.336401] arizona spi1.0: 171 <= 3
[   72.336425] arizona spi1.0: 171 <= 2
[   72.336731] arizona spi1.0: 171 <= 0
[   72.336751] arizona spi1.0: SYSCLK cleared
[   72.338584] arizona spi1.0: SYSCLK cleared
[   72.339123] s3c64xx_spi_suspend
[   72.355866] arizona spi1.0: Late suspend, reenabling IRQ
[   72.355893] >>> noirq failed because of spi1
[   72.355948] arizona spi1.0: Early resume, disabling IRQ
[   72.416798] PM: noirq suspend of devices failed
......

Best Regards,
Inha Song.

On Tue, 22 Sep 2015 08:46:18 +0100
Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:

> On Mon, Sep 21, 2015 at 11:16:42AM +0900, Inha Song wrote:
> > Hi, Charles,
> > 
> > I've already tried to change.
> > If I change to that, we can't enter the suspen during the playback.
> > 
> > -
> > [   72.538263] arizona spi1.0: Suspend, disabling IRQ
> > ...
> > [   72.585823] arizona spi1.0: Late suspend, reengabling IRQ
> > [   72.585904] arizona spi1.0: Early resume, disabling IRQ
> > ...
> > [   72.646770] PM: noirq suspend of devices failed
> > 		<- because of "spi1.0" pm_wakeup_pending() in suspend_noirq()
> 
> Ok this looks more reasonable, suspend should fail because we do
> have an IRQ waiting to be handled, so we shouldn't suspend. But
> you are saying this happens every time the CODEC goes to suspend,
> thus blocking the suspend from suspending?
> 
> First step then would be to identify what IRQ is occurring, could
> you set LOG_DEVICE at the top of drivers/base/regmap/regmap.c to
> "spi1.0" and provide a log, so we can see what IRQ is being
> asserted from the CODEC.
> 
> Thanks,
> Charles
> 
