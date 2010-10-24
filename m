From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: soc-cache: Add support for
 standard register caching
Date: Sun, 24 Oct 2010 14:35:26 -0700
Message-ID: <20101024213525.GA14256@opensource.wolfsonmicro.com>
References: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1287757702-9573-3-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101022160351.GE16521@opensource.wolfsonmicro.com>
	<1287858254.9010.7.camel@dplaptop>
	<AANLkTi=eWCO71FTj38rS4dehjo+DoLvSGQa6fXgqaaJq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D586244B6
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Oct 2010 23:35:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=eWCO71FTj38rS4dehjo+DoLvSGQa6fXgqaaJq@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 24, 2010 at 08:18:59AM -0500, Timur Tabi wrote:
> On Sat, Oct 23, 2010 at 1:24 PM, Dimitris Papastamos

> > The only problem I see with the above code, is when
> > codec_drv->reg_word_size > sizeof (unsigned int) but that can't really
> > happen in practice.

Plus if it did happen the rest of the code would fall over fairly badly
since we've got that assumption embedded in the register read and write
APIs.

> I'm going to have to agree with Mark that this code is suspect.  I
> understand everything you said, but it makes me nervous.  Unless this
> code is in some kind of fast-path, I would prefer to see it rewritten
> to avoid any assumption about the sizes of the types involved.

I think the important thing here is that the code is clear - from a
maintainability so long as it's clear how and why the code works things
should be fine, otherwise we'll have people scratching their heads over
it every time someone looks at the code which is going to be painful.
This could be done with documentation as well as with code changes,
though code changes should definitely be considered.
