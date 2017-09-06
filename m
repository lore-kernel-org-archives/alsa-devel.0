From: =?UTF-8?Q?Oleksandr_M=c3=bcller?= <sanj3k@gmail.com>
Subject: How to apply a SOC_DAPM_MUX if two there are two
 different input register for left and right channel?
Date: Wed, 6 Sep 2017 15:35:36 +0200
Message-ID: <3ec804f6-847c-2cb2-5851-c1666614e77e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id ACF8E266B60
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 15:35:36 +0200 (CEST)
Received: by mail-wm0-f49.google.com with SMTP id f199so9540340wme.0
 for <alsa-devel@alsa-project.org>; Wed, 06 Sep 2017 06:35:36 -0700 (PDT)
Received: from ?IPv6:2a02:8108:4b40:11c0:f199:d4e4:29d2:c49d?
 ([2a02:8108:4b40:11c0:f199:d4e4:29d2:c49d])
 by smtp.gmail.com with ESMTPSA id s9sm2314319wra.73.2017.09.06.06.35.35
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Sep 2017 06:35:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello guys,

I have some trouble I want to implement a mux within the mixer 
application for the VIN source of my adc. Taking a look into the 
datasheet of the TI-PCM1863 adc I get the information that the VIN left 
register is at the 0x06 and the VIN right register is at the 0x07 
address. Right now my code would look like this and here comes the 
problem it seems that there is only a SOC_ENUM_SINGLE_DECL or a 
SOC_ENUM_DOUBLE_DECL but no SOC_ENUM_DOUBLE_R_DECL because the 
DOUBLE_DECL only allows shiftl and shiftr as the input parameters but I 
would need a regl regr parameter. Is the only option to duplicate the 
code and define a VIN_L_MUX and a VIN_R_MUX?

static const char * const pcm1863_adc_vin_src[] = {
         "VIN1", "VIN2", "VIN3", "VIN4"
};

static SOC_ENUM_SINGLE_DECL(
         pcm1863_adc_vin_enum, PCM1863_ADC1_INPUT_SEL_L,
         PCM1863_SEL_L_SHIFT, pcm1863_vin_src);

static const struct snd_kcontrol_new pcm1863_adc_vin_mux =
         SOC_DAPM_ENUM("ADC VIN Source", pcm1863_adc_vin_enum);

static const struct snd_soc_dapm_widget pcm1863_dapm_widgets[] = {
         [...]
         SND_SOC_DAPM_MUX("ADC VIN Mux", SND_SOC_NOPM, 0, 0,
                                 &pcm1863_adc_vin_mux),
};

- Sanj3k
