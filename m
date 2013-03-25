From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 08/14] ASoC: speaer_pcm: No need to use
	snd_dmaengine_pcm_set_data()
Date: Mon, 25 Mar 2013 09:22:39 +0100
Message-ID: <5150094F.9000503@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
 <1363957934-20059-9-git-send-email-lars@metafoo.de> <514FCBB7.4020900@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 84D8E261670
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 09:20:24 +0100 (CET)
In-Reply-To: <514FCBB7.4020900@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/25/2013 04:59 AM, Rajeev kumar wrote:
> Hello Lars,
> 
> On 3/22/2013 6:42 PM, Lars-Peter Clausen wrote:
>> The driver never uses snd_dmaengine_pcm_get_data(), so there is no
>> need to use
>> snd_dmaengine_pcm_set_data().
>>
>> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
>> Cc: Rajeev Kumar<rajeev-dlh.kumar@st.com>
>> ---
>>   sound/soc/spear/spear_pcm.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
>> index 903ac15..bfbcc1f 100644
>> --- a/sound/soc/spear/spear_pcm.c
>> +++ b/sound/soc/spear/spear_pcm.c
>> @@ -64,13 +64,7 @@ static int spear_pcm_open(struct snd_pcm_substream
>> *substream)
>>       if (ret)
>>           return ret;
>>
>> -    ret = snd_dmaengine_pcm_open(substream, dma_data->filter, dma_data);
>> -    if (ret)
>> -        return ret;
>> -
>> -    snd_dmaengine_pcm_set_data(substream, dma_data);
> 

Hi,

> The dma data is used to set dma parameters to transfer data and it will
> required by the dma engine.
> 

snd_dmaengine_pcm_set_data() sets private data for the dmaengine pcm, this data
can be retrieved later using snd_dmaengine_pcm_get_data(). The spear pcm driver
never uses snd_dmaengine_pcm_get_data(), so calling
snd_dmaengine_pcm_set_data() shouldn't be necessary.

- Lars
