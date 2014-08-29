From: Andreas Allacher <andreas.allacher@gmx.at>
Subject: Re: [PATCH] ALSA: virtuoso: add Xonar Essence STX II
 support
Date: Fri, 29 Aug 2014 20:29:13 +0200
Message-ID: <5400C679.4020606@gmx.at>
References: <53FC4901.6070908@allacher.com>
 <53FC49A8.1010108@gmx.at>	<53FC4D56.5020808@ladisch.de>
 <53FC6532.2080903@gmx.at> <54003095.200@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by alsa0.perex.cz (Postfix) with ESMTP id 80C30267D11
 for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 20:29:41 +0200 (CEST)
Received: from [192.168.0.110] ([82.149.97.137]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0M5LJv-1YMZII0hwd-00zVI7 for
 <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 20:29:41 +0200
In-Reply-To: <54003095.200@ladisch.de>
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

OK. The card arrived today. I will most likely test it tomorrow or the 
day afterwards.
Is the path already in the kernel source git or do I have to apply it 
manually?

Regards,
     Andreas Allacher



Am 29.08.2014 09:49, schrieb Clemens Ladisch:
> In theory, this patch should work:
>
> --- a/sound/pci/oxygen/xonar_pcm179x.c
> +++ b/sound/pci/oxygen/xonar_pcm179x.c
> @@ -419,6 +419,7 @@
>
>   	data->generic.output_enable_bit = GPIO_ST_OUTPUT_ENABLE;
>   	data->dacs = chip->model.dac_channels_mixer / 2;
> +	data->h6 = chip->model.dac_channels_mixer > 2;
>   	data->hp_gain_offset = 2*-18;
>
>   	pcm1796_init(chip);
> @@ -1140,8 +1141,18 @@
>   		break;
>   	case 0x85f4:
>   		chip->model = model_xonar_st;
> -		/* TODO: daughterboard support */
> -		chip->model.shortname = "Xonar STX II";
> +		oxygen_clear_bits16(chip, OXYGEN_GPIO_CONTROL, GPIO_DB_MASK);
> +		switch (oxygen_read16(chip, OXYGEN_GPIO_DATA) & GPIO_DB_MASK) {
> +		default:
> +			chip->model.shortname = "Xonar STX II";
> +			break;
> +		case GPIO_DB_H6:
> +			chip->model.shortname = "Xonar STX II+H6";
> +			chip->model.dac_channels_pcm = 8;
> +			chip->model.dac_channels_mixer = 8;
> +			chip->model.dac_mclks = OXYGEN_MCLKS(256, 128, 128);
> +			break;
> +		}
>   		chip->model.init = xonar_stx_init;
>   		chip->model.resume = xonar_stx_resume;
>   		chip->model.set_dac_params = set_pcm1796_params;
>
