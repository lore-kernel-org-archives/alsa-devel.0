From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add TI tlv320aic32x4 codec
	support.
Date: Fri, 4 Mar 2011 18:24:03 +0000
Message-ID: <20110304182402.GA11930@opensource.wolfsonmicro.com>
References: <1299073952-11768-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D386103994
	for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2011 19:24:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1299073952-11768-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, b32542@freescale.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 02, 2011 at 02:52:32PM +0100, Javier Martin wrote:
> This patch adds support for tlv320aic3205 and tlv320aic3254 codecs.
> It doesn't include miniDSP support for aic3254.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

I've applied this, thanks.

One thing which can be dealt with incrementally:

> +	/* Do DACs need to be swapped? */
> +	if (aic32x4->swapdacs) {
> +		snd_soc_write(codec, AIC32X4_DACSETUP, AIC32X4_LDAC2RCHN | AIC32X4_RDAC2LCHN);
> +	} else {
> +		snd_soc_write(codec, AIC32X4_DACSETUP, AIC32X4_LDAC2LCHN | AIC32X4_RDAC2RCHN);
> +	}

These should be runtime controlled: in the cases where you use it to get
a mic channel from left to right or vice versa you often have two mics
you need to swap between rather than a single static configuration (eg,
built in plus headset).
