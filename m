From: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Subject: Re: [RESEND PATCH 1/1] ASoC: fsl_ssi: Fix checking of
 dai format for AC97 mode
Date: Wed, 16 Sep 2015 11:32:59 +0200
Message-ID: <55F9374B.1030001@invoxia.com>
References: <409ab77432bd0553502b75ab98089bb7ecdb5018.1442394728.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DD1E26067A
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 11:33:03 +0200 (CEST)
Received: by wicfx3 with SMTP id fx3so63987737wic.1
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 02:33:03 -0700 (PDT)
Received: from [192.168.65.109] (AAnnecy-653-1-86-216.w90-41.abo.wanadoo.fr.
 [90.41.33.216])
 by smtp.googlemail.com with ESMTPSA id t7sm3496190wia.9.2015.09.16.02.33.00
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Sep 2015 02:33:02 -0700 (PDT)
In-Reply-To: <409ab77432bd0553502b75ab98089bb7ecdb5018.1442394728.git.Adam.Thomson.Opensource@diasemi.com>
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

Hello,

Please apply.
this kind of patch is here for a long time (I have posted one similar in =

the past) and is a requirement to make DSP_A/B working on freescale.

regards,
arnaud

Le 16/09/2015 11:13, Adam Thomson a =E9crit :
> Current code incorrectly treats dai format for AC97 as bit mask
> whereas it's actually an integer value. This causes DAI formats
> other than AC97 (e.g. DSP_B) to trigger AC97 related code,
> which is incorrect and breaks functionality. This patch fixes
> the code to correctly compare values to determine AC97 or not.
>
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>
> Patch based on v4.3-rc1.
>
>   sound/soc/fsl/fsl_ssi.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 8ec6fb2..37c5cd4 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -249,7 +249,8 @@ MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
>   =

>   static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
>   {
> -	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
> +	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) =3D=3D
> +		SND_SOC_DAIFMT_AC97;
>   }
>   =

>   static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
> @@ -947,7 +948,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
>   				CCSR_SSI_SCR_TCH_EN);
>   	}
>   =

> -	if (fmt & SND_SOC_DAIFMT_AC97)
> +	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) =3D=3D SND_SOC_DAIFMT_AC97)
>   		fsl_ssi_setup_ac97(ssi_private);
>   =

>   	return 0;
