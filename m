From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 9/9] ALSA: intel_hdmi: remove redundant
 variable cfg_val
Date: Wed, 1 Aug 2018 07:55:02 -0700
Message-ID: <105efe0e-237e-dba0-3bfe-0f88b9ccd152@linux.intel.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
 <20180801104742.4328-10-colin.king@canonical.com>
 <s5hin4unyh0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hin4unyh0.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, kernel-janitors@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Colin King <colin.king@canonical.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaya Kumar <jayakumar.alsa@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 8/1/18 4:00 AM, Takashi Iwai wrote:
> On Wed, 01 Aug 2018 12:47:42 +0200,
> Colin King wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Variable cfg_val is being assigned but is never used hence it is
>> redundant and can be removed.
>>
>> Cleans up clang warning:
>> warning: variable 'cfg_val' set but not used [-Wunused-but-set-variable]
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   sound/x86/intel_hdmi_audio.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
>> index edc9f5a34eff..fa7dca5a68c8 100644
>> --- a/sound/x86/intel_hdmi_audio.c
>> +++ b/sound/x86/intel_hdmi_audio.c
>> @@ -290,7 +290,6 @@ static void had_reset_audio(struct snd_intelhad *intelhaddata)
>>   static int had_prog_status_reg(struct snd_pcm_substream *substream,
>>   			struct snd_intelhad *intelhaddata)
>>   {
>> -	union aud_cfg cfg_val = {.regval = 0};
>>   	union aud_ch_status_0 ch_stat0 = {.regval = 0};
>>   	union aud_ch_status_1 ch_stat1 = {.regval = 0};
>>   
>> @@ -298,7 +297,6 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
>>   					  IEC958_AES0_NONAUDIO) >> 1;
>>   	ch_stat0.regx.clk_acc = (intelhaddata->aes_bits &
>>   					  IEC958_AES3_CON_CLOCK) >> 4;
>> -	cfg_val.regx.val_bit = ch_stat0.regx.lpcm_id;
> 
> Actually this made me wonder what is the definition of val_bit.
> It seems always 1 in the current code after the commit 964ca8083c02.
> Pierre?

I'll look into it, give me a couple of days. I vaguely remember this is 
the AES validity bit but I am not sure why it's set with a pcm id, looks 
like a mixup.
