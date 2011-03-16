From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add National Semiconductor LM49352
	Codec Support
Date: Wed, 16 Mar 2011 14:35:25 +0000
Message-ID: <20110316143524.GA15605@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89432CDF2B49@EXMAIL02.scwf.nsc.com>
	<20110316100353.GC2688@opensource.wolfsonmicro.com>
	<290463D19D2E064191F1F96ECA480A89432CDF2C4D@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 085562441D
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 15:35:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <290463D19D2E064191F1F96ECA480A89432CDF2C4D@EXMAIL02.scwf.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Reddy, MR Swami" <MR.Swami.Reddy@nsc.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 16, 2011 at 06:38:15AM -0700, Reddy, MR Swami wrote:
> >From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 

Please fix your MUA to word wrap at less than 80 columns within
paragraphs.

> >As previously mentioned this is pretty much up to you - you can apply
> >a range of techniques, either from starting from >scratch or
> >reviewing the kernel changelogs for the core and other drivers and
> >making gradual changes to forward port.  >Which approach works best
> >for you is largely a matter of personal preference.  If you have
> >questions on specific things >then please feel free to ask.

> OK. I will look into the kernel changelogs and update the LM49352
> driver to use the latest ALSA APIs and sync with latest kernel
> sources. If there are any other comments (ie apart from the coding
> standards), please let me know.

Given the great age of the kernel you were developing against I didn't
really look at the code, there has been substantial change in the kernel
since then.

> >I've had a brief glance at the driver and there are a number of
> >obvious coding style issues, please before resubmitting >review the
> >coding style you are using and ensure that your driver is following a
> >similar coding style to the existing >kernel code.  For example
> >comments like this:

> I ran the scripts/chcekpatch.pl script for lm49352.c and lm49352.h
> file, there no warnings/errors.  OK, I could remove the comments for
> all functions in the next patch submission.

It's not about passing checkpatch, it's about making sure your code
looks like other similar code.  If you look at your code next to
another, similar driver and it's easy to tell which is which visually
there's an issue.  checkpatch is a useful tool but it's only part of
making sure your code is idiomatic for the kernel.
