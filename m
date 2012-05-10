From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 5/6] ASoC: mxs: add device tree support for
 mxs-sgtl5000
Date: Thu, 10 May 2012 20:20:04 +0800
Message-ID: <20120510122001.GM17875@S2101-09.ap.freescale.net>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
	<1336639333-11561-6-git-send-email-shawn.guo@linaro.org>
	<20120510111646.GL6622@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 57F8224430
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 14:20:07 +0200 (CEST)
Received: by dajt11 with SMTP id t11so2191212daj.38
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 05:20:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120510111646.GL6622@shlinux2.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2012 at 07:16:46PM +0800, Dong Aisheng wrote:
> > +static int __devinit mxs_sgtl5000_probe_dt(struct platform_device *pdev)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct device_node *saif_np[2], *codec_np;
> > +	struct platform_device *saif_pdev[2];
> > +	int i, ret = 0;
> > +
> > +	if (!np)
> > +		return 1; /* no device tree */
> > +
> > +	saif_np[0] = of_parse_phandle(np, "saif-controllers", 0);
> > +	saif_np[1] = of_parse_phandle(np, "saif-controllers", 1);
> > +	codec_np = of_parse_phandle(np, "audio-codec", 0);
> > +	if (!saif_np[0] || !saif_np[1] || !codec_np) {
> > +		dev_err(&pdev->dev, "phandle missing or invalid\n");
> > +		return -EINVAL;
> > +	}
> ...
> 
> > +
> > +	saif_pdev[0] = of_find_device_by_node(saif_np[0]);
> > +	saif_pdev[1] = of_find_device_by_node(saif_np[1]);
> > +	if (!saif_pdev[0] || !saif_pdev[1]) {
> > +		dev_err(&pdev->dev, "failed to find saif platform device\n");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> Do we really need this checking?
> 
Hmm, why not?  We need to ensure that the phandles are correctly
represented in device tree.

> > +	card->dev = &pdev->dev;
> Repeat assignment?
> 
Good catch, again.  It's a rebasing error.  Thanks.

Regards,
Shawn
