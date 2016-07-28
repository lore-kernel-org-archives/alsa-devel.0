From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH 1/3] drm: bridge: add DesignWare HDMI I2S audio support
Date: Thu, 28 Jul 2016 17:05:34 +0100
Message-ID: <579A2D4E.9000207@synopsys.com>
References: <874m8jxqcy.wl%kuninori.morimoto.gx@renesas.com>
 <8737o3xqab.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8737o3xqab.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, David Airlie <airlied@linux.ie>, Russell King <rmk+kernel@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@freescale.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Thierry Reding <treding@nvidia.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,


On 24-06-2016 03:40, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current dw-hdmi is supporting sound via AHB bus, but it has
> I2S audio feature too. This patch adds I2S audio support to dw-hdmi.
> This HDMI I2S is supported by using ALSA SoC common HDMI encoder
> driver.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>

I just tested this patch and everything seems ok. Should I give
my tested-by?

Best regards,
Jose Miguel Abreu
