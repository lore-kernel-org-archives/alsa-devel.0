From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 1/5] ASoC: hdmi-codec: Add an op to set callback
 function for plug event
Date: Fri, 12 Jul 2019 11:57:45 +0100
Message-ID: <20190712105745.xr7jxc626lwoaajx@shell.armlinux.org.uk>
References: <20190712100443.221322-1-cychiang@chromium.org>
 <20190712100443.221322-2-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190712100443.221322-2-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, dianders@chromium.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, tzungbi@chromium.org, Jaroslav Kysela <perex@perex.cz>, Hans Verkuil <hverkuil@xs4all.nl>, Andrzej Hajda <a.hajda@samsung.com>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel@ffwll.ch>, dgreid@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 12, 2019 at 06:04:39PM +0800, Cheng-Yi Chiang wrote:
> Add an op in hdmi_codec_ops so codec driver can register callback
> function to handle plug event.
> 
> Driver in DRM can use this callback function to report connector status.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  include/sound/hdmi-codec.h    | 16 +++++++++++++
>  sound/soc/codecs/hdmi-codec.c | 45 +++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> index 7fea496f1f34..9a8661680256 100644
> --- a/include/sound/hdmi-codec.h
> +++ b/include/sound/hdmi-codec.h
> @@ -47,6 +47,9 @@ struct hdmi_codec_params {
>  	int channels;
>  };
>  
> +typedef void (*hdmi_codec_plugged_cb)(struct device *dev,
> +				      bool plugged);
> +

I'd like to pose a question for people to think about.

Firstly, typedefs are generally shunned in the kernel.  However, for
these cases it seems to make sense.

However, should the "pointer"-ness be part of the typedef or not?  To
see what I mean, consider:

	typedef void (*hdmi_foo)(void);

	int register_foo(hdmi_foo foo);

vs

	typedef void hdmi_foo(void);

	int register_foo(hdmi_foo *foo);

which is more in keeping with how we code non-typedef'd code - it's
obvious that foo is a pointer while reading the code.

It seems to me that the latter better matches what is in the kernel's
coding style, which states:

  In general, a pointer, or a struct that has elements that can
  reasonably be directly accessed should **never** be a typedef.

or maybe Documentation/process/coding-style.rst needs updating?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
