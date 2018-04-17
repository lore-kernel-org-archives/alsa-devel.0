From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: amd: enabling bt i2s config after
 acp reset
Date: Tue, 17 Apr 2018 17:11:05 +0530
Message-ID: <3c3e76fe-4b70-3cb2-5658-f9616b168219@amd.com>
References: <1523941201-15665-5-git-send-email-Vijendar.Mukunda@amd.com>
 <201804171833.Rbn5FNLY%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201804171833.Rbn5FNLY%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Takashi Iwai <tiwai@suse.com>, Jason Clinton <jclinton@chromium.org>, Mark Brown <broonie@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Dylan Reid <dgreid@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org



On Tuesday 17 April 2018 04:47 PM, kbuild test robot wrote:
> Hi Vijendar,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on sound/for-next]
> [also build test ERROR on v4.17-rc1 next-20180417]
> [cannot apply to asoc/for-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Vijendar-Mukunda/ASoC-dwc-I2S-Controller-instance-param-added/20180417-175408
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
> config: i386-randconfig-x015-201815 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
> 
> All errors (new ones prefixed by >>):
> 
>     sound/soc/amd/acp-da7219-max98357a.c: In function 'cz_da7219_init':
>>> sound/soc/amd/acp-da7219-max98357a.c:85:45: error: 'pdev' undeclared (first use in this function); did you mean 'cdev'?
>       bt_pad_enable = device_property_read_bool(&pdev->dev, "bt-pad-enable");
>                                                  ^~~~
>                                                  cdev
>     sound/soc/amd/acp-da7219-max98357a.c:85:45: note: each undeclared identifier is reported only once for each function it appears in
> 
> vim +85 sound/soc/amd/acp-da7219-max98357a.c
> 
>      48	
>      49	static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
>      50	{
>      51		int ret;
>      52		struct snd_soc_card *card = rtd->card;
>      53		struct snd_soc_dai *codec_dai = rtd->codec_dai;
>      54		struct snd_soc_component *component = codec_dai->component;
>      55	
>      56		dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
>      57	
>      58		ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK,
>      59					     CZ_PLAT_CLK, SND_SOC_CLOCK_IN);
>      60		if (ret < 0) {
>      61			dev_err(rtd->dev, "can't set codec sysclk: %d\n", ret);
>      62			return ret;
>      63		}
>      64	
>      65		ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
>      66					  CZ_PLAT_CLK, MCLK_RATE);
>      67		if (ret < 0) {
>      68			dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
>      69			return ret;
>      70		}
>      71	
>      72		da7219_dai_clk = clk_get(component->dev, "da7219-dai-clks");
>      73	
>      74		ret = snd_soc_card_jack_new(card, "Headset Jack",
>      75					SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
>      76					SND_JACK_BTN_0 | SND_JACK_BTN_1 |
>      77					SND_JACK_BTN_2 | SND_JACK_BTN_3,
>      78					&cz_jack, NULL, 0);
>      79		if (ret) {
>      80			dev_err(card->dev, "HP jack creation failed %d\n", ret);
>      81			return ret;
>      82		}
>      83	
>      84		da7219_aad_jack_det(component, &cz_jack);
>    > 85		bt_pad_enable = device_property_read_bool(&pdev->dev, "bt-pad-enable");
>      86	
>      87		return 0;
>      88	}
>      89	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

I will fix it and post the patch as V2 version.
