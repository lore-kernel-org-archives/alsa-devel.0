From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Remove unneeded 'i2s-slave'
	property
Date: Thu, 18 Sep 2014 21:17:49 -0700
Message-ID: <20140919041749.GA5840@Asurada>
References: <1411063877-1552-1-git-send-email-fabio.estevam@freescale.com>
 <20140918183251.GE6432@Asurada> <541B2678.8000401@tabi.org>
 <1411065995187.3341@freescale.com> <20140918194342.GA3173@Alpha>
 <541B78EC.5050702@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id A6964265603
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 06:17:58 +0200 (CEST)
Received: by mail-pa0-f48.google.com with SMTP id fb1so2089996pad.21
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 21:17:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <541B78EC.5050702@tabi.org>
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

On Thu, Sep 18, 2014 at 07:29:32PM -0500, Timur Tabi wrote:
> >For the property, do you agree to modify it like this:
> >
> >- fsl,mode:         The operating mode for the AC97 interface only.
> >                     "ac97-slave" - AC97 mode, SSI is clock slave
> >                     "ac97-master" - AC97 mode, SSI is clock master
> >                     (There's no need for other DAI format like I2S
> >		    mode to engage this property.)

> You can't just redefine a property, because that breaks backwards
> compatibility with older device trees or older kernels.

Sorry, I'm not sure what's the problem here. It just drops i2s stuff
and leave AC97 part as we discussed. Why would old DTs be broken?
Is that possible for you to give me an example to understand the
point?

Thank you
Nicolin
