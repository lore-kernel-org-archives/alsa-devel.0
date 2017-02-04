From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v8 4/4] arm: dts: Add support for ES8388 to the Radxa Rock 2
Date: Sat, 04 Feb 2017 15:15:53 +0100
Message-ID: <53082230.chFLIDQHUm@phil>
References: <20170203143800.23859-1-romain.perier@collabora.com> <20170203143800.23859-5-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170203143800.23859-5-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Romain,

Am Freitag, 3. Februar 2017, 15:38:00 CET schrieb Romain Perier:
> This commit adds the DT definition of the es8388 i2c device
> found at address 0x10. It also adds the definition for connecting
> the Rockchip I2S to the es8388 analog output.
> 
> This commit is based on the initial work that was done by Sjoerd Simons
> <sjoerd.simons-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> with some improvements.
> 
> Signed-off-by: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>

applied for 4.12, with the following changes:

- subject: ARM: dts: rockchip: ... (ARM upper case + "rockchip:")
- sound-i2s (dash instead of underscore, better alphabetical ordering)
- es8388: dropped clock-names property, the driver only ever grabs the first
  clock and clock-names is not part of the binding


Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
