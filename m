From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 5/9] drm: bridge/dw_hdmi: avoid being recursive in N calculation
Date: Fri, 4 Sep 2015 10:50:19 -0700
Message-ID: <CAD=FV=WJAm=EpugwnnBjPKJV1OOybyE6hkdhU2RrN0AR2qae6w@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
	<E1ZO6hX-0003NK-0H@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E1ZO6hX-0003NK-0H@rmk-PC.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, alsa-devel@alsa-project.org, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Philipp Zabel <p.zabel@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>, Yakir Yang <ykk@rock-chips.com>, Fabio Estevam <fabio.estevam@freescale.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Sascha Hauer <s.hauer@pengutronix.de>, Jon Nettleton <jon.nettleton@gmail.com>, David Airlie <airlied@linux.ie>
List-Id: alsa-devel@alsa-project.org

Russell,

On Sat, Aug 8, 2015 at 9:10 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> There's no need to be recursive when computing the N value for the ACR
> packet - we can instead calculate the multiplier prior to our switch()
> based lookup, and multiply the N value appropriately afterwards.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/bridge/dw_hdmi.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)

For what it's worth, I backported this change into my local 3.14-based
tree and it worked for me.  It also looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
