From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: codecs: ad193x: Fix frame polarity
 for DSP_A format
Date: Wed, 19 Jun 2019 17:34:14 +0300
Message-ID: <20190619143414.GA26033@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C642F808AF
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 16:34:28 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: codrin.ciubotariu@microchip.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Codrin,

Linus recently corrected me on one of my patches and I said I would
look through the kernel and fix similar bugs as well.  The problem I
realized is that I'm really stupid and I have forgot how to do math...

The patch 90f6e6803139: "ASoC: codecs: ad193x: Fix frame polarity for
DSP_A format" from Feb 18, 2019, leads to the following static
checker warning:

	sound/soc/codecs/ad193x.c:244 ad193x_set_dai_fmt()
	warn: passing casted pointer '&dac_fmt' to 'change_bit()' 32 vs 64.

sound/soc/codecs/ad193x.c
   194  static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
   195                  unsigned int fmt)
   196  {
   197          struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(codec_dai->component);
   198          unsigned int adc_serfmt = 0;
   199          unsigned int dac_serfmt = 0;
   200          unsigned int adc_fmt = 0;
   201          unsigned int dac_fmt = 0;
                ^^^^^^^^^^^^^^^^^^^^^^^^
This is a u32.

   202  
   203          /* At present, the driver only support AUX ADC mode(SND_SOC_DAIFMT_I2S
   204           * with TDM), ADC&DAC TDM mode(SND_SOC_DAIFMT_DSP_A) and DAC I2S mode
   205           * (SND_SOC_DAIFMT_I2S)
   206           */
   207          switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
   208          case SND_SOC_DAIFMT_I2S:
   209                  adc_serfmt |= AD193X_ADC_SERFMT_TDM;
   210                  dac_serfmt |= AD193X_DAC_SERFMT_STEREO;
   211                  break;
   212          case SND_SOC_DAIFMT_DSP_A:
   213                  adc_serfmt |= AD193X_ADC_SERFMT_AUX;
   214                  dac_serfmt |= AD193X_DAC_SERFMT_TDM;
   215                  break;
   216          default:
   217                  if (ad193x_has_adc(ad193x))
   218                          return -EINVAL;
   219          }
   220  
   221          switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
   222          case SND_SOC_DAIFMT_NB_NF: /* normal bit clock + frame */
   223                  break;
   224          case SND_SOC_DAIFMT_NB_IF: /* normal bclk + invert frm */
   225                  adc_fmt |= AD193X_ADC_LEFT_HIGH;
   226                  dac_fmt |= AD193X_DAC_LEFT_HIGH;
   227                  break;
   228          case SND_SOC_DAIFMT_IB_NF: /* invert bclk + normal frm */
   229                  adc_fmt |= AD193X_ADC_BCLK_INV;
   230                  dac_fmt |= AD193X_DAC_BCLK_INV;
   231                  break;
   232          case SND_SOC_DAIFMT_IB_IF: /* invert bclk + frm */
   233                  adc_fmt |= AD193X_ADC_LEFT_HIGH;
   234                  adc_fmt |= AD193X_ADC_BCLK_INV;
   235                  dac_fmt |= AD193X_DAC_LEFT_HIGH;
   236                  dac_fmt |= AD193X_DAC_BCLK_INV;
   237                  break;
   238          default:
   239                  return -EINVAL;
   240          }
   241  
   242          /* For DSP_*, LRCLK's polarity must be inverted */
   243          if (fmt & SND_SOC_DAIFMT_DSP_A) {
   244                  change_bit(ffs(AD193X_DAC_LEFT_HIGH) - 1,
   245                             (unsigned long *)&dac_fmt);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This change_bit() will work on little endian systems but on 64 bit big
endian systems it will corrupt memory.  I *think* the correct code looks
like this, but again, I'm feeling dumb so I might be wrong:

			dac_fmt ^= 1 << (ffs(AD193X_DAC_LEFT_HIGH) - 1);

   246          }
   247  

regards,
dan carpenter
