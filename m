From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mfd: arizona: Call the runtime PM function
 if the state is runtime resumed
Date: Thu, 24 Sep 2015 08:41:07 +0100
Message-ID: <20150924074107.GC5432@ck-lbox>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D30E726149D
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 10:04:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150924103809.7be235d1@songinha-Samsung-DeskTop-System>
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

On Thu, Sep 24, 2015 at 10:38:09AM +0900, Inha Song wrote:
> Hi, Charles,
> 
> On Wed, 23 Sep 2015 15:43:12 +0100
> Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:
> 
> > On Wed, Sep 23, 2015 at 11:04:04AM +0900, Inha Song wrote:
> > >  Hi, Charles,
> > > 
> > > I saw the log with LOG_DEVICE in regmap. But, I'm not sure the reason that suspend noirq failed is IRQ occuring.
> > > 
> > > Here is my log:
> > > --
> > > root@localhost:~# aplay test.wav 
> > > [   41.049072] s3c64xx_spi_runtime_suspend
> > > [   41.056043] arizona spi1.0: ASRC underclocked
> > > ....
> > > [   72.308238] arizona spi1.0: Suspend, disabling IRQ
> > > [   72.320286] arizona spi1.0: 400 <= 0
> > > [   72.320310] s3c64xx_spi_runtime_resume
> > > [   72.336047] arizona spi1.0: 51a <= 0
> > > [   72.336217] arizona spi1.0: 101 <= 8604
> > > [   72.336401] arizona spi1.0: 171 <= 3
> > > [   72.336425] arizona spi1.0: 171 <= 2
> > > [   72.336731] arizona spi1.0: 171 <= 0
> > > [   72.336751] arizona spi1.0: SYSCLK cleared
> > > [   72.338584] arizona spi1.0: SYSCLK cleared
> > 
> > This bit looks likely related to your problem, it looks like the
> > FLL is being turned off. My guess here would be that you haven't
> > called snd_soc_dapm_ignore_suspend from your machine driver, you
> > need to call this for all end points that may want to stay
> > powered up during system suspend and also set the ignore_suspend
> > flag on any DAI links you want to remain active during system
> > suspend.
> 
> But, We should call the trigger callback with SNDRV_PCM_TRIGGER_SUSPEND and *_RESUME command
> for support senarios what suspend during the playback and resume.
> So, I can't set the "ignore_suspend" in playback DAI.
> 
> For this reason, I would have called the runtime_suspend manually in arizona-core when suspend.
> 
> Best Reagrds,
> Inha Song.
> 

Ah ok so you want the audio to stop during suspend?

Ok in that case can we get a bit more of log, your log finished
up here:

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

Which finished too early as we can't see which IRQ it was that
triggered the wakeup.

Thanks,
Charles
