From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 4/8] ASoC: Convert fsl directory to
	module_platform_driver
Date: Mon, 28 Nov 2011 11:15:04 -0600
Message-ID: <4ED3C198.2010602@freescale.com>
References: <1322186745.8878.1.camel@phoenix> <1322187055.8878.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 6381E103938
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 18:15:25 +0100 (CET)
In-Reply-To: <1322187055.8878.6.camel@phoenix>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Axel Lin wrote:
> Factor out some boilerplate code.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---

Acked-by: Timur Tabi <timur@freescale.com>

I tested the fsl_xxx.c changes, and everything still works (although I will miss my driver announcements).  I compile-tested the mpc5200 changes, but I don't have an mpc5200 to test the code on.

-- 
Timur Tabi
Linux kernel developer at Freescale
