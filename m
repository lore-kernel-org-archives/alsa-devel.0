From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH 3/3] ASoC: qcom: add i2c dependency for SND_SOC_SDM845
Date: Tue, 5 Mar 2019 10:27:56 +0800
Message-ID: <CAFv8NwJX7Vv0aPx=Lp51UmroX9K5F2tj66oWLcOKhxWoiS2sBQ@mail.gmail.com>
References: <20190304203114.1894822-1-arnd@arndb.de> <20190304203114.1894822-3-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304203114.1894822-3-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rohit kumar <rohitkr@codeaurora.org>, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 5, 2019 at 4:32 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> We must not select SND_SOC_MAX98927 unless CONFIG_I2C
> is also enabled:
>
> WARNING: unmet direct dependencies detected for SND_SOC_MAX98927
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
>   Selected by [y]:
>   - SND_SOC_SDM845 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && QCOM_APR [=y] && MFD_CROS_EC [=y]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 75ceb04d8bf0..b1764af858ba 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -98,7 +98,7 @@ config SND_SOC_MSM8996
>
>  config SND_SOC_SDM845
>         tristate "SoC Machine driver for SDM845 boards"
> -       depends on QCOM_APR && MFD_CROS_EC
> +       depends on QCOM_APR && MFD_CROS_EC && I2C
>         select SND_SOC_QDSP6
>         select SND_SOC_QCOM_COMMON
>         select SND_SOC_RT5663
> --
> 2.20.0
>
Hi Arnd,
Thank you for the fix.
Acked-by: Cheng-Yi Chiang <cychiang@chromium.org>
