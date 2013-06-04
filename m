From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Tue, 04 Jun 2013 16:05:32 -0600
Message-ID: <51AE64AC.7070903@wwwdotorg.org>
References: <1369983899-13580-1-git-send-email-bardliao@realtek.com>
 <51AE6166.1020809@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 078CF2651AE
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 00:05:36 +0200 (CEST)
In-Reply-To: <51AE6166.1020809@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, lgirdwood@gmail.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 06/04/2013 03:51 PM, Stephen Warren wrote:
> On 05/31/2013 01:04 AM, bardliao@realtek.com wrote:
>> From: Bard Liao <bardliao@realtek.com>
>>
>> * Use regmap_range_cfg to replace index read/write function.
>> * Remove I2S3 related code since there is no I2S3 in ALC5640.
>> * Remove Voice DSP related code since there is no Voice DSP in ALC5640.
>> * Remove MICBIAS2 since there is no MICBIAS2 in ALC5640.
>> * Change DMIC1/2 CLK to DMIC1/2 Power since it is for enable/disable DMIC1/2
>> * Modify some texts for consistent coding style.
>> * Merge sto adc l/r mux since it shares the same control bits.
>> * Other minor changes.
> 
>> +static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {

>> +	SND_SOC_DAPM_MIXER("HPO MIX L", SND_SOC_NOPM, 0, 0,
>> +		rt5640_hpo_mix, ARRAY_SIZE(rt5640_hpo_mix)),
>> +	SND_SOC_DAPM_MIXER("HPO MIX R", SND_SOC_NOPM, 0, 0,
>> +		rt5640_hpo_mix, ARRAY_SIZE(rt5640_hpo_mix)),
> 
> In the version of the driver I posted, I had replaced this with a single
> "HPO MIX" DAPM_MIXER, because there is a single bit in HW that controls
> both the L and R channels. I think you should incorporate that same change.
> 
> That relies on commit 85762e7 "ASoC: dapm: Implement mixer control sharing".

Sorry, ignore that comment; what I had done earlier was to make both the
SND_SOC_DAPM_MIXER() invocations above use the same rt5640_hpo_mix
kcontrol, which is exactly what you have in your patch.

So, this part is fine. Sorry for the noise.

BTW, I tested on my HW, and I see that headphone output still works fine
with this version of the driver.

I didn't test speaker output though, but that didn't work with the
previous driver I sent either. Are you able to get that working? I also
didn't test any capture path.
