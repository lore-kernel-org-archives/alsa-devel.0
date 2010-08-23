From: Murat Sahin <murat.sahin.zeisberg@googlemail.com>
Subject: Problem to init AD1938 on i.MX25
Date: Mon, 23 Aug 2010 16:55:50 +0200
Message-ID: <4C728BF6.506@googlemail.com>
Reply-To: murat.sahin@zeisberg.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 300F1103805
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 16:55:55 +0200 (CEST)
Received: by bwz4 with SMTP id 4so134389bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 07:55:55 -0700 (PDT)
References: 20100816073040.GH27749@pengutronix.de
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  Thanks Sascha for your Informations.
The Problem was solved by adding soc-cache.c and changing the KARO-SPI 
driver with them from Mainline.

The codec is still running, but now we have another problem.
The AD1938 has 8 channels, the driver for i.mx25 supports 2 channels.
How we can solve the Problem?

static int imx_ad1938_hw_params(struct snd_pcm_substream *substream,
     struct snd_pcm_hw_params *params)
{
     struct snd_soc_pcm_runtime *rtd = substream->private_data;
     struct snd_soc_dai_link *machine = rtd->dai;
     struct snd_soc_dai *cpu_dai = machine->cpu_dai;
     struct snd_soc_dai *codec_dai = machine->codec_dai;
     struct imx_ssi *ssi_mode = cpu_dai->private_data;
     unsigned int channels = params_channels(params);
     u32 dai_format;

     int ret;

        ssi_mode->sync_mode = 1;
     if (channels == 1)
         ssi_mode->network_mode = 0;
     else
         ssi_mode->network_mode = 1;

         dai_format = SND_SOC_DAIFMT_DSP_A |
         SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM;

     /* set codec DAI configuration */
     ret = snd_soc_dai_set_fmt(codec_dai, dai_format);
     if (ret) {
         pr_err("%s: failed set codec dai format\n", __func__);
     return ret;
     }

     /* set codec DAI slots, 8 channels, all channels are enabled */
     ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xFF, 0xFF, 8, 32);
     if (ret) {
         pr_err("%s: failed set codec dai tdm slot\n", __func__);
     return ret;
     }

BR
Murat Sahin
Zeisberg GmbH
