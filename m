From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm - Refactor widget IO functions
 in	preparation for platform widgets.
Date: Fri, 10 Jun 2011 15:44:30 +0100
Message-ID: <4DF22DCE.8040406@ti.com>
References: <1307643049-3819-1-git-send-email-lrg@ti.com>
	<s5h4o3x3mzl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F454103C94
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 16:44:40 +0200 (CEST)
In-Reply-To: <s5h4o3x3mzl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 10/06/11 13:11, Takashi Iwai wrote:
> At Thu, 9 Jun 2011 19:10:49 +0100,
> Liam Girdwood wrote:
>>
>> Currently widget IO is tightly coupled to the CODEC drivers. Future platform DSP
>> devices have mixer components that can alter power usage and hence require full
>> DAPM support.
>>
>> This provides a generic widget IO operation wrapper in preparation for
>> future patches that implement platform driver DAPM.
>>
>> Signed-off-by: Liam Girdwood <lrg@ti.com>
>> ---
>>  sound/soc/soc-dapm.c |   55 ++++++++++++++++++++++++++++++++++++++++++++-----
>>  1 files changed, 49 insertions(+), 6 deletions(-)
>>
>> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
>> index 34106bc..7b7af9f 100644
>> --- a/sound/soc/soc-dapm.c
>> +++ b/sound/soc/soc-dapm.c
>> @@ -124,6 +124,49 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
>>  	return kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
>>  }
>>  
>> +static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg)
>> +{
>> +	if (w->codec)
>> +		return snd_soc_read(w->codec, reg);
>> +	return 0;
>> +}
>> +
>> +static int soc_widget_write(struct snd_soc_dapm_widget *w,int reg, int val)
> 
> Missing space after comma.

Thanks, didn't see that.

> 
>> +{
>> +	if (w->codec)
>> +		return snd_soc_write(w->codec, reg, val);
>> +	return 0;
>> +}
>> +
>> +int soc_widget_update_bits(struct snd_soc_dapm_widget *w, unsigned short reg,
>> +				unsigned int mask, unsigned int value)
> 
> Do you want to expose this and soc_widget_test_bits()?
> Or just forgotten static?
> 

The original intention was that they may have been used by the ABE but this seems unlikely now.

I'll make them static for V2 and remove test_bits since it's not used.

Liam
