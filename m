From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH] ASoC: snappercl15: Convert to table based
	DAPM setup
Date: Tue, 04 Mar 2014 08:43:12 +1100
Message-ID: <5314F770.10906@gmail.com>
References: <1393830635-17279-1-git-send-email-lars@metafoo.de>
 <53142B9E.1050909@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 69AB626569E
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 22:43:39 +0100 (CET)
Received: by mail-pb0-f50.google.com with SMTP id md12so4295775pbc.9
 for <alsa-devel@alsa-project.org>; Mon, 03 Mar 2014 13:43:37 -0800 (PST)
In-Reply-To: <53142B9E.1050909@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/03/14 18:13, Lars-Peter Clausen wrote:
> Cc: Ryan's new e-mail address
> 
> On 03/03/2014 08:10 AM, Lars-Peter Clausen wrote:
>> Use table based setup to register the DAPM widgets and routes.  This
>> on one hand
>> makes the code a bit shorter and cleaner and on the other hand the
>> board level
>> DAPM elements get registered in the card's DAPM context rather than in
>> the
>> CODEC's DAPM context.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>   sound/soc/cirrus/snappercl15.c | 18 +++++-------------
>>   1 file changed, 5 insertions(+), 13 deletions(-)
>>
>> diff --git a/sound/soc/cirrus/snappercl15.c
>> b/sound/soc/cirrus/snappercl15.c
>> index 29238a7..bdc88e5 100644
>> --- a/sound/soc/cirrus/snappercl15.c
>> +++ b/sound/soc/cirrus/snappercl15.c
>> @@ -65,18 +65,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
>>       {"MICIN", NULL, "Mic Jack"},
>>   };
>>
>> -static int snappercl15_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
>> -{
>> -    struct snd_soc_codec *codec = rtd->codec;
>> -    struct snd_soc_dapm_context *dapm = &codec->dapm;
>> -
>> -    snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
>> -                  ARRAY_SIZE(tlv320aic23_dapm_widgets));
>> -
>> -    snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
>> -    return 0;
>> -}
>> -
>>   static struct snd_soc_dai_link snappercl15_dai = {
>>       .name        = "tlv320aic23",
>>       .stream_name    = "AIC23",
>> @@ -84,7 +72,6 @@ static struct snd_soc_dai_link snappercl15_dai = {
>>       .codec_dai_name    = "tlv320aic23-hifi",
>>       .codec_name    = "tlv320aic23-codec.0-001a",
>>       .platform_name    = "ep93xx-i2s",
>> -    .init        = snappercl15_tlv320aic23_init,
>>       .dai_fmt    = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
>>                 SND_SOC_DAIFMT_CBS_CFS,
>>       .ops        = &snappercl15_ops,
>> @@ -95,6 +82,11 @@ static struct snd_soc_card snd_soc_snappercl15 = {
>>       .owner        = THIS_MODULE,
>>       .dai_link    = &snappercl15_dai,
>>       .num_links    = 1,
>> +
>> +    .dapm_widgets = tlv320aic23_dapm_widgets,
>> +    .num_dapm_widgets = ARRAY_SIZE(tlv320aic23_dapm_widgets),
>> +    .dapm_routes = audio_map,
>> +    .num_dapm_routes = ARRAY_SIZE(audio_map),

One really minor nit. The rest of this file has tab aligned structure
initialisers. Can we keep this consistent please.

~Ryan
