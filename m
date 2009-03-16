From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/9] ARM: DaVinci: ASoC: Adds header
	file	for McASP Audio Layer for TI DM646X processor
Date: Mon, 16 Mar 2009 15:15:11 +0000
Message-ID: <20090316151510.GE16539@sirena.org.uk>
References: <1237205002-30106-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E8FBB24342
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 16:15:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1237205002-30106-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Naresh Medisetty <naresh@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 16, 2009 at 08:03:22AM -0400, Naresh Medisetty wrote:

> +/*
> + * DAVINCI_MCASP_PWREMUMGT_REG - Power Down and Emulation Management
> + *     Register Bits
> + */
> +#define FREE         BIT(0)
> +#define SOFT         BIT(1)

These (and most of your other register bit names) really need to be
namespaced.  I'd also suggest considering moving the register
definitions out of here and into the C file - it looks like nothing else
ever ought to be peering at them?
