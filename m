From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] qcom: ipq4019: ASoC tlmm/pinctrl support
Date: Fri, 15 Jul 2016 12:15:15 -0700
Message-ID: <20160715191515.GC13516@tuxbot>
References: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
 <1468566426-19598-4-git-send-email-njaigane@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1468566426-19598-4-git-send-email-njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-A+ZNKFmMK5xy9aJCnZT0Uw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, twp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pradeepb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, snlakshm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, bselvara-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri 15 Jul 00:07 PDT 2016, njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org wrote:

> From: Jaiganesh Narayanan <njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> This patch adds the tlmm/pinctrl support for IPQ4019 ASoC.
> 
> Signed-off-by: Jaiganesh Narayanan <njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-ipq4019.c | 116 +++++++++++++++++++++++++--------
>  1 file changed, 88 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
[..]
> +	qca_mux_i2s_rx_mclk,
> +	qca_mux_i2s_rx_bclk,
> +	qca_mux_i2s_rx_fsync,
> +	qca_mux_i2s_rxd,
> +	qca_mux_i2s_tx_mclk,
> +	qca_mux_i2s_tx_bclk,
> +	qca_mux_i2s_tx_fsync,
> +	qca_mux_i2s_txd1,
> +	qca_mux_i2s_txd2,
> +	qca_mux_i2s_txd3,
> +	qca_mux_i2s_spdif_out,
> +	qca_mux_i2s_spdif_in,

I would recommend reducing this to "i2s_rx", "i2s_tx", "spdif_rx"
and "spdif_tx", as this will make the dts cleaner.

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
