From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Remove unneeded 'i2s-slave'
	property
Date: Sat, 20 Sep 2014 11:07:38 -0700
Message-ID: <20140920180738.GA6976@Asurada>
References: <1411063877-1552-1-git-send-email-fabio.estevam@freescale.com>
 <20140918183251.GE6432@Asurada> <541B2678.8000401@tabi.org>
 <1411065995187.3341@freescale.com> <20140918194342.GA3173@Alpha>
 <541B78EC.5050702@tabi.org> <20140919041749.GA5840@Asurada>
 <541C26E2.4060605@tabi.org> <20140919172438.GA1736@Asurada>
 <541CC0FE.7050600@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 458262608EA
 for <alsa-devel@alsa-project.org>; Sat, 20 Sep 2014 20:07:47 +0200 (CEST)
Received: by mail-pa0-f52.google.com with SMTP id hz1so2058131pad.39
 for <alsa-devel@alsa-project.org>; Sat, 20 Sep 2014 11:07:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <541CC0FE.7050600@tabi.org>
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

On Fri, Sep 19, 2014 at 06:49:18PM -0500, Timur Tabi wrote:
> Nicolin Chen wrote:
> >I thought only the backward compatibility for DT is demanded.....
> 
> I have higher standards :-)
> 
> >But I still don't get why people would use new DT without updating
> >kernel. It's pretty fair to use old DT with newer kernel because
> >they want bug-fix patches.
> 
> The device tree is shipped with the kernel, so some people say that
> backwards compatibility is not needed anywhere.  I think it's important to
> provide backwards compatibility both ways.
> 
> I generally prefer some kind of transition period, where you can use new or
> old kernel with a new or old device tree.

I see..

> However, let me look at Fabio's patches some more.

Yes, please.
