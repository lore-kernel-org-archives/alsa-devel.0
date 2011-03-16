From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add National Semiconductor LM49352
	Codec Support
Date: Wed, 16 Mar 2011 10:08:13 +0000
Message-ID: <20110316100353.GC2688@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89432CDF2B49@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2A0191037F8
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 11:07:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <290463D19D2E064191F1F96ECA480A89432CDF2B49@EXMAIL02.scwf.nsc.com>
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

On Wed, Mar 16, 2011 at 12:38:57AM -0700, Reddy, MR Swami wrote:

> Tested this patch on SMDK6410 platform with Kernel- 2.6.24 and ALSA version is - 1.0.15.

As previously mentioned you need to submit code against current Linux
versions.  Linux 2.6.24 is over three years old and development of the
kernel has moved on substantially in that time.

> Please review and let me know the comments/suggestion on this patch.
> And also let me know the forward-porting (to the latest ALSA version APIs) steps/process. Thanks in advance.

As previously mentioned this is pretty much up to you - you can apply
a range of techniques, either from starting from scratch or reviewing
the kernel changelogs for the core and other drivers and making gradual
changes to forward port.  Which approach works best for you is largely a
matter of personal preference.  If you have questions on specific things
then please feel free to ask.

I've had a brief glance at the driver and there are a number of obvious
coding style issues, please before resubmitting review the coding style
you are using and ensure that your driver is following a similar coding
style to the existing kernel code.  For example comments like this:

> +/***************************************************************************
> + * Name:
> + *    lm49352_read_reg_cache- Reads specific register from reg cache.
> + *
> + * Synopsis:
> + *     static inline unsigned int
> + *     lm49352_read_reg_cache(struct snd_soc_codec *codec,unsigned int reg)

are not at all idiomatic for the kernel.
