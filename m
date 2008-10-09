From: "John Kacur" <jkacur@gmail.com>
Subject: Re: [PATCH 7/9] ASoC: Blackfin: I2S CPU DAI driver
Date: Thu, 9 Oct 2008 08:53:03 +0200
Message-ID: <520f0cf10810082353r2694535evc3edbcb2b3c76796@mail.gmail.com>
References: <1220516528-20301-1-git-send-email-cooloney@kernel.org>
	<1220516528-20301-8-git-send-email-cooloney@kernel.org>
	<20080904144343.GB32531@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 6921D1037ED
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 08:53:17 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so4033293rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 08 Oct 2008 23:53:03 -0700 (PDT)
In-Reply-To: <20080904144343.GB32531@rakim.wolfsonmicro.main>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 4, 2008 at 4:43 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Sep 04, 2008 at 04:22:06PM +0800, Bryan Wu wrote:
> > From: Cliff Cai <cliff.cai@analog.com>
> >
> > Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> > Signed-off-by: Bryan Wu <cooloney@kernel.org>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> Please fix the minor issues below as incremental patches for ease of
> review.
>
> > +     switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +     case SND_SOC_DAIFMT_I2S:
> > +             break;
> > +     case SND_SOC_DAIFMT_LEFT_J:
> > +             ret = -EINVAL;
> > +             break;
> > +     }
>
> The SND_SOC_DAFIMT_LEFT_J: ought to be default: instead - there's more
> DAI formats than just that.
>
> > +     if (!bf5xx_i2s.master) {
> > +     /*
> > +      * TX and RX are not independent,they are enabled at the same time,
> > +      * even if only one side is running.So,we need to configure both of
> > +      * them in advance.
> > +      *
> > +      * CPU DAI format:I2S, slave mode.
> > +      */
>

+       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+       case SND_SOC_DAIFMT_CBS_CFS:
+               ret = -EINVAL;
+               break;
+       case SND_SOC_DAIFMT_CBM_CFS:
+               ret = -EINVAL;
+               break;
+       case SND_SOC_DAIFMT_CBM_CFM:
+               break;
+       case SND_SOC_DAIFMT_CBS_CFM:
+               ret = -EINVAL;
+               break;
+       default:
+               break;
+       }

My eyes fell upon this switch statement, probably I have similar criticisms
as to what has already been said, but:
1. Surely the default case is also an -EINVAL
2. Why not let all the EINVALS fall through, it will shorten up the code,
and IMO make it more readable, something like this?
+       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+       case SND_SOC_DAIFMT_CBM_CFM: /* Passing Case */
+               break;
+       case SND_SOC_DAIFMT_CBS_CFS: /* Failing Cases */
+       case SND_SOC_DAIFMT_CBM_CFS:
+       case SND_SOC_DAIFMT_CBS_CFM:
+               ret = -EINVAL;
+               break;
+       default:
+               printk(KERN_INFO "Unknown SND_SOC_DAIFMT kind\n");
+               ret = -EINVAL;
+               break;
+       }
