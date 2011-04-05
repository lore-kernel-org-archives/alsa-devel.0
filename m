From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 1/1] sgtl5000: Fix suspend/resume
Date: Tue, 5 Apr 2011 09:18:59 +0900
Message-ID: <20110405001858.GD5376@opensource.wolfsonmicro.com>
References: <20110404151315.251129690@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 284661037EC
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 02:18:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110404151315.251129690@rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 04, 2011 at 05:13:00PM +0200, Arnaud Patard wrote:

>  /* default value of sgtl5000 registers except DAP */
> -static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET >> 1] =  {
> +static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET] =  {
>  	0xa011, /* 0x0000, CHIP_ID. 11 stand for revison 17 */
> +	0,

It's not immediately obvious that this is the best fix - the driver does
declare a step of 2 so I'd expect it to be able to lay out the cahce
defaults like this.  Also, it'd be easier to review the patch if you
could split out the cache stride fix from the rest of the changes,
there's quite a few things going on in this patch.
