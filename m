From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: Add missing dev_set_drvdata in
	mpc8610_hpcd_probe
Date: Mon, 29 Nov 2010 08:53:48 -0600
Message-ID: <4CF3BE7C.2000006@freescale.com>
References: <1291013698.19113.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A8191038BA
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 15:53:59 +0100 (CET)
Received: from mail53-va3 (localhost.localdomain [127.0.0.1])	by
	mail53-va3-R.bigfish.com (Postfix) with ESMTP id 56A041A6851D	for
	<alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 14:53:56 +0000 (UTC)
Received: from VA3EHSMHS006.bigfish.com (unknown [10.7.14.243])	by
	mail53-va3.bigfish.com (Postfix) with ESMTP id 0FDD0620052	for
	<alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 14:53:56 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oATErnFR012161	for
	<alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 07:53:51 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oATFAX6J003852	for <alsa-devel@alsa-project.org>;
	Mon, 29 Nov 2010 09:10:34 -0600 (CST)
In-Reply-To: <1291013698.19113.1.camel@mola>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Axel Lin wrote:
> Otherwise, calling dev_get_drvdata in mpc8610_hpcd_remove returns NULL.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Both patches:

Acked-by: Timur Tabi <timur@freescale.com>

Thanks for catching this.

-- 
Timur Tabi
Linux kernel developer at Freescale
