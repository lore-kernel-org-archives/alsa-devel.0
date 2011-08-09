From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: sdp4430: Fix string for FM input name
Date: Tue, 9 Aug 2011 13:47:15 +0100
Message-ID: <4E412C53.6050507@ti.com>
References: <1309976285-25319-1-git-send-email-peter.ujfalusi@ti.com>
	<3256303.St6Oti5sp6@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 99F5F2458A
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 14:47:18 +0200 (CEST)
In-Reply-To: <3256303.St6Oti5sp6@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Lopez Cruz,
	Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/08/11 08:29, Ujfalusi, Peter wrote:
> Hi Mark, Liam,
> 
> On Wednesday 06 July 2011 20:18:05 Ujfalusi, Peter wrote:
>> The name contains invalid valid character (/), which
>> causes problems when trying to create the debugfs
>> directory structure:
>> ASoC: Failed to create Aux/FM Stereo In debugfs file
> 
> Can you take a look at this patch?
> I think this shall go for 3.1 as a fix.
> 

I'll pull this with your others once Mark gets a chance to have a look.

> Thanks,
> Peter
> 
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  sound/soc/omap/sdp4430.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
>> index a951774..d462f1a 100644
>> --- a/sound/soc/omap/sdp4430.c
>> +++ b/sound/soc/omap/sdp4430.c
>> @@ -88,7 +88,7 @@ static const struct snd_soc_dapm_widget
>> sdp4430_twl6040_dapm_widgets[] = { SND_SOC_DAPM_MIC("Headset Mic", NULL),
>>  	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
>>  	SND_SOC_DAPM_SPK("Earphone Spk", NULL),
>> -	SND_SOC_DAPM_INPUT("Aux/FM Stereo In"),
>> +	SND_SOC_DAPM_INPUT("FM Stereo In"),
>>  };
>>
>>  static const struct snd_soc_dapm_route audio_map[] = {
>> @@ -113,8 +113,8 @@ static const struct snd_soc_dapm_route audio_map[] = {
>>  	{"Earphone Spk", NULL, "EP"},
>>
>>  	/* Aux/FM Stereo In: AFML, AFMR */
>> -	{"AFML", NULL, "Aux/FM Stereo In"},
>> -	{"AFMR", NULL, "Aux/FM Stereo In"},
>> +	{"AFML", NULL, "FM Stereo In"},
>> +	{"AFMR", NULL, "FM Stereo In"},
>>  };
>>
>>  static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
