From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/10] ASoC: twl6040: Combine the custom
 volsw get, and put functions
Date: Mon, 26 Sep 2011 22:21:42 +0100
Message-ID: <20110926212141.GB2872@opensource.wolfsonmicro.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<1317043593-27202-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EED91245DA
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 23:21:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317043593-27202-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 26, 2011 at 04:26:25PM +0300, Peter Ujfalusi wrote:

Applied, thanks.

> -	ret = snd_soc_put_volsw(kcontrol, ucontrol);
> +	/* call the appropriate handler depending on the rreg */
> +	if (mc->rreg)
> +		ret = snd_soc_put_volsw_2r(kcontrol, ucontrol);
> +	else
> +		ret = snd_soc_put_volsw(kcontrol, ucontrol);
> +

Traditionally this would be done by comparing reg and rreg - if they're
the same they're a mono control.
