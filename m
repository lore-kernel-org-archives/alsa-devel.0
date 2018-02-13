From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/2] Add support for AK4458 DAC
Date: Tue, 13 Feb 2018 20:32:23 +0200
Message-ID: <CAHp75VeTeZztEXQTpFM4Wa-zmtH3qOz21Mn=30YmAMEG4PROxA@mail.gmail.com>
References: <1518531288-2017-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518531288-2017-1-git-send-email-cosmin.samoila-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cosmin-Gabriel Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mihai Serban <mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dl-linux-imx <linux-imx-3arQi8VN3Tc@public.gmane.org>, shegjiu.wang-3arQi8VN3Tc@public.gmane.org, Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 13, 2018 at 4:14 PM, Cosmin-Gabriel Samoila
<cosmin.samoila-3arQi8VN3Tc@public.gmane.org> wrote:
> We support Normal Mode, TDM Mode and PM.
>

Read the comments Mark and me gave against another [1] submission.

[1]: https://www.spinics.net/lists/alsa-devel/msg73471.html

> Changes since V1:
> - support only i2c
> - i2c probe / remove/suspend/ resume moved into shared code
> - change enum array to separate variables
> - aggregate Volume control for Left and Right Channel
> - remove mux from DAPM
> - remove unused functions
> - remove unused controls
> - remove unused macros
> - use snd_soc_update_bits instead of soc_read + soc_write
> - use GPIOD
> - use SPDX identifier
> - use dac@10 instgitead of ak4458@10
> - use explicit power_on/off functions
> - add __maybe_unused attribute
> - use probe_new for i2c_probe
>
> Cosmin-Gabriel Samoila (2):
>   ASoC: codecs: Add support for AK4458 DAC driver
>   ASoC: ak4458: Add bindings for AK4458 DAC
>
>  Documentation/devicetree/bindings/sound/ak4458.txt |  23 +
>  sound/soc/codecs/Kconfig                           |   6 +
>  sound/soc/codecs/Makefile                          |   2 +
>  sound/soc/codecs/ak4458.c                          | 684 +++++++++++++++++++++
>  sound/soc/codecs/ak4458.h                          |  75 +++
>  5 files changed, 790 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
>  create mode 100644 sound/soc/codecs/ak4458.c
>  create mode 100644 sound/soc/codecs/ak4458.h
>
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
