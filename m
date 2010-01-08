From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Davinci: DM365: Enable DaVinci
	Voice	Codec support for DM365 EVM
Date: Fri, 8 Jan 2010 11:31:22 +0000
Message-ID: <20100108113121.GB10128@sirena.org.uk>
References: <1262902641-14821-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 769F82447C
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 12:31:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1262902641-14821-1-git-send-email-miguel.aguilar@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 07, 2010 at 04:17:21PM -0600, miguel.aguilar@ridgerun.com wrote:

> +		if (device == 0)
> +			davinci_cfg_reg(DM365_EVT2_ASP_TX);
> +		else
> +			davinci_cfg_reg(DM365_EVT2_VC_TX);

I'd be a bit more comfortable with this if it were using something more
symbolic like a #define or enum rather than checking a bare number to
work out which device it's talking to.

Otherwise this looks good, but I've no familiarity with DaVinci
specifics so...
