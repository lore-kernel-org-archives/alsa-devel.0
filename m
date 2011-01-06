From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: soc-cache: Use
	reg_def_copy	instead of reg_cache_default
Date: Thu, 6 Jan 2011 00:34:56 +0000
Message-ID: <20110106003455.GA12153@opensource.wolfsonmicro.com>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
	<AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
	<20110105230339.GB5476@opensource.wolfsonmicro.com>
	<4D24F9E4.1080704@freescale.com>
	<20110105232947.GA8514@sirena.org.uk>
	<20110105235115.GB5714@opensource.wolfsonmicro.com>
	<4D250995.4020409@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6078424493
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 01:34:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D250995.4020409@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2011 at 12:15:17AM +0000, Tabi Timur-B04825 wrote:

> I just wanted to get the idea of what you and others intended with the
> current register cache code, just as a matter of context.  I like to

So ask that question; "I looked at this and I'm not really sure if it's
supposed to work or not - thing X suggests yes, thing Y suggests no but
looks like a bug so..." and so on.

In cases like this (although not I suspect this particular one) the
answer is often that there was't any particular consideration for
whatever unusual case you're looking at.

> understand these things *before* I start digging around.

The important thing is to show that you're looking, especially in areas
where you've done something unusual in your driver.  "Looking at this
briefly..." isn't a problem, just make it clear that that's what you've
done.

Part of the reason I'm emphasising this is that stuff like this seems to
cause you to get stuch relatively often.
