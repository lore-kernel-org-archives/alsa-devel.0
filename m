From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK4458 DAC driver
Date: Mon, 12 Feb 2018 10:47:05 -0200
Message-ID: <CAOMZO5CMQKRwGMo=FyY3GkFT+A_A0epq-K7K2Wccv1ihJ3Qw8w@mail.gmail.com>
References: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1517404809-25250-1-git-send-email-cosmin.samoila-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cosmin-Gabriel Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org, shengjiu.wang-3arQi8VN3Tc@public.gmane.org, Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>, Mihai Serban <mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 31, 2018 at 11:20 AM, Cosmin-Gabriel Samoila
<cosmin.samoila-3arQi8VN3Tc@public.gmane.org> wrote:
> The AK4458 is a 32-bit 8ch Premium DAC that corresponds
> to a 768kHz PCM input and an 11.2MHz DSD input at maximum.
> It supports I2S, DSD and TDM modes with 24 or 32 bit MSB
> or 16, 24, 32 LSB formats. Its datasheet is available here:
> https://www.akm.com/akm/en/file/datasheet/AK4458VN.pdf
>
> Signed-off-by: Junichi Wakasugi <wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org>
> Signed-off-by: Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Shengjiu Wang <shengjiu.wang-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>

Please sync with Daniel's recent codec submission.

Many of the feedback provided there applies to this code as well.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
