From: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH] MLK-22197 sound: asoc: add micfil dc
 remover amixer control
Date: Thu, 4 Jul 2019 13:22:30 +0000
Message-ID: <1562246550.22836.17.camel@nxp.com>
References: <20190704125133.1463-1-ioana-irina.patru@nxp.com>
Reply-To: Viorel Suman <viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02on0620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe06::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 844C8F800E8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 15:22:32 +0200 (CEST)
In-Reply-To: <20190704125133.1463-1-ioana-irina.patru@nxp.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@nxp.com>, Irina Patru <ioana-irina.patru@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LnxRevLi <LnxRevLi@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hi Irina,

Some nitpicks inline.

/Viorel

On Jo, 2019-07-04 at 12:52 +0000, Irina Patru wrote:


<snip>


+static int micfil_put_dc_remover_state(struct snd_kcontrol *kcontrol,
+                                       struct snd_ctl_elem_value *ucontrol)
+{
+       struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+       struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+       struct fsl_micfil *micfil = snd_soc_component_get_drvdata(comp);
+       unsigned int *item = ucontrol->value.enumerated.item;
+       int val = snd_soc_enum_item_to_val(e, item[0]);
+       int i = 0, ret = 0;
+       u32 reg_val = 0;
+
+       if (val < 0 || val > 3)
+               return -1;


Maybe return -EINVAL here ?


+       micfil->dc_remover = val;
+
+       /* Calculate total value for all channels */
+       for (i = 0; i < 8; i++)
+               reg_val |= MICFIL_DC_MODE(val, i);
+
+       /* Update DC Remover mode for all channels */
+       ret = snd_soc_component_update_bits(comp,
+                                       REG_MICFIL_DC_CTRL,
+                                       MICFIL_DC_CTRL_MASK,
+                                       reg_val);


Please check the description of snd_soc_component_update_bits return value:
==========
 * Return: 1 if the operation was successful and the value of the register
 * changed, 0 if the operation was successful, but the value did not change.
 * Returns a negative error code otherwise.
==========

We may need to return a non-zero value in case of error only, ie:
=============
if (ret < 0)
return ret;

return 0;
=============


+       return ret;
+}
+
+static int micfil_get_dc_remover_state(struct snd_kcontrol *kcontrol,
+                                       struct snd_ctl_elem_value *ucontrol)
+{
+       struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+       struct fsl_micfil *micfil = snd_soc_component_get_drvdata(comp);
+
+       ucontrol->value.enumerated.item[0] = micfil->dc_remover;
+
+       return 0;
+}
+
+
 static int hwvad_put_init_mode(struct snd_kcontrol *kcontrol,
                               struct snd_ctl_elem_value *ucontrol)
 {
@@ -676,6 +731,10 @@ static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
        SOC_ENUM_EXT("Clock Source",
                     fsl_micfil_clk_src_enum,
                     micfil_get_clk_src, micfil_put_clk_src),
+       SOC_ENUM_EXT("MICFIL DC Remover Control",
+                       fsl_micfil_dc_remover_enum,
+                       micfil_get_dc_remover_state,
+                       micfil_put_dc_remover_state),
        {
                .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
                .name = "HWVAD Input Gain",
diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
index 792187b717f0..e47dba9b90b8 100644
--- a/sound/soc/fsl/fsl_micfil.h
+++ b/sound/soc/fsl/fsl_micfil.h
@@ -278,6 +278,16 @@
 #define MICFIL_HWVAD_HPF_102HZ         3
 #define MICFIL_HWVAD_FRAMET_DEFAULT    10

+/* MICFIL DC Remover Control Register -- REG_MICFIL_DC_CTRL */
+#define MICFIL_DC_CTRL_SHIFT           0
+#define MICFIL_DC_CTRL_MASK                    0xFFFF
+#define MICFIL_DC_CTRL_WIDTH           2
+#define MICFIL_DC_CHX_SHIFT(v)         (2 * (v))
+#define MICFIL_DC_CHX_MASK(v)          ((BIT(MICFIL_DC_CTRL_WIDTH) - 1) \
+                               << MICFIL_DC_CHX_SHIFT(v))
+#define MICFIL_DC_MODE(v1, v2)         (((v1) << MICFIL_DC_CHX_SHIFT(v2)) \
+                               & MICFIL_DC_CHX_MASK(v2))
+
 /* MICFIL Output Control Register */
 #define MICFIL_OUTGAIN_CHX_SHIFT(v)    (4 * (v))
