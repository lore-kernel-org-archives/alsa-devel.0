From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 16:24:49 +0000
Message-ID: <1294676689.11031.8.camel@dplaptop.localdomain>
References: <1294675292-6289-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F62A2450A
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 17:25:03 +0100 (CET)
In-Reply-To: <1294675292-6289-1-git-send-email-timur@freescale.com>
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

On Mon, 2011-01-10 at 10:01 -0600, Timur Tabi wrote:
> Update the CS4270 driver to use ASoC's internal codec register cache feature.
> This change allows ASoC to perform the low-level I2C operations necessary to
> read the register cache.  Support is also added for initializing the register
> cache with an array of known power-on default values.
> 
> The CS4270 driver was handling the register cache itself, but somwhere along
> the conversion to multi-compaonent, this feature broke.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Have you tried using the patch I've submitted today?  Using a defaults
register cache is indeed idiomatic, however, ASoC should be able to
handle NULL defaults register maps with custom read()/write() callbacks.

Thanks,
Dimitris
