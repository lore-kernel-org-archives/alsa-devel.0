From: =?UTF-8?Q?Oleksandr_M=c3=bcller?= <sanj3k@gmail.com>
Subject: SOC_DAPM_MUX implementation,
 routes missing and do I need more dapm definitions?
Date: Thu, 7 Sep 2017 18:33:42 +0200
Message-ID: <81326d89-262b-b79c-31fb-13671c314b81@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id EB30E2674E4
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 18:33:43 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id f199so2261646wme.0
 for <alsa-devel@alsa-project.org>; Thu, 07 Sep 2017 09:33:43 -0700 (PDT)
Received: from ?IPv6:2a02:8108:4b40:11c0:68e6:23e:6256:3b00?
 ([2a02:8108:4b40:11c0:68e6:23e:6256:3b00])
 by smtp.gmail.com with ESMTPSA id e34sm42802wre.15.2017.09.07.09.33.41
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Sep 2017 09:33:42 -0700 (PDT)
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

I began with the implementation of a dapm mux and am almost done but I 
don't get how to configure the routes and I am not sure if I need more 
dapm definitions. As the capture stream is the source into the 
SE_IN_L/SE_IN_R I would say this should be the source for the left/right 
mux (right side of the route definition). Then I would need a switch in 
the middle and on the left side as the output should be the ADC1 (left 
side).

{ "ADC1", ADC1VINSWITCHLEFT, "SE_IN_L" }, I would think it should look 
something like this. But then I would need some SOC_DAPM_SINGLE, I think 
you can see I am clearly confused right now :)

I would like to have a mux where I can switch the vin source from vin1 
to vin4 in alsamixer and then its saved as a default. Because in the 
layout plan the vin4 is connected and needs to be selected...

My code so far looks like this:

static const char * const pcm1863_adc_vinl_src[] = {
         "VIN1l", "VIN4l"
};

static const char * const pcm1863_adc_vinr_src[] = {
         "VIN1r", "VIN4r"
};
/*Stereo ADC Source VIN1 left/right */
static SOC_ENUM_SINGLE_DECL(
         pcm1863_adc_vin1l_enum, PCM1863_ADC1_INPUT_SEL_L,
         PCM1863_SEL_L_VIN1_SFT, pcm1863_adc_vinl_src);

static SOC_ENUM_SINGLE_DECL(
         pcm1863_adc_vin1r_enum, PCM1863_ADC1_INPUT_SEL_R,
         PCM1863_SEL_R_VIN1_SFT, pcm1863_adc_vinr_src);
/*Stereo ADC Source VIN4 left/right */
static SOC_ENUM_SINGLE_DECL(
         pcm1863_adc_vin4l_enum, PCM1863_ADC1_INPUT_SEL_L,
         PCM1863_SEL_L_VIN4_SFT, pcm1863_adc_vinl_src);

static SOC_ENUM_SINGLE_DECL(
         pcm1863_adc_vin4r_enum, PCM1863_ADC1_INPUT_SEL_R,
         PCM1863_SEL_R_VIN4_SFT, pcm1863_adc_vinr_src);

static const struct snd_kcontrol_new pcm1863_adc_vin1l_mux =
         SOC_DAPM_ENUM("ADC VIN1l Source", pcm1863_adc_vin1l_enum);

static const struct snd_kcontrol_new pcm1863_adc_vin1r_mux =
         SOC_DAPM_ENUM("ADC VIN1r Source", pcm1863_adc_vin1r_enum);

static const struct snd_kcontrol_new pcm1863_adc_vin4l_mux =
         SOC_DAPM_ENUM("ADC VIN4l Source", pcm1863_adc_vin4l_enum);

static const struct snd_kcontrol_new pcm1863_adc_vin4r_mux =
         SOC_DAPM_ENUM("ADC VIN4r Source", pcm1863_adc_vin4r_enum);

static const struct snd_soc_dapm_widget pcm1863_dapm_widgets[] = {
         SND_SOC_DAPM_ADC("ADC1", NULL, SND_SOC_NOPM, 0, 0),
         SND_SOC_DAPM_INPUT("SE_IN_L"),
         SND_SOC_DAPM_INPUT("SE_IN_R"),
         SND_SOC_DAPM_MUX("ADC VIN1l Mux", SND_SOC_NOPM, 0, 0,
                                 &pcm1863_adc_vin1l_mux),
         SND_SOC_DAPM_MUX("ADC VIN1r Mux", SND_SOC_NOPM, 0, 0,
                                 &pcm1863_adc_vin1r_mux),
         SND_SOC_DAPM_MUX("ADC VIN1l Mux", SND_SOC_NOPM, 0, 0,
                                 &pcm1863_adc_vin4l_mux),
         SND_SOC_DAPM_MUX("ADC VIN1r Mux", SND_SOC_NOPM, 0, 0,
                                 &pcm1863_adc_vin4r_mux),
};

static const struct snd_soc_dapm_route pcm1863_dapm_routes[] = {
         { "ADC1", NULL, "SE_IN_L" },
         { "ADC1", NULL, "SE_IN_R" },
         { "SE_IN_L", NULL, "Capture" },
         { "SE_IN_R", NULL, "Capture" },
};
