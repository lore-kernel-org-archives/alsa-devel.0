From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mfd: arizona: Call the runtime PM function
 if the state is runtime resumed
Date: Tue, 22 Sep 2015 08:46:18 +0100
Message-ID: <20150922074618.GA11647@ck-lbox>
References: <1442478527-29304-1-git-send-email-ideal.song@samsung.com>
 <20150917082542.GB7694@ck-lbox>
 <20150917180530.346232ce@songinha-Samsung-DeskTop-System>
 <20150917091632.GC7694@ck-lbox>
 <20150918154903.549cf6d0@songinha-Samsung-DeskTop-System>
 <20150918082446.GD7694@ck-lbox>
 <20150921111642.112dc0c2@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F539261A8C
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 10:10:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150921111642.112dc0c2@songinha-Samsung-DeskTop-System>
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

On Mon, Sep 21, 2015 at 11:16:42AM +0900, Inha Song wrote:
> Hi, Charles,
> 
> I've already tried to change.
> If I change to that, we can't enter the suspen during the playback.
> 
> -
> [   72.538263] arizona spi1.0: Suspend, disabling IRQ
> ...
> [   72.585823] arizona spi1.0: Late suspend, reengabling IRQ
> [   72.585904] arizona spi1.0: Early resume, disabling IRQ
> ...
> [   72.646770] PM: noirq suspend of devices failed
> 		<- because of "spi1.0" pm_wakeup_pending() in suspend_noirq()

Ok this looks more reasonable, suspend should fail because we do
have an IRQ waiting to be handled, so we shouldn't suspend. But
you are saying this happens every time the CODEC goes to suspend,
thus blocking the suspend from suspending?

First step then would be to identify what IRQ is occurring, could
you set LOG_DEVICE at the top of drivers/base/regmap/regmap.c to
"spi1.0" and provide a log, so we can see what IRQ is being
asserted from the CODEC.

Thanks,
Charles
