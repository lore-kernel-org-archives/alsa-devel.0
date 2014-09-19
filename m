From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Remove unneeded 'i2s-slave'
	property
Date: Thu, 18 Sep 2014 19:29:32 -0500
Message-ID: <541B78EC.5050702@tabi.org>
References: <1411063877-1552-1-git-send-email-fabio.estevam@freescale.com>
 <20140918183251.GE6432@Asurada> <541B2678.8000401@tabi.org>
 <1411065995187.3341@freescale.com> <20140918194342.GA3173@Alpha>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 537C926557A
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 02:29:36 +0200 (CEST)
In-Reply-To: <20140918194342.GA3173@Alpha>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
> Thank you for the comments. Then we may use compatible check for
> P1022 and MPC8610 to limit their DAI formats.
>
> For the property, do you agree to modify it like this:
>
> - fsl,mode:         The operating mode for the AC97 interface only.
>                      "ac97-slave" - AC97 mode, SSI is clock slave
>                      "ac97-master" - AC97 mode, SSI is clock master
>                      (There's no need for other DAI format like I2S
> 		    mode to engage this property.)
>
> And how about this patch? I'm personally okay with this change.
> We may also send an extra patch to refine the document after the
> agreement's done.

You can't just redefine a property, because that breaks backwards 
compatibility with older device trees or older kernels.
