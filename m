From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4270: enable regulators at
	probe time
Date: Fri, 29 Jan 2010 07:55:03 -0600
Message-ID: <4B62E8B7.5080403@freescale.com>
References: <1264676371-29977-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D0641038ED
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 14:55:22 +0100 (CET)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0TDt4sq008626
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 06:55:15 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o0TE0kR8010110
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 08:00:46 -0600 (CST)
In-Reply-To: <1264676371-29977-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:

> +error_free_regulators:
> +		regulator_bulk_free(ARRAY_SIZE(cs4270->supplies),
> +				    cs4270->supplies);

I think this is indented too much.

-- 
Timur Tabi
Linux kernel developer at Freescale
