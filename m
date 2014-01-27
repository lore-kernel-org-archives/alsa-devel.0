From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: arizona: Check clocking during
 hw_params rather than startup
Date: Mon, 27 Jan 2014 08:17:18 +0100
Message-ID: <52E607FE.8010807@metafoo.de>
References: <1390582753-1026-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <52E2A1F2.6070707@metafoo.de> <20140124173754.GD11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-179.synserver.de
 [212.40.185.179])
 by alsa0.perex.cz (Postfix) with ESMTP id F38E12610B5
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 08:17:17 +0100 (CET)
In-Reply-To: <20140124173754.GD11727@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 01/24/2014 06:37 PM, Mark Brown wrote:
> On Fri, Jan 24, 2014 at 06:25:06PM +0100, Lars-Peter Clausen wrote:
> 
>> The problem with this approach is that if the sysclk is fixed instead to
>> e.g. falling back to rate conversion you'll get an error instead when
>> calling hw_params. The typical idiom here is to only apply the rate
>> constraints in the CODEC driver if the sysclk is non zero. This driver
>> already seems to do this. The problem that you probably see is that if the
>> machine driver changes the sysclk value in hw_params the constraints that
> 
> Thanks, that's about what I was going to write.  The current theory is
> that setting the sysclk to zero is the equivalent of a dynamic SYSCLK
> flag - with the extensive use of charge pumps and so on in modern
> devices on the fly reclocking is normally difficult to do safely so the
> idea is that if the machine driver is in a position to reclock it should
> set the clock to zero.
> 

It's a bit ugly though to set the clock to 0 in the startup callback of the
machine driver and then set it to the actual sysclk in the hw_params callback.

>> are setup are still setup with the previous sysclk in mind. I think instead
>> of removing the constraints support altogether from the driver a better
>> solution is to introduce a dynamic_sysclk or similar attribute to the DAI
>> link and not constrain the supported rates if this attribute is set to true.
> 
> It would be useful to have this more in the core rather than open coded,
> as with the sample size stuff.
> 

Agreed. It probably fits in nicely with the sample size stuff. Set
constraints for the sysclk in the machine driver (i.e. the list of possible
values). And then have the CODEC driver figure out which sample rates it can
support based on the sysclk constraints and use these has the sample rate
constraints.

- Lars
