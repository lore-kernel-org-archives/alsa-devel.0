From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8985: Register notifier for the
 regulator being disabled
Date: Thu, 30 Sep 2010 10:51:32 +0100
Message-ID: <1285840292.4722.17.camel@dplaptop>
References: <1285756717-27149-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20100929174322.GA31934@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 36F51244F1
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 11:51:40 +0200 (CEST)
In-Reply-To: <20100929174322.GA31934@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-09-29 at 10:43 -0700, Mark Brown wrote:
> Note that the whole callback thing is more important for things with
> idle_bias_off (which might get the regulators powered down at runtime)
> than for other things which don't go down to _BIAS_OFF at runtime so
> would only trigger the callback on suspend anyway.

Ok I will revert this patch then.  The reason why I did not set
idle_bias_off is that I could not guarantee that the driver would still
function properly without testing it.

> Always split different things out into separate patches unless they
> overlap with each other a lot.

Yup indeed.

> It's better to restructure the code so that the compiler is able to
> follow the control flow and see that there's no uninitialised access -
> this sort of change will just shut up legitimate warnings as well.  Some
> of the other CODEC drivers (wm8400 is one) have had similar changes
> which seem to do the trick.

My version of GCC (4.5.1) does not seem to have a problem figuring out
the flow of execution.  It is just that some of the people who use this
code and have an older version of GCC get these warnings.  I agree this
is not the way to fix it as it silences legitimate warnings.  However I
can't really test any changes I make in an attempt to fixing this due
to not having an older version of gcc.

Thanks,
Dimitrios
