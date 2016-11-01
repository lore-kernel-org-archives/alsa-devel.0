From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH][resend] drm: bridge: add DesignWare HDMI I2S audio
 support
Date: Tue, 1 Nov 2016 09:38:18 +0000
Message-ID: <20161101093818.GQ1041@n2100.armlinux.org.uk>
References: <87lgx9wa2d.wl%kuninori.morimoto.gx@renesas.com>
 <20161031160621.GE1041@n2100.armlinux.org.uk>
 <87y414dpue.wl%kuninori.morimoto.gx@renesas.com>
 <87wpgodozh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87wpgodozh.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Archit Taneja <architt@codeaurora.org>, Mark Brown <broonie@kernel.org>, David Airlie <airlied@linux.ie>, Fabio Estevam <fabio.estevam@freescale.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Thierry Reding <treding@nvidia.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 01, 2016 at 12:36:29AM +0000, Kuninori Morimoto wrote:
> 
> Hi Russell again
> 
> > > > +static struct platform_driver snd_dw_hdmi_driver = {
> > > > +	.probe	= snd_dw_hdmi_probe,
> > > 
> > > The driver must have a .remove function, because the platform device it
> > > is binding against can appear and disappear.
> > 
> > Thank you for your feedback
> > OK, I will add it
> 
> This driver uses platform_device_register_full() and calls hdmi-codec
> driver. This driver itself doesn't register sound card, like dw-hdmi-ahb-audio.c
> Then, what does .remove should do in this case ?

Remove the platform device that was created by
platform_device_register_full().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
