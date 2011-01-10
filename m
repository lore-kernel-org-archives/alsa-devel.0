From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 10:33:05 -0600
Message-ID: <4D2B34C1.7050209@freescale.com>
References: <1294675292-6289-1-git-send-email-timur@freescale.com>
	<1294676990.11031.10.camel@dplaptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C96D2439E
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 17:33:21 +0100 (CET)
In-Reply-To: <1294676990.11031.10.camel@dplaptop.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Dimitris Papastamos wrote:
> It'd be better to use snd_soc_update_bits() for all these.

Ok, but I'm not enthusiastic about the fact that snd_soc_update_bits() ignores
any errors from snd_soc_write().  Can that be fixed?

-- 
Timur Tabi
Linux kernel developer at Freescale
