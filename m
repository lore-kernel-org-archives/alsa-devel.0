From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/15] sound/soc/mxs/mxs-saif.c: add missing
	iounmap
Date: Tue, 24 Jan 2012 21:36:17 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1201242135430.1998@hadrien>
References: <1326362117-29371-1-git-send-email-Julia.Lawall@lip6.fr>
	<7FE21149F4667147B645348EC605788508FBDB@039-SN2MPN1-013.039d.mgd.msft.net>
	<alpine.DEB.2.02.1201241828480.1779@localhost6.localdomain6>
	<20120124202203.GD1135@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4-relais-sop.national.inria.fr
	(mail4-relais-sop.national.inria.fr [192.134.164.105])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FAB624611
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 21:36:18 +0100 (CET)
In-Reply-To: <20120124202203.GD1135@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Dong Aisheng-B29396 <B29396@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Jan 2012, Mark Brown wrote:

> On Tue, Jan 24, 2012 at 06:29:13PM +0100, Julia Lawall wrote:
>
>>  	if (IS_ERR(saif->clk)) {
>> -		ret = PTR_ERR(saif->clk);
>>  		dev_err(&pdev->dev, "Cannot get the clock: %d\n",
>>  			ret);
>> -		goto failed_clk;
>> +		return PTR_ERR(saif->clk);
>
> Looks like the transformation is overly enthusiastic here - the
> assignment to ret is removed but ret is used in the log message.

Uh, no, I did that stupid thing by hand.  I'll fix it.  Thanks.

julia
