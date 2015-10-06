From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
Date: Tue, 6 Oct 2015 15:07:40 -0300
Message-ID: <CAOMZO5COgoGU-3YNpnmSkctHMRDJ3=DuKc82Wb5zTTX7Bx2jNw@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
	<E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-rockchip@lists.infradead.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Yakir Yang <ykk@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 8, 2015 at 1:10 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Add ALSA based HDMI AHB audio driver for dw_hdmi.  The only buffer
> format supported by the hardware is its own special IEC958 based format,
> which is not compatible with any ALSA format.  To avoid doing too much
> data manipulation within the driver, we support only ALSAs IEC958 LE and
> 24-bit PCM formats for 2 to 6 channels, which we convert to its hardware
> format.
>
> A more desirable solution would be to have this conversion in userspace,
> but ALSA does not appear to allow such transformations outside of
> libasound itself.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I applied this series, but the HDMI audio card is not registered. I
guess I missed the dts pieces. Are the dts patches available?

Thanks
