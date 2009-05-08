From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL
	and	SACR1_DREC separately
Date: Fri, 8 May 2009 11:42:29 +0100
Message-ID: <20090508104229.GD5654@sirena.org.uk>
References: <4A03748B.1010302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D24E124922
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 12:42:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A03748B.1010302@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

On Fri, May 08, 2009 at 01:53:47AM +0200, Karl Beldan wrote:
> 
> - hw_params enables both RPL and REC functions each time,
> enable the appropriate function in pxa2xx_i2s_trigger.
> - pxa2xx_i2s_shutdown disables i2s anytime one of RPL or REC
> function is off, turn it off only when both functions are off.

Looks OK, but...

> - do not put the clk_i2s for no reason in pxa2xx_i2s_shutdown.

...this really ought to be a separate patch.  I'll wait until Monday
when I'm back in the office before applying so I can test.
