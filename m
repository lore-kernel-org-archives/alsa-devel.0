From: Robert Jarzmik <rjarzmik@free.fr>
Subject: Re: [PATCH] Change of cold reset and ac97 register
	cache
Date: 18 Jan 2008 20:50:42 +0100
Message-ID: <87y7amewvh.fsf@polgara.paysbobval>
References: <87k5m91k93.fsf@polgara.paysbobval>
	<20080117132827.GA1248@rakim.wolfsonmicro.main>
	<87d4s0kurn.fsf@polgara.paysbobval>
	<20080118115122.GA22933@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id C1CA824656
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 20:50:43 +0100 (CET)
In-Reply-To: <20080118115122.GA22933@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> Just to clarify, it is the initial reset on chip probe that is causing
> problems for you rather than a call later on?  If the driver state and
> chip state are out of sync after that then that suggests that there is
> an error in the register defaults or some other similar issue.
It's the initial on chip probe in my case.

> > After that, I need to setup a specific GPIO to trigger loud speaker
> > amplificator. The trouble is that I do not want to trigger another GPIO which
> > powers another amplificator.
> > My code basically reads de GPIO register, put the right bit, and stores back.
> > But because of cache/chip difference, I trigger the other GPIO.
> 
> How exactly are you doing these accesses and which registers is it that
> trigger the problem - is it setting the GPIO state or configuring the
> GPIO pin modes?

I'm setting up a wm9713 GPIO (GPIO8) as input, and then set the pull-up
register to power my speaker amplification.

As we said, I'll implement a machine dependent solution, assuming there'll be in
the future a mecanism in ASoC v2 allowing hook inscription for the reset phase.
I'll synchronize the cache in this specific function, and will wait ASoC to
catch up or propose a patch.

--
Robert

PS: Sorry for the list, in my last reply I forgot alsa-devel.
