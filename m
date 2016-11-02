From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3] drm: bridge: add DesignWare HDMI I2S audio support
Date: Wed, 2 Nov 2016 08:27:58 +0000
Message-ID: <20161102082758.GV1041@n2100.armlinux.org.uk>
References: <871syu4r3x.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871syu4r3x.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Archit Taneja <architt@codeaurora.org>, Mark Brown <broonie@kernel.org>, David Airlie <airlied@linux.ie>, Fabio Estevam <fabio.estevam@freescale.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Thierry Reding <treding@nvidia.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 02, 2016 at 01:18:35AM +0000, Kuninori Morimoto wrote:
> +	platform = platform_device_register_full(&pdevinfo);
> +	if (IS_ERR_OR_NULL(platform))
> +		return PTR_ERR(platform);

This is wrong.  If platform is NULL, PTR_ERR() will return zero, which
will be interpreted as success.  Please, avoid using IS_ERR_OR_NULL(),
it leads to exactly this kind of cockup - and it's unnecessary here
because platform_device_register_full() does not return NULL.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
