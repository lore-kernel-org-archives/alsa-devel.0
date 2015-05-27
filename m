From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 1/3] ASoC: max98090: read micbias from
	device property
Date: Tue, 26 May 2015 21:39:54 -0700
Message-ID: <CAEUnVG4C-ND7YT-ZGg-9ceCEQ9e4NdHSpBp=XRsnqEp15W+t=A@mail.gmail.com>
References: <1432684686-14460-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f46.google.com (mail-vn0-f46.google.com
 [209.85.216.46])
 by alsa0.perex.cz (Postfix) with ESMTP id E87D826577A
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 06:40:15 +0200 (CEST)
Received: by vnbg129 with SMTP id g129so9668394vnb.11
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 21:40:15 -0700 (PDT)
In-Reply-To: <1432684686-14460-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yang Fang <yang.a.fang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, Praveen K Jain <praveen.k.jain@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Denny Iriawan <denny.iriawan@intel.com>, Mark Brown <broonie@kernel.org>, "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>, kevin.strasser@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2015 at 4:58 PM,  <yang.a.fang@intel.com> wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>
> This patch reads max98090 micbias from acpi or dt
>
> Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
> ---
>  sound/soc/codecs/max98090.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index c230626..27df17e 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -2419,6 +2419,8 @@ static int max98090_probe(struct snd_soc_codec *codec)
>         struct max98090_cdata *cdata;
>         enum max98090_type devtype;
>         int ret = 0;
> +       int err;
> +       unsigned int micbias;
>
>         dev_dbg(codec->dev, "max98090_probe\n");
>
> @@ -2503,8 +2505,13 @@ static int max98090_probe(struct snd_soc_codec *codec)
>         snd_soc_write(codec, M98090_REG_BIAS_CONTROL,
>                 M98090_VCM_MODE_MASK);
>
> +       err = device_property_read_u32(codec->dev, "max,micbias", &micbias);

Should this be "maxim,micbias" to be consistent with  "maxim,dmic-freq"?
It should also be added to the Documentation for the max98090, as an
optional parameter.

> +

Extra newline.

> +       if (err)
> +               micbias = M98090_MBVSEL_2V8;
> +
>         snd_soc_update_bits(codec, M98090_REG_MIC_BIAS_VOLTAGE,
> -               M98090_MBVSEL_MASK, M98090_MBVSEL_2V8);
> +               M98090_MBVSEL_MASK, micbias);
>
>         max98090_add_widgets(codec);
>
> --
> 1.7.9.5
>
