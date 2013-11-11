From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH 1/3] speaker-test: Fix chmapped channel
 selection without specified chmap
Date: Mon, 11 Nov 2013 22:23:48 +0200
Message-ID: <52813CD4.30600@iki.fi>
References: <527F34D3.40209@iki.fi>	<1384108159-3421-1-git-send-email-anssi.hannula@iki.fi>
 <s5hob5rq6dz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id E45832610AA
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2013 21:23:54 +0100 (CET)
In-Reply-To: <s5hob5rq6dz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Olivier Langlois <olivier@trillion01.com>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Peter_Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

11.11.2013 17:56, Takashi Iwai kirjoitti:
> At Sun, 10 Nov 2013 20:29:17 +0200,
> Anssi Hannula wrote:
>>
>> The channel selection currently does not work properly when there is a
>> driver-provided non-ALSA-traditional channel map but no manual channel
>> map was explicitely requested with "-m".
>>
>> For example, the CEA/HDMI 8ch map is FL,FR,RLC,RRC,FC,LFE,RL,RR. Note
>> that it is otherwise the same as the traditional ALSA channel map,
>> except that the traditional rear speakers are considered
>> rear-center speakers and the traditional side speakers are considered
>> rear speakers.
>>
>> Speaker-test tries to play back channels in this following order:
>>   0, /* Front Left  */
>>   4, /* Center      */
>>   1, /* Front Right */
>>   7, /* Side Right  */
>>   3, /* Rear Right  */
>>   2, /* Rear Left   */
>>   6, /* Side Left   */
>>   5, /* LFE         */
>>
>> When it is the time to play back Side Left/Right, speaker-test tries to
>> look for SL/SR in the chmap, but doesn't find it, so it just plays back
>> channels 6/7 (which indeed are the side speakers, or RL/RR in this
>> channel map - so the correct channels are selected).
>>
>> When it becomes the time to playback Rear Left/Right, speaker-test again
>> tries to find RL/RR in the chmap, and this time it does find them in the
>> chmap positions 6/7.
>>
>> So the channels 6/7 are tested twice and 2/3 are never tested.
>>
>> To fix this, define a generic playback order to be used when a channel
>> map is present and assign the speaker numbers (i.e. playback order) in
>> the following order:
>> 1. channels in map found in map_order[] in the map_order[] order,
>> 2. channels in map not found in map_order[] in map order,
>> 3. channels outside the map.
> 
> You are referring to the teaching of Zen, aren't you...? ;)

Heh, I only realized afterwards how confusing that map order stuff sounds :p

> I prefer something a bit more easier to understand.
> For example, how about to sort the given channels once using a weight
> table?

OK, I'll try something like that.

> thanks,
> 
> Takashi
> 
>> When the channel mapping is specified manually, the specified order is
>> used for playback as before.
>>
>> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
>> ---
>>  speaker-test/speaker-test.c | 86 +++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 67 insertions(+), 19 deletions(-)
>>
>> diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
>> index d35065f..274007d 100644
>> --- a/speaker-test/speaker-test.c
>> +++ b/speaker-test/speaker-test.c
>> @@ -88,6 +88,8 @@ enum {
>>  #define BE_INT(v)		(v)
>>  #endif
>>  
>> +#define ARRAY_SIZE(x) (int)(sizeof(x)/sizeof(x[0]))
>> +
>>  static char              *device      = "default";       /* playback device */
>>  static snd_pcm_format_t   format      = SND_PCM_FORMAT_S16; /* sample format */
>>  static unsigned int       rate        = 48000;	            /* stream rate */
>> @@ -156,36 +158,82 @@ static const int	channels8[] = {
>>    5, /* LFE         */
>>  };
>>  
>> +#ifdef CONFIG_SUPPORT_CHMAP
>> +/* generic version of the above channelsX[] */
>> +static const int map_order[] = {
>> +  SND_CHMAP_FLW,
>> +  SND_CHMAP_FL,
>> +  SND_CHMAP_TFL,
>> +  SND_CHMAP_FLC,
>> +  SND_CHMAP_TFLC,
>> +  SND_CHMAP_FC,
>> +  SND_CHMAP_TFC,
>> +  SND_CHMAP_FRC,
>> +  SND_CHMAP_TFRC,
>> +  SND_CHMAP_FR,
>> +  SND_CHMAP_TFR,
>> +  SND_CHMAP_FRW,
>> +  SND_CHMAP_SR,
>> +  SND_CHMAP_TSR,
>> +  SND_CHMAP_RR,
>> +  SND_CHMAP_TRR,
>> +  SND_CHMAP_RRC,
>> +  SND_CHMAP_RC,
>> +  SND_CHMAP_TRC,
>> +  SND_CHMAP_RLC,
>> +  SND_CHMAP_RL,
>> +  SND_CHMAP_TRL,
>> +  SND_CHMAP_SL,
>> +  SND_CHMAP_TSL,
>> +  SND_CHMAP_BC,
>> +  SND_CHMAP_TC,
>> +  SND_CHMAP_LLFE,
>> +  SND_CHMAP_LFE,
>> +  SND_CHMAP_RLFE,
>> +};
>> +
>>  static int get_mapped_channel(int chn)
>>  {
>> -#ifdef CONFIG_SUPPORT_CHMAP
>> -  static const int maps[MAX_CHANNELS] = {
>> -    SND_CHMAP_FL,
>> -    SND_CHMAP_FR,
>> -    SND_CHMAP_RL,
>> -    SND_CHMAP_RR,
>> -    SND_CHMAP_FC,
>> -    SND_CHMAP_LFE,
>> -    SND_CHMAP_SL,
>> -    SND_CHMAP_SR,
>> -  };
>> +  int found_count = 0;
>> +  int i, j;
>> +
>> +  if (chn >= channel_map->channels)
>> +    return chn; /* out of map */
>>  
>> -  if (channel_map && maps[chn]) {
>> -    int i;
>> -    for (i = 0; i < channel_map->channels; i++) {
>> -      if (channel_map->pos[i] == maps[chn])
>> -	return i;
>> +  for (i = 0; i < ARRAY_SIZE(map_order) && found_count <= chn; i++) {
>> +    for (j = 0; j < channel_map->channels; j++) {
>> +      if (channel_map->pos[j] == map_order[i]) {
>> +        found_count++;
>> +	break;
>> +      }
>>      }
>>    }
>> -#endif
>> -  return chn;
>> +
>> +  if (found_count == chn + 1)
>> +    return j;
>> +
>> +  /* chn is bigger than the amount of present map_order[] channels, find
>> +   * the non-map_order[] channels */
>> +  for (j = 0; j < channel_map->channels && found_count <= chn; j++) {
>> +    for (i = 0; i < ARRAY_SIZE(map_order); i++) {
>> +      if (channel_map->pos[j] == map_order[i])
>> +        break;
>> +    }
>> +    if (i == ARRAY_SIZE(map_order))
>> +      found_count++;
>> +  }
>> +
>> +  return j - 1;
>>  }
>> +#endif
>>  
>>  static int get_speaker_channel(int chn)
>>  {
>>  #ifdef CONFIG_SUPPORT_CHMAP
>>    if (channel_map_set)
>>      return chn;
>> +  if (channel_map)
>> +    return get_mapped_channel(chn);
>>  #endif
>>  
>>    switch (channels) {
>> @@ -200,7 +248,7 @@ static int get_speaker_channel(int chn)
>>      break;
>>    }
>>  
>> -  return get_mapped_channel(chn);
>> +  return chn;
>>  }
>>  
>>  static const char *get_channel_name(int chn)
>> -- 
>> 1.8.1.5
>>


-- 
Anssi Hannula
