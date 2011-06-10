From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Do not attempt to change
 DAI sysclk if stream is active
Date: Fri, 10 Jun 2011 12:35:30 +0100
Message-ID: <20110610113529.GJ26436@opensource.wolfsonmicro.com>
References: <1307705335-2836-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B470B243C8
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 13:35:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307705335-2836-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 02:28:55PM +0300, Jarkko Nikula wrote:

>  
> +	if (mcbsp_data->active)
> +		return 0;
> +

Shouldn't we be returning -EBUSY or something here so the caller knows
we didn't do what it asked (after checking to make sure it's not just
trying to set the existing configuration)?  Otherwise it might get
surprised, assume the new configuration and just move the bug elsewhere.
