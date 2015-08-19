From: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v3 2/4] ASoC: rockchip: Add rockchip SPDIF transceiver
 driver
Date: Wed, 19 Aug 2015 08:56:48 +0200
Message-ID: <1439967408.4135.84.camel@collabora.co.uk>
References: <1438947854-3743-1-git-send-email-sjoerd.simons@collabora.co.uk>
	 <1438947854-3743-3-git-send-email-sjoerd.simons@collabora.co.uk>
	 <1463451.tH10lfH9Hm@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463451.tH10lfH9Hm@phil>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hey Heiko,

Thanks for the comments, i'm hoping to address them and Marks comments
in a next patch series next week.

On Tue, 2015-08-18 at 20:25 +0200, Heiko Stuebner wrote:

> > +
> > +     spdif->hclk = devm_clk_get(&pdev->dev, "spdif_hclk");

> I guess this could be named just "hclk" - as it is the identifier 
> local to the spdif-ip. (Of course in the binding too)

I'm entirely happy to change that, just wanted to note that the reason
i used spdif_hclk and spidf_clk is for consistency with the rockchip
-i2s binding which uses i2s_hclk ans i2s_mclk. 

However i guess we could update the i2s binding at some poit as well to
follow similar names (with fallbacks to the old one). In general a lot
of the comments yourself and Mark have given actually apply to the
rockchip-i2s code as well so there is some cleanup to do there :)

-- 
Sjoerd Simons
Collabora Ltd.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
