From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ASoC: fsl: add an error check
Date: Wed, 10 Jun 2015 22:17:32 +0300
Message-ID: <20150610191732.GC11734@mwanda>
References: <20150610153723.GB10549@mwanda>
 <20150610165544.GA8552@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 19E9A265E00
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 21:17:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150610165544.GA8552@Asurada>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

> Could you please use an subject like:
> ASoC: imx-wm8962: Add a missing error check
> (Since it only applies to this file)
> 

I have been meaning to say something about this.

This is sort of a recurrent problem for me because I'm often the first
person to touch a driver after it's added.  I just copied your patch
prefix from 8de2ae2a7f1f ('ASoC: fsl: add imx-wm8962 machine driver').
Really you should also have used "ASoC: imx-wm8962:" as well.

This is the third new driver today where I have faced this situation.

regards,
dan carpenter
