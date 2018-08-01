From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v4 4/4] ASoC: qcom: add sdm845 sound card support
Date: Wed, 1 Aug 2018 12:02:11 +0530
Message-ID: <f0f0554c-b2e4-783d-df1e-335ab8d81c11@codeaurora.org>
References: <1532945454-10437-5-git-send-email-rohitkr@codeaurora.org>
 <201808011127.1snVqYkN%fengguang.wu@intel.com> <s5hy3dqzo51.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy3dqzo51.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, bgoswami@codeaurora.org, plai@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, srinivas.kandagatla@linaro.org, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 8/1/2018 10:20 AM, Takashi Iwai wrote:
> On Wed, 01 Aug 2018 05:46:48 +0200,
> kbuild test robot wrote:
>> Hi Rohit,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on asoc/for-next]
>> [also build test WARNING on next-20180731]
>> [cannot apply to v4.18-rc7]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Rohit-kumar/Add-support-for-audio-on-SDM845-SoC/20180801-082203
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
>> reproduce:
>>          # apt-get install sparse
>>          make ARCH=x86_64 allmodconfig
>>          make C=1 CF=-D__CHECK_ENDIAN__
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>>> sound/soc/qcom/sdm845.c:193:27: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [unsigned] val @@    got restricted snd_unsigned int [unsigned] val @@
>>     sound/soc/qcom/sdm845.c:193:27:    expected unsigned int [unsigned] val
>>     sound/soc/qcom/sdm845.c:193:27:    got restricted snd_pcm_format_t [usertype] <noident>
>>
>> vim +193 sound/soc/qcom/sdm845.c
>>
>>     181	
>>     182	static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
>>     183					struct snd_pcm_hw_params *params)
>>     184	{
>>     185		struct snd_interval *rate = hw_param_interval(params,
>>     186						SNDRV_PCM_HW_PARAM_RATE);
>>     187		struct snd_interval *channels = hw_param_interval(params,
>>     188						SNDRV_PCM_HW_PARAM_CHANNELS);
>>     189		struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
>>     190	
>>     191		rate->min = rate->max = DEFAULT_SAMPLE_RATE_48K;
>>     192		channels->min = channels->max = 2;
>>   > 193		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S16_LE);
> FYI, we have introduced a new helper, snd_mask_set_format(), just for
> avoiding this sparse warning.  It's already in Mark's for-next tree.
Thanks Takashi for API suggestion. I will update in next spin.
>
> thanks,
>
> Takashi
