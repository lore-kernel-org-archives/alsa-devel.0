From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: Fix error handling if
 platform_device_add fails
Date: Tue, 20 Sep 2011 11:00:03 -0500
Message-ID: <4E78B883.3000808@freescale.com>
References: <1316502540.4269.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 402B910388D
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 18:00:11 +0200 (CEST)
In-Reply-To: <1316502540.4269.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Axel Lin wrote:
> Call platform_device_put() instead of platform_device_unregister() if
> platform_device_add() fails.

What's wrong with calling platform_device_unregister()?

-- 
Timur Tabi
Linux kernel developer at Freescale
