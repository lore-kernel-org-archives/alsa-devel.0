From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: SPEAr: Add dependency on
	dmaengine helpers
Date: Fri, 14 Jun 2013 17:49:06 +0530
Message-ID: <CAOh2x==4nO0eBwvtXZ177fwN8ekNc0UaCwOdg5+bchj+qbUkgQ@mail.gmail.com>
References: <1371209418-32496-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 09DB426528B
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 14:19:06 +0200 (CEST)
Received: by mail-vc0-f175.google.com with SMTP id hr11so372299vcb.20
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 05:19:06 -0700 (PDT)
In-Reply-To: <1371209418-32496-1-git-send-email-broonie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 14, 2013 at 5:00 PM, Mark Brown <broonie@linaro.org> wrote:
> I'd be very surprised if anyone has used the Kconfig...

This might be selected directly by defconfig...

> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/spear/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/spear/Kconfig b/sound/soc/spear/Kconfig
> index 3b7cdad..5b744ed 100644
> --- a/sound/soc/spear/Kconfig
> +++ b/sound/soc/spear/Kconfig
> @@ -27,6 +27,7 @@ config SND_SPEAR_SOC
>          Say Y or M if you want to add support for any of the audio
>          controllers (I2S/SPDIF). You will also need to select
>          the audio interface codecs to support below.
> +       select SND_SOC_DMAENGINE_PCM
>
>  config SND_SPEAR_SPDIF_OUT
>         tristate "SPEAr SPDIF Out Device Driver"

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
