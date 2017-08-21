From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 03/12] ASoC: Intel: Remove unnecessary
 function call
Date: Mon, 21 Aug 2017 13:03:18 -0500
Message-ID: <c4ffd7fa-f6e9-8d45-64c5-227421c89d2a@linux.intel.com>
References: <1503206547-15121-1-git-send-email-dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503206547-15121-1-git-send-email-dolinux.peng@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Donglin <dolinux.peng@gmail.com>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/20/2017 12:22 AM, Peng Donglin wrote:

> First of all,the address of pdev->dev is assigned to card->dev, when
> calling snd_soc_register_card,the function dev_set_drvdata(card->dev, card)
> copies the value the variable card to card->dev->driver_data.After
> that,the function platform_set_drvdata does the same copy operation,
> so i think that the latter copy operation can be removed.
>
> Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
> ---
>   sound/soc/intel/boards/bytcht_da7213.c       | 1 -
>   sound/soc/intel/boards/bytcht_es8316.c       | 1 -
>   sound/soc/intel/boards/bytcr_rt5651.c        | 1 -
>   sound/soc/intel/boards/cht_bsw_max98090_ti.c | 1 -
>   sound/soc/intel/boards/cht_bsw_rt5645.c      | 1 -
>   sound/soc/intel/boards/cht_bsw_rt5672.c      | 1 -

I think you're correct but you missed other occurrences of this function 
call:

$ grep platform_set_drvdata *.c
bytcht_da7213.c:    platform_set_drvdata(pdev, card);
bytcht_es8316.c:    platform_set_drvdata(pdev, &byt_cht_es8316_card);
bytcht_nocodec.c:    platform_set_drvdata(pdev, &bytcht_nocodec_card);
bytcr_rt5640.c:    platform_set_drvdata(pdev, &byt_rt5640_card);
bytcr_rt5651.c:    platform_set_drvdata(pdev, &byt_rt5651_card);
cht_bsw_max98090_ti.c:    platform_set_drvdata(pdev, &snd_soc_card_cht);
cht_bsw_rt5645.c:    platform_set_drvdata(pdev, card);
cht_bsw_rt5672.c:    platform_set_drvdata(pdev, &snd_soc_card_cht);
mfld_machine.c:    platform_set_drvdata(pdev, mc_drv_ctx);


>   6 files changed, 6 deletions(-)
>
> diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
> index 18873e2..fbc870b 100644
> --- a/sound/soc/intel/boards/bytcht_da7213.c
> +++ b/sound/soc/intel/boards/bytcht_da7213.c
> @@ -265,7 +265,6 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
>   			"snd_soc_register_card failed %d\n", ret_val);
>   		return ret_val;
>   	}
> -	platform_set_drvdata(pdev, card);
>   	return ret_val;
>   }
>   
> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index 5263546..5e6e8e9 100644
> --- a/sound/soc/intel/boards/bytcht_es8316.c
> +++ b/sound/soc/intel/boards/bytcht_es8316.c
> @@ -282,7 +282,6 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "snd_soc_register_card failed %d\n", ret);
>   		return ret;
>   	}
> -	platform_set_drvdata(pdev, &byt_cht_es8316_card);
>   	return ret;
>   }
>   
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index 4a3516b..77702aa 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -310,7 +310,6 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
>   			ret_val);
>   		return ret_val;
>   	}
> -	platform_set_drvdata(pdev, &byt_rt5651_card);
>   	return ret_val;
>   }
>   
> diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> index 20755ec..8583c0c 100644
> --- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> +++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
> @@ -300,7 +300,6 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
>   			"snd_soc_register_card failed %d\n", ret_val);
>   		return ret_val;
>   	}
> -	platform_set_drvdata(pdev, &snd_soc_card_cht);
>   	return ret_val;
>   }
>   
> diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
> index 5bcde01..0e6a24c 100644
> --- a/sound/soc/intel/boards/cht_bsw_rt5645.c
> +++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
> @@ -699,7 +699,6 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
>   			"snd_soc_register_card failed %d\n", ret_val);
>   		return ret_val;
>   	}
> -	platform_set_drvdata(pdev, card);
>   	return ret_val;
>   }
>   
> diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
> index bc2a52d..e8bd22b 100644
> --- a/sound/soc/intel/boards/cht_bsw_rt5672.c
> +++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
> @@ -448,7 +448,6 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
>   			"snd_soc_register_card failed %d\n", ret_val);
>   		return ret_val;
>   	}
> -	platform_set_drvdata(pdev, &snd_soc_card_cht);
>   	return ret_val;
>   }
>   
