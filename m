From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Remove unneeded 'i2s-slave'
	property
Date: Thu, 18 Sep 2014 12:43:43 -0700
Message-ID: <20140918194342.GA3173@Alpha>
References: <1411063877-1552-1-git-send-email-fabio.estevam@freescale.com>
 <20140918183251.GE6432@Asurada> <541B2678.8000401@tabi.org>
 <1411065995187.3341@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 8292926510A
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 21:43:50 +0200 (CEST)
Received: by mail-pd0-f177.google.com with SMTP id y10so983968pdj.22
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 12:43:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411065995187.3341@freescale.com>
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

On Thu, Sep 18, 2014 at 06:46:42PM +0000, Fabio.Estevam@freescale.com wrote:
> On 09/18/2014 01:32 PM, Nicolin Chen wrote:
> > On Thu, Sep 18, 2014 at 03:11:17PM -0300, Fabio Estevam wrote:
> >> There is no need to use 'i2s-slave' property, since master/slave configuration
> >> are passed via machine layer.
> >>
> >> This change does not break existing users because they do check for slave
> >> mode inside sound/soc/fsl/mpc8610_hpcd.c/p1022_ds.c and p1022_rdk.c
> >
> > Besides this change, I'm wondering if we can take a further step to drop
> > this entire property from Device Tree binding document as newer platforms
> > may no long need this property in their DT bindings.
> 
> I think the property is necessary if anyone takes a P1022 or MPC8610 and
> uses it in a platform that doesn't support i2s-slave.  But currently,
> the code doesn't support anything else.  So technically, we could remove
> it, and if anyone does want to support another configuration, he will
> have to add that support the "new" way.

Thank you for the comments. Then we may use compatible check for
P1022 and MPC8610 to limit their DAI formats.

For the property, do you agree to modify it like this:

- fsl,mode:         The operating mode for the AC97 interface only.
                    "ac97-slave" - AC97 mode, SSI is clock slave
                    "ac97-master" - AC97 mode, SSI is clock master
                    (There's no need for other DAI format like I2S
		    mode to engage this property.)

And how about this patch? I'm personally okay with this change.
We may also send an extra patch to refine the document after the
agreement's done.

Thanks
Nicolin
