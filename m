From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: sdp4430: Fix Panda support
Date: Mon, 21 Nov 2011 13:38:36 +0000
Message-ID: <20111121133836.GA22906@opensource.wolfsonmicro.com>
References: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
	<1321881246-24163-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B026224336
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 14:38:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321881246-24163-3-git-send-email-peter.ujfalusi@ti.com>
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

On Mon, Nov 21, 2011 at 03:14:06PM +0200, Peter Ujfalusi wrote:

> -	if (!machine_is_omap_4430sdp())
> +	if (machine_is_omap_4430sdp())
> +		snd_soc_sdp4430.name = "OMAP4 SDP";
> +	else if (machine_is_omap4_panda())
> +		snd_soc_sdp4430.name = "OMAP4 Panda";
> +	else

I'm not thrilled by this given that I'd imagine this'll end up like
Beagle and have lots of derivatives.  Why not just change the string to
be something generic along the lines of "OMAP4 audio reference design"
rather than the name of a particular board?
