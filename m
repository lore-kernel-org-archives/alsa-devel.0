From: Inha Song <ideal.song@samsung.com>
Subject: Re: [alsa-devel] [PATCH] mfd: arizona: Call the runtime PM function if
 the state is runtime resumed
Date: Fri, 25 Sep 2015 16:51:28 +0900
Message-ID: <20150925165128.391d2aaf@songinha-Samsung-DeskTop-System>
References: <20150917082542.GB7694@ck-lbox>
 <20150917180530.346232ce@songinha-Samsung-DeskTop-System>
 <20150917091632.GC7694@ck-lbox>
 <20150918154903.549cf6d0@songinha-Samsung-DeskTop-System>
 <20150918082446.GD7694@ck-lbox>
 <20150921111642.112dc0c2@songinha-Samsung-DeskTop-System>
 <20150922074618.GA11647@ck-lbox>
 <20150923110404.1b484284@songinha-Samsung-DeskTop-System>
 <20150923144312.GA5432@ck-lbox>
 <20150924103809.7be235d1@songinha-Samsung-DeskTop-System>
 <20150924074107.GC5432@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150924074107.GC5432@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com, cw00.choi@samsung.com
List-Id: alsa-devel@alsa-project.org

Hi, Charles,

On Thu, 24 Sep 2015 08:41:07 +0100
Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:

> On Thu, Sep 24, 2015 at 10:38:09AM +0900, Inha Song wrote:
> > Hi, Charles,
> > 
> > On Wed, 23 Sep 2015 15:43:12 +0100
> > Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:
> > 
> > > On Wed, Sep 23, 2015 at 11:04:04AM +0900, Inha Song wrote:
> > > >  Hi, Charles,
> > > > 
> > > > I saw the log with LOG_DEVICE in regmap. But, I'm not sure the reason that suspend noirq failed is IRQ occuring.
> > > > 
> > > > Here is my log:
> > > > --
> > > > root@localhost:~# aplay test.wav 
> > > > [   41.049072] s3c64xx_spi_runtime_suspend
> > > > [   41.056043] arizona spi1.0: ASRC underclocked
> > > > ....
> > > > [   72.308238] arizona spi1.0: Suspend, disabling IRQ
> > > > [   72.320286] arizona spi1.0: 400 <= 0
> > > > [   72.320310] s3c64xx_spi_runtime_resume
> > > > [   72.336047] arizona spi1.0: 51a <= 0
> > > > [   72.336217] arizona spi1.0: 101 <= 8604
> > > > [   72.336401] arizona spi1.0: 171 <= 3
> > > > [   72.336425] arizona spi1.0: 171 <= 2
> > > > [   72.336731] arizona spi1.0: 171 <= 0
> > > > [   72.336751] arizona spi1.0: SYSCLK cleared
> > > > [   72.338584] arizona spi1.0: SYSCLK cleared
> > > 
> > > This bit looks likely related to your problem, it looks like the
> > > FLL is being turned off. My guess here would be that you haven't
> > > called snd_soc_dapm_ignore_suspend from your machine driver, you
> > > need to call this for all end points that may want to stay
> > > powered up during system suspend and also set the ignore_suspend
> > > flag on any DAI links you want to remain active during system
> > > suspend.
> > 
> > But, We should call the trigger callback with SNDRV_PCM_TRIGGER_SUSPEND and *_RESUME command
> > for support senarios what suspend during the playback and resume.
> > So, I can't set the "ignore_suspend" in playback DAI.
> > 
> > For this reason, I would have called the runtime_suspend manually in arizona-core when suspend.
> > 
> > Best Reagrds,
> > Inha Song.
> > 
> 
> Ah ok so you want the audio to stop during suspend?

Yes, I want to stop when suspend and continuous play when resume.

> 
> Ok in that case can we get a bit more of log, your log finished
> up here:
> 
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
> [   72.339123] s3c64xx_spi_suspend
> [   72.355866] arizona spi1.0: Late suspend, reenabling IRQ
> [   72.355893] >>> noirq failed because of spi1
> [   72.355948] arizona spi1.0: Early resume, disabling IRQ
> [   72.416798] PM: noirq suspend of devices failed
> 
> Which finished too early as we can't see which IRQ it was that
> triggered the wakeup.

But, I can't find any spi regmap log that for IRQ.
--
[  114.282681] arizona spi1.0: Late suspend, reenabling IRQ
[  114.282708] >>> noirq failed because of spi1
[  114.282760] arizona spi1.0: Early resume, disabling IRQ
[  114.316510] PM: noirq suspend of devices failed
[  114.333590] s3c64xx_spi_resume

     -> set the FLL in machine for playback when resume.
[  114.334756] arizona spi1.0: FLL1: Fref=24000000 Fout=135475200
[  114.334762] arizona spi1.0: FLL1: Fvco=90316800Hz
[  114.334792] arizona spi1.0: FLL1: GCD=19200
[  114.334798] arizona spi1.0: FLL1: N=7 THETA=149 LAMBDA=271
[  114.334803] arizona spi1.0: FLL1: FRATIO=0(0) OUTDIV=2 REFCLK_DIV=1
[  114.334807] arizona spi1.0: FLL1: GAIN=4
[  114.334827] arizona spi1.0: 171 <= 1
[  114.520724] arizona spi1.0: Late resume, reenabling IRQ
[  114.521152] arizona spi1.0: d40 => 3
[  114.521387] arizona spi1.0: d04 <= 1
[  114.521500] arizona spi1.0: FLL1: clock OK
[  114.521773] arizona spi1.0: SYSCLK set to 135475200Hz
[  114.522651] arizona spi1.0: SYSCLK set to 135475200Hz
[  114.522752] arizona spi1.0: 101 <= 8644
[  114.522940] arizona spi1.0: 51a <= 1
[  114.523057] arizona spi1.0: 400 <= 8
[  114.909270] s3c64xx_spi_runtime_suspend
[  114.909721] done.
Suspended. Trying resume. Failed. Restarting stream. Done.

    -> retry to enter suspend Immediately.
[  115.478349] arizona spi1.0: Suspend, disabling IRQ
[  115.489783] arizona spi1.0: 400 <= 0
[  115.489804] s3c64xx_spi_runtime_resume
[  115.506127] arizona spi1.0: 51a <= 0
[  115.506298] arizona spi1.0: 101 <= 8604
[  115.506493] arizona spi1.0: 171 <= 3
[  115.506515] arizona spi1.0: 171 <= 2
[  115.506777] arizona spi1.0: 171 <= 0
[  115.506793] arizona spi1.0: SYSCLK cleared
[  115.507842] arizona spi1.0: SYSCLK cleared
[  115.508373] s3c64xx_spi_suspend                                                                                                     

[  115.523095] arizona spi1.0: Late suspend, reenabling IRQ                                                                            
[  115.523121] >>> noirq failed because of spi1                                                                                        
[  115.523171] arizona spi1.0: Early resume, disabling IRQ
[  115.556507] PM: noirq suspend of devices failed 
     -> Repeats:

Do you have any idea to check which IRQ was occur? 

Best Regards,
Inha Song.


> 
> Thanks,
> Charles
