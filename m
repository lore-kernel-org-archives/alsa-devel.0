From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4] drm: bridge: add DesignWare HDMI I2S audio support
Date: Tue, 8 Nov 2016 11:10:10 +0000
Message-ID: <20161108111009.GO1041@n2100.armlinux.org.uk>
References: <8737j2bxba.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8737j2bxba.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Archit Taneja <architt@codeaurora.org>, Mark Brown <broonie@kernel.org>, David Airlie <airlied@linux.ie>, Fabio Estevam <fabio.estevam@freescale.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Thierry Reding <treding@nvidia.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 08, 2016 at 01:00:57AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current dw-hdmi is supporting sound via AHB bus, but it has
> I2S audio feature too. This patch adds I2S audio support to dw-hdmi.
> This HDMI I2S is supported by using ALSA SoC common HDMI encoder
> driver.
> 
> Tested-by: Jose Abreu <joabreu@synopsys.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 
>  - use IS_ERR() instead of IS_ERR_OR_NULL() on probe()

Thanks, that looks good now.

> @@ -11,4 +11,11 @@ struct dw_hdmi_audio_data {
>  	u8 *eld;
>  };
>  
> +struct dw_hdmi_i2s_audio_data {
> +	struct dw_hdmi *hdmi;
> +
> +	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
> +	u8 (*read)(struct dw_hdmi *hdmi, int offset);
> +};

Another slight concern here is why we need this separate data for i2s -
maybe adding the write/read ops to struct dw_hdmi_audio_data would be
a better thing to do, which would then allow the AHB audio to drop
the .base argument in the future.

I'm not that bothered about this though.  So...

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
