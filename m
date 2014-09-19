From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Remove unneeded 'i2s-slave'
	property
Date: Fri, 19 Sep 2014 10:24:39 -0700
Message-ID: <20140919172438.GA1736@Asurada>
References: <1411063877-1552-1-git-send-email-fabio.estevam@freescale.com>
 <20140918183251.GE6432@Asurada> <541B2678.8000401@tabi.org>
 <1411065995187.3341@freescale.com> <20140918194342.GA3173@Alpha>
 <541B78EC.5050702@tabi.org> <20140919041749.GA5840@Asurada>
 <541C26E2.4060605@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B436265158
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 19:24:46 +0200 (CEST)
Received: by mail-pa0-f44.google.com with SMTP id rd3so509670pab.31
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 10:24:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <541C26E2.4060605@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 19, 2014 at 07:51:46AM -0500, Timur Tabi wrote:
> Nicolin Chen wrote:
> >>You can't just redefine a property, because that breaks backwards
> >>>compatibility with older device trees or older kernels.
> 
> >Sorry, I'm not sure what's the problem here. It just drops i2s stuff
> >and leave AC97 part as we discussed. Why would old DTs be broken?
> >Is that possible for you to give me an example to understand the
> >point?
> 
> If you have an older kernel with a newer device tree (that doesn't have
> "i2s-mode"), the driver will fail to load because "i2s-mode" is missing.

I thought only the backward compatibility for DT is demanded.....
But I still don't get why people would use new DT without updating
kernel. It's pretty fair to use old DT with newer kernel because
they want bug-fix patches.

Thank you
Nicolin
