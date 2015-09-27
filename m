From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mfd: arizona: Call the runtime PM function
 if the state is runtime resumed
Date: Sun, 27 Sep 2015 17:06:44 +0100
Message-ID: <20150927160644.GE5432@ck-lbox>
References: <20150917091632.GC7694@ck-lbox>
 <20150918154903.549cf6d0@songinha-Samsung-DeskTop-System>
 <20150918082446.GD7694@ck-lbox>
 <20150921111642.112dc0c2@songinha-Samsung-DeskTop-System>
 <20150922074618.GA11647@ck-lbox>
 <20150923110404.1b484284@songinha-Samsung-DeskTop-System>
 <20150923144312.GA5432@ck-lbox>
 <20150924103809.7be235d1@songinha-Samsung-DeskTop-System>
 <20150924074107.GC5432@ck-lbox>
 <20150925165128.391d2aaf@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 2245A2612D2
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2015 18:30:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150925165128.391d2aaf@songinha-Samsung-DeskTop-System>
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
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, broonie@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 25, 2015 at 04:51:28PM +0900, Inha Song wrote:
> Hi, Charles,
> 
> On Thu, 24 Sep 2015 08:41:07 +0100
> Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:
> 
> > On Thu, Sep 24, 2015 at 10:38:09AM +0900, Inha Song wrote:
> > > Hi, Charles,
> > > 
> > > On Wed, 23 Sep 2015 15:43:12 +0100
> > > Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:
> > > 
> > > > On Wed, Sep 23, 2015 at 11:04:04AM +0900, Inha Song wrote:
> > > > >  Hi, Charles,
> > > > > 
> > > > > I saw the log with LOG_DEVICE in regmap. But, I'm not sure the reason that suspend noirq failed is IRQ occuring.
> > > > > 
> > > > > Here is my log:
> > > > > --
> > > > > root@localhost:~# aplay test.wav 
> > > > > [   41.049072] s3c64xx_spi_runtime_suspend
> But, I can't find any spi regmap log that for IRQ.
> --
> [  114.282681] arizona spi1.0: Late suspend, reenabling IRQ
> [  114.282708] >>> noirq failed because of spi1
> [  114.282760] arizona spi1.0: Early resume, disabling IRQ
> [  114.316510] PM: noirq suspend of devices failed
> [  114.333590] s3c64xx_spi_resume
> 
>      -> set the FLL in machine for playback when resume.
> [  114.334756] arizona spi1.0: FLL1: Fref=24000000 Fout=135475200
> [  114.334762] arizona spi1.0: FLL1: Fvco=90316800Hz
> [  114.334792] arizona spi1.0: FLL1: GCD=19200
> [  114.334798] arizona spi1.0: FLL1: N=7 THETA=149 LAMBDA=271
> [  114.334803] arizona spi1.0: FLL1: FRATIO=0(0) OUTDIV=2 REFCLK_DIV=1
> [  114.334807] arizona spi1.0: FLL1: GAIN=4
> [  114.334827] arizona spi1.0: 171 <= 1
> [  114.520724] arizona spi1.0: Late resume, reenabling IRQ
> [  114.521152] arizona spi1.0: d40 => 3
> [  114.521387] arizona spi1.0: d04 <= 1
> [  114.521500] arizona spi1.0: FLL1: clock OK
> [  114.521773] arizona spi1.0: SYSCLK set to 135475200Hz
> [  114.522651] arizona spi1.0: SYSCLK set to 135475200Hz
> [  114.522752] arizona spi1.0: 101 <= 8644
> [  114.522940] arizona spi1.0: 51a <= 1
> [  114.523057] arizona spi1.0: 400 <= 8
> [  114.909270] s3c64xx_spi_runtime_suspend
> [  114.909721] done.
> Suspended. Trying resume. Failed. Restarting stream. Done.
> 
>     -> retry to enter suspend Immediately.
> [  115.478349] arizona spi1.0: Suspend, disabling IRQ
> [  115.489783] arizona spi1.0: 400 <= 0
> [  115.489804] s3c64xx_spi_runtime_resume
> [  115.506127] arizona spi1.0: 51a <= 0
> [  115.506298] arizona spi1.0: 101 <= 8604
> [  115.506493] arizona spi1.0: 171 <= 3
> [  115.506515] arizona spi1.0: 171 <= 2
> [  115.506777] arizona spi1.0: 171 <= 0
> [  115.506793] arizona spi1.0: SYSCLK cleared
> [  115.507842] arizona spi1.0: SYSCLK cleared
> [  115.508373] s3c64xx_spi_suspend                                                                                                     
> 
> [  115.523095] arizona spi1.0: Late suspend, reenabling IRQ                                                                            
> [  115.523121] >>> noirq failed because of spi1                                                                                        
> [  115.523171] arizona spi1.0: Early resume, disabling IRQ
> [  115.556507] PM: noirq suspend of devices failed 
>      -> Repeats:
> 
> Do you have any idea to check which IRQ was occur? 

Hmm... yes that is odd whatever the IRQ was it appears to have
disappeared by the time we try to handle it.

Two things I would check next, is it perhaps electrical, is the
IRQ line getting pulled low for some reason other than an IRQ
being generated. For example are all the supplies being removed
from the CODEC and any pull-ups on that IRQ line? Perhaps then
when the system resumes the supplies are re-instated and the
false IRQ disappears. However this is probably unlikely as I
would expect to see an IRQ for boot done in this case.

Secondly, could you try taking the extcon driver out of the build
(CONFIG_EXTCON_ARIZONA), that should keep all the jack detect
disabled, which is probably the second most likely source of a
random IRQ from the chip.

I am attempting to reproduce your problem here, but alas
suspend/resume support on the Arndale board (our main dev system
at the moment) is pretty bad. If you know anyone your end who
might have any ideas why the SPI is totally unresponsive after
resume I would be happy to hear from them :-)

Thanks,
Charles
