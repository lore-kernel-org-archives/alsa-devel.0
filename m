From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/15] sound/soc/mxs/mxs-saif.c: add missing
 iounmap
Date: Thu, 26 Jan 2012 12:28:51 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1201261228350.1851@localhost6.localdomain6>
References: <1326362117-29371-1-git-send-email-Julia.Lawall@lip6.fr>
	<7FE21149F4667147B645348EC605788508FBDB@039-SN2MPN1-013.039d.mgd.msft.net>
	<alpine.DEB.2.02.1201241828480.1779@localhost6.localdomain6>
	<20120124202203.GD1135@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1201242144580.1998@hadrien>
	<20120126110506.GB2611@pengutronix.de>
	<alpine.DEB.2.02.1201261220460.1851@localhost6.localdomain6>
	<20120126112508.GC2611@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4-relais-sop.national.inria.fr
	(mail4-relais-sop.national.inria.fr [192.134.164.105])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E6CB103C45
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 12:28:51 +0100 (CET)
In-Reply-To: <20120126112508.GC2611@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Dong Aisheng-B29396 <B29396@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 26 Jan 2012, Wolfram Sang wrote:

> On Thu, Jan 26, 2012 at 12:21:35PM +0100, Julia Lawall wrote:
>> On Thu, 26 Jan 2012, Wolfram Sang wrote:
>>
>>>> @@ -666,18 +666,19 @@ static int mxs_saif_probe(struct platform_device *pdev)
>>>>  		goto failed_get_resource;
>>>>  	}
>>>>
>>>> -	if (!request_mem_region(iores->start, resource_size(iores),
>>>> -				"mxs-saif")) {
>>>> +	if (!devm_request_mem_region(&pdev->dev, iores->start,
>>>> +				     resource_size(iores), "mxs-saif")) {
>>>>  		dev_err(&pdev->dev, "request_mem_region failed\n");
>>>>  		ret = -EBUSY;
>>>>  		goto failed_get_resource;
>>>>  	}
>>>>
>>>> -	saif->base = ioremap(iores->start, resource_size(iores));
>>>> +	saif->base = devm_ioremap(&pdev->dev, iores->start,
>>>> +				  resource_size(iores));
>>>
>>> devm_request_and_ioremap() to save even more code?
>>
>> I didn't do that because apparently it is not yet in a release?  I
>> have another for introducing those...
>
> It got included in the last merge window:
>
> commit 72f8c0bfa0de64c68ee59f40eb9b2683bffffbb0
> Author: Wolfram Sang <w.sang@pengutronix.de>
> Date:   Tue Oct 25 15:16:47 2011 +0200
>
>    lib: devres: add convenience function to remap a resource
> ...

OK, thanks.  I'll take that into account.

julia
