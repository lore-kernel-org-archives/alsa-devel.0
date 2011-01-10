From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 16:36:05 +0000
Message-ID: <1294677365.11031.13.camel@dplaptop.localdomain>
References: <1294675292-6289-1-git-send-email-timur@freescale.com>
	<1294676990.11031.10.camel@dplaptop.localdomain>
	<4D2B34C1.7050209@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B09022439E
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 17:36:24 +0100 (CET)
In-Reply-To: <4D2B34C1.7050209@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-10 at 10:33 -0600, Timur Tabi wrote:
> Dimitris Papastamos wrote:
> > It'd be better to use snd_soc_update_bits() for all these.
> 
> Ok, but I'm not enthusiastic about the fact that snd_soc_update_bits() ignores
> any errors from snd_soc_write().  Can that be fixed?

There's not much that can be done for error recovery at that point.
Usually a failing snd_soc_read()/snd_soc_write() will complain wildly
with errors from the underlying bus.  The only place that
snd_soc_read()/snd_soc_write() are checked for errors is usually in
_probe() functions.

Thanks,
Dimitris
