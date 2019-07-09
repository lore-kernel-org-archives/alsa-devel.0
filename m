From: gabrielcsmo@gmail.com
Subject: Re: [PATCH] MLK-22197 sound: asoc: add micfil dc
 remover amixer control
Date: Tue, 09 Jul 2019 20:11:53 +0300
Message-ID: <7d7073d339c7bfbb0079598d95c4faddbd5b51e4.camel@gmail.com>
References: <20190704125133.1463-1-ioana-irina.patru@nxp.com>
 <1562246550.22836.17.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83E75F801A4
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2019 19:11:57 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id n9so12735518wrr.4
 for <alsa-devel@alsa-project.org>; Tue, 09 Jul 2019 10:11:57 -0700 (PDT)
In-Reply-To: <1562246550.22836.17.camel@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Viorel Suman <viorel.suman@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Irina Patru <ioana-irina.patru@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LnxRevLi <LnxRevLi@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hello Irina,

Please see my comments inline.

Best regards,
Cosmin

On Thu, 2019-07-04 at 13:22 +0000, Viorel Suman wrote:
> Hi Irina,
> 
> Some nitpicks inline.
> 
> /Viorel
> 
> On Jo, 2019-07-04 at 12:52 +0000, Irina Patru wrote:
> 
> 
> <snip>
> 
> 
> +static int micfil_put_dc_remover_state(struct snd_kcontrol
> *kcontrol,
> +                                       struct snd_ctl_elem_value
> *ucontrol)
> +{
> +       struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
> +       struct soc_enum *e = (struct soc_enum *)kcontrol-
> >private_value;
> +       struct fsl_micfil *micfil =
> snd_soc_component_get_drvdata(comp);
> +       unsigned int *item = ucontrol->value.enumerated.item;
> +       int val = snd_soc_enum_item_to_val(e, item[0]);
> +       int i = 0, ret = 0;
> +       u32 reg_val = 0;
> +
> +       if (val < 0 || val > 3)

Use defines for constants instead of hardcoded values.

> +               return -1;
> 
> 
> Maybe return -EINVAL here ?
> 
> 
> +       micfil->dc_remover = val;
> +
> +       /* Calculate total value for all channels */
> +       for (i = 0; i < 8; i++)

Same as before. I think you already have MICFIL_NUM_CHANNELS in header.

> +               reg_val |= MICFIL_DC_MODE(val, i);
> +
> +       /* Update DC Remover mode for all channels */
> +       ret = snd_soc_component_update_bits(comp,
> +                                       REG_MICFIL_DC_CTRL,
> +                                       MICFIL_DC_CTRL_MASK,
> +                                       reg_val);

I don't know if there is an updated manual for MICFIL but it would be
nice to have a public link.
Please make sure that this change in the configuration can be done live
witout side-effects. Modifying some of the settings were affecting
performance or functionality and you must use other mechanism for
updating the DC_CTRL if it is the case.
> 
> 
> Please check the description of snd_soc_component_update_bits return
> value:
> ==========
>  * Return: 1 if the operation was successful and the value of the
> register
>  * changed, 0 if the operation was successful, but the value did not
> change.
>  * Returns a negative error code otherwise.
> ==========
> 
> We may need to return a non-zero value in case of error only, ie:
> =============
> if (ret < 0)
> return ret;
> 
> return 0;
> =============
> 
> 
> +       return ret;
> +}
> +
> +static int micfil_get_dc_remover_state(struct snd_kcontrol
> *kcontrol,
> +                                       struct snd_ctl_elem_value
> *ucontrol)
> +{
> +       struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
> +       struct fsl_micfil *micfil =
> snd_soc_component_get_drvdata(comp);
> +
> +       ucontrol->value.enumerated.item[0] = micfil->dc_remover;
> +
> +       return 0;
> +}
> +
> +
>  static int hwvad_put_init_mode(struct snd_kcontrol *kcontrol,
>                                struct snd_ctl_elem_value *ucontrol)
>  {
> @@ -676,6 +731,10 @@ static const struct snd_kcontrol_new
> fsl_micfil_snd_controls[] = {
>         SOC_ENUM_EXT("Clock Source",
>                      fsl_micfil_clk_src_enum,
>                      micfil_get_clk_src, micfil_put_clk_src),
> +       SOC_ENUM_EXT("MICFIL DC Remover Control",
> +                       fsl_micfil_dc_remover_enum,
> +                       micfil_get_dc_remover_state,
> +                       micfil_put_dc_remover_state),
>         {
>                 .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>                 .name = "HWVAD Input Gain",
> diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
> index 792187b717f0..e47dba9b90b8 100644
> --- a/sound/soc/fsl/fsl_micfil.h
> +++ b/sound/soc/fsl/fsl_micfil.h
> @@ -278,6 +278,16 @@
>  #define MICFIL_HWVAD_HPF_102HZ         3
>  #define MICFIL_HWVAD_FRAMET_DEFAULT    10
> 
> +/* MICFIL DC Remover Control Register -- REG_MICFIL_DC_CTRL */
> +#define MICFIL_DC_CTRL_SHIFT           0
> +#define MICFIL_DC_CTRL_MASK                    0xFFFF
> +#define MICFIL_DC_CTRL_WIDTH           2
> +#define MICFIL_DC_CHX_SHIFT(v)         (2 * (v))
> +#define MICFIL_DC_CHX_MASK(v)          ((BIT(MICFIL_DC_CTRL_WIDTH) -
> 1) \
> +                               << MICFIL_DC_CHX_SHIFT(v))
> +#define MICFIL_DC_MODE(v1, v2)         (((v1) <<
> MICFIL_DC_CHX_SHIFT(v2)) \
> +                               & MICFIL_DC_CHX_MASK(v2))
> +
>  /* MICFIL Output Control Register */
>  #define MICFIL_OUTGAIN_CHX_SHIFT(v)    (4 * (v))
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
