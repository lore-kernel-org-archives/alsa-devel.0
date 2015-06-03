From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ASoC: add config to enable/disable asoc
	compress
Date: Wed, 3 Jun 2015 05:30:34 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90553CC9E@SHSMSX101.ccr.corp.intel.com>
References: <1432992511-864-1-git-send-email-yang.jie@intel.com>
 <20150602105814.GM14071@sirena.org.uk> <s5hlhg2e2uk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BB8A26588A
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 07:30:39 +0200 (CEST)
In-Reply-To: <s5hlhg2e2uk.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zhang,
 Vivian" <vivian.zhang@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, June 02, 2015 8:01 PM
> To: Mark Brown
> Cc: Jie, Yang; alsa-devel@alsa-project.org; Girdwood, Liam R; Zhang, Vivian
> Subject: Re: [PATCH] ASoC: add config to enable/disable asoc compress
> 
> At Tue, 2 Jun 2015 11:58:14 +0100,
> Mark Brown wrote:
> >
> > On Sat, May 30, 2015 at 09:28:31PM +0800, Jie Yang wrote:
> >
> > > +ifneq ($(CONFIG_SND_SOC_COMPRESS),) snd-soc-core-objs +=
> > > +soc-compress.o endif
> >
> > If you want to make this optional why not make it a module so that the
> > Makefile looks more idiomatic?
> 
> Only about Makefile, it can be simplified like
> 
> snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o
 
Got it, thanks.

> 
> But I agree with Mark.  It would make more sense to split a module, as soc-
> compress.c isn't so small.  For a small object, it's often better to keep in, as a
> module consumes more memory (it needs a page size).
> For a large size object, it's worth to consider to split.
 
Make it a module sounds good idea, I can change it in next version.

~Keyon

> 
> 
> Takashi
