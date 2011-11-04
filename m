From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 RESEND] ASoC: wm9081: Use
 snd_soc_update_bits for read-modify-write
Date: Fri, 4 Nov 2011 22:17:31 +0000
Message-ID: <20111104221730.GA16978@opensource.wolfsonmicro.com>
References: <1318993587.7128.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 30EBC1038E5
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 23:17:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1318993587.7128.7.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 19, 2011 at 11:06:27AM +0800, Axel Lin wrote:

>  			/* Normal bias enable & soft start off */
> -			reg |= WM9081_BIAS_ENA;
> -			reg &= ~WM9081_VMID_RAMP;
> -			snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
> +			snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
> +					    WM9081_VMID_RAMP | WM9081_BIAS_ENA |
> +					    WM9081_VMID_SEL_MASK,
> +					    WM9081_BIAS_ENA);

This looks (and sounds) wrong - the original code didn't touch
VMID_SEL_MASK for this update but the new version will clear
VMID_SEL_MASK.  Even with that fixed there still seems to be some issue
here, though.
