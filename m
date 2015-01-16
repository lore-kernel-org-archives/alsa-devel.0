From: Tushar Behera <trblinux@gmail.com>
Subject: Re: [PATCH] [ALSA] ASoC: Add max98925 codec driver
Date: Fri, 16 Jan 2015 23:30:01 +0900
Message-ID: <CAC5m3By5wgfoH7B6Mz=syTohu2iWAh0yNnyqZ=PKRQjgdC=UXw@mail.gmail.com>
References: <1421356633-30617-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com
 [209.85.223.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 61625260511
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 15:30:03 +0100 (CET)
Received: by mail-ie0-f176.google.com with SMTP id tr6so20925665ieb.7
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 06:30:01 -0800 (PST)
In-Reply-To: <1421356633-30617-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anish Kumar <yesanishhere@gmail.com>
Cc: Anish Kumar <anish.kumar@maximintegrated.com>, Linux-ALSA <alsa-devel@alsa-project.org>, nitin.mittal@maximintegrated.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 16, 2015 at 6:17 AM, Anish Kumar <yesanishhere@gmail.com> wrote:
> From: Anish Kumar <anish.kumar@maximintegrated.com>
>
> This patch adds the max98925 codec driver.
>
> Signed-off-by: Anish Kumar <anish.kumar@maximintegrated.com>
> ---
>  sound/soc/codecs/max98925.c | 954 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/max98925.h | 842 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 1796 insertions(+)
>  create mode 100644 sound/soc/codecs/max98925.c
>  create mode 100644 sound/soc/codecs/max98925.h
>
> diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c

[ snip ]

> +static const struct snd_kcontrol_new max98925_snd_controls[] = {
> +
> +       SOC_SINGLE_EXT_TLV("Speaker Gain", MAX98925_R02D_GAIN,
> +               M98925_SPK_GAIN_SHIFT, (1<<M98925_SPK_GAIN_WIDTH)-1, 0,
> +               max98925_spk_gain_get, max98925_spk_gain_put, max98925_spk_tlv),
> +

You can use BIT(XXX_SHIFT) macro for 1<<XXX_SHIFT operations, makes
the code a little cleaner to look at.

> +
> +static int max98925_add_widgets(struct snd_soc_codec *codec)
> +{
> +       int ret;
> +
> +       ret = snd_soc_add_codec_controls(codec, max98925_snd_controls,
> +               ARRAY_SIZE(max98925_snd_controls));

Instead, you may only update controls and num_controls member of
snd_soc_codec_driver structure.

> +static int max98925_dai_set_fmt(struct snd_soc_dai *codec_dai,
> +                                unsigned int fmt)
> +{
> +       struct snd_soc_codec *codec = codec_dai->codec;
> +       struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
> +       struct max98925_cdata *cdata;
> +       unsigned int invert = 0;
> +
> +       pr_debug("%s: fmt 0x%08X\n", __func__, fmt);

better to use dev_dbg.

> +static int max98925_dai_set_sysclk(struct snd_soc_dai *dai,
> +                                  int clk_id, unsigned int freq, int dir)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
> +
> +       pr_debug("%s: clk_id %d, freq %d, dir %d\n",
> +                               __func__, clk_id, freq, dir);

Please use dev_dbg whenever possible.

> +       if (max98925->regmapR != NULL) {
> +               reg = 0;
> +               ret = regmap_read(max98925->regmapR,
> +                               MAX98925_R0FF_VERSION, &reg);
> +               if ((ret < 0) || ((reg != MAX98925_VERSION)
> +                               && (reg != MAX98925_VERSION1))) {
> +                       dev_err(codec->dev,
> +                               "R device initialization error (%d 0x%02X)\n",
> +                               ret, reg);
> +                       goto err_access;
> +               }
> +               dev_info(codec->dev, "R device version 0x%02X\n", reg);
> +       }
> +       regmap_write(max98925->regmapL, MAX98925_R038_GLOBAL_ENABLE, 0x00);
> +       regmap_write(max98925->regmapR, MAX98925_R038_GLOBAL_ENABLE, 0x00);
> +

Since most of the places the writes to regmapL and regmapR are
duplicated, it might be a good idea to move the calls to a function
and call that function with appropriate parameters instead.

Something like:
max98925_regmap_write_stereo(max98925, MAX98925_R038_GLOBAL_ENABLE, 0x00);

same applies for regmap_update_bits() call too.

> +static int max98925_i2c_probe(struct i2c_client *i2c_l,
> +                            const struct i2c_device_id *id)
> +{
> +       struct max98925_priv *max98925;
> +       struct i2c_client *i2c_r;
> +       int ret;
> +
> +       pr_info("%s: enter, device '%s'\n", __func__, id->name);
> +       if (strcmp(id->name, "max98925R") == 0)
> +               return 0;
> +
> +       max98925 = kzalloc(sizeof(struct max98925_priv), GFP_KERNEL);

devm_kzalloc ? no need to call kfree() in the exit path.

> +       if (max98925 == NULL)
> +               return -ENOMEM;
> +
> +       max98925->devtype = id->driver_data;
> +       i2c_set_clientdata(i2c_l, max98925);
> +       max98925->control_data = i2c_l;
> +       max98925->pdata = i2c_l->dev.platform_data;
> +
> +       max98925->regmapL = regmap_init_i2c(i2c_l, &max98925_regmap);

devm_regmap_init_i2c? You won't have call regmap_exit() explicitly.

> diff --git a/sound/soc/codecs/max98925.h b/sound/soc/codecs/max98925.h
> new file mode 100644
> index 0000000..9d89d34
> --- /dev/null
> +++ b/sound/soc/codecs/max98925.h

[ snip ]

> +
> +/* MAX98925 Register Bit Fields */
> +
> +/* MAX98925_R002_LIVE_STATUS0 */
> +#define M98925_THERMWARN_STATUS_MASK           (1<<3)
> +#define M98925_THERMWARN_STATUS_SHIFT          3
> +#define M98925_THERMWARN_STATUS_WIDTH          1

Please consider using a macro to create the mask value from shift and
width, that is less error-prone. Something like this:

#define M98925_MASK(SHIFT, WIDTH) ((BIT(WIDTH)-1) << SHIFT)
#define M98925_THERMWARN_STATUS_MASK \
M98925_MASK(M98925_THERMWARN_STATUS_SHIFT, M98925_THERMWARN_STATUS_WIDTH)

Also, for single bit definitions, you can get rid of the WIDTH
definitions unless you are using them in the code, just use
BIT(xxx_SHIFT) macro to define the mask.

Also, many of the defines are not used at all. Nothing against keeping
them (for better representation of the hardware), but you may also
consider removing them now and adding them as and when they are used
in the code.

-- 
Tushar Behera
