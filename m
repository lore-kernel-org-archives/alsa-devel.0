From: Kevin Cernekee <cernekee@chromium.org>
Subject: Re: [PATCH 3/5] Sound: SOC: TAS571x: implemented
	digital mute
Date: Mon, 14 Mar 2016 12:39:27 -0700
Message-ID: <CAJzqFtYAJ1uhSzgc+LPg0C5NrJ+fWeXGu2aJ1TNsNoYCOCaAPw@mail.gmail.com>
References: <1457608960-16913-1-git-send-email-petr@barix.com>
 <1457608960-16913-3-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
 [209.85.218.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 53FB1260504
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 20:39:49 +0100 (CET)
Received: by mail-oi0-f50.google.com with SMTP id r187so141992263oih.3
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 12:39:49 -0700 (PDT)
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com.
 [209.85.214.172])
 by smtp.gmail.com with ESMTPSA id tr6sm10260930obb.18.2016.03.14.12.39.47
 for <alsa-devel@alsa-project.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Mon, 14 Mar 2016 12:39:47 -0700 (PDT)
Received: by mail-ob0-f172.google.com with SMTP id ts10so187631739obc.1
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 12:39:47 -0700 (PDT)
In-Reply-To: <1457608960-16913-3-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 10, 2016 at 3:22 AM, Petr Kulhavy <petr@barix.com> wrote:
> The driver did not have a mute function. The amplifier was brought out of
> shutdown mode (hard-mute) once for ever in probe(), which was causing
> clicks and pops when altering the I2C register configuration later.
>
> This adds the digital_mute() function. The amplifier unmute in probe()
> was removed.
>
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> Tested-by: Petr Kulhavy <petr@barix.com>
> ---
>  sound/soc/codecs/tas571x.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
> index 2a63069..431dffa 100644
> --- a/sound/soc/codecs/tas571x.c
> +++ b/sound/soc/codecs/tas571x.c
> @@ -171,6 +171,23 @@ static int tas571x_hw_params(struct snd_pcm_substream *substream,
>                                   TAS571X_SDI_FMT_MASK, val);
>  }
>
> +static int tas571x_mute(struct snd_soc_dai *dai, int mute)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       u8 sysctl2;
> +       int ret;
> +
> +       sysctl2 = mute ? TAS571X_SYS_CTRL_2_SDN_MASK : 0;
> +
> +       ret = snd_soc_update_bits(codec,
> +                           TAS571X_SYS_CTRL_2_REG,
> +                    TAS571X_SYS_CTRL_2_SDN_MASK,
> +                    sysctl2);
> +       usleep_range(1000, 2000);
> +
> +       return ret;
> +}
> +
>  static int tas571x_set_bias_level(struct snd_soc_codec *codec,
>                                   enum snd_soc_bias_level level)
>  {
> @@ -218,6 +235,7 @@ static int tas571x_set_bias_level(struct snd_soc_codec *codec,
>  static const struct snd_soc_dai_ops tas571x_dai_ops = {
>         .set_fmt        = tas571x_set_dai_fmt,
>         .hw_params      = tas571x_hw_params,
> +       .digital_mute   = tas571x_mute,
>  };

Hi Petr,

It is good to see that this driver is getting some use. :-)

An earlier iteration of the code implemented digital_mute, although it
used a different register:

+        return regmap_update_bits(priv->regmap,
+                                 TAS571X_SOFT_MUTE_REG,
+                                 TAS571X_SOFT_MUTE_CH_MASK,
+                                 mute ? TAS571X_SOFT_MUTE_CH_MASK : 0);

This was removed here: https://chromium-review.googlesource.com/#/c/265878/

Are you able to test the modified code on 5711 and 5717 (or 5719)?
