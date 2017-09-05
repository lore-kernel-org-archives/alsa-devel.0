From: Sergej Sawazki <sergej@taudac.com>
Subject: Re: [PATCH 1/3] ASoC: wm8741: Add digital mute callback
Date: Tue, 5 Sep 2017 20:15:05 +0200
Message-ID: <2fae023a-25cc-01cf-2972-312dd7f48e43@taudac.com>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
 <1504553653-8144-2-git-send-email-sergej@taudac.com>
 <20170905133351.tfqsa6s33aeigfxy@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id 88593266C6D
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 20:15:07 +0200 (CEST)
In-Reply-To: <20170905133351.tfqsa6s33aeigfxy@localhost.localdomain>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Thanks Charles,

agreed about the __func__. But, I would like to keep the debug message, 
in order to be consistent with the other callbacks. They all print debug 
messages.

Would it be ok for you?

Regards,
Sergej

Am 05.09.2017 um 15:33 schrieb Charles Keepax:
> On Mon, Sep 04, 2017 at 09:34:11PM +0200, Sergej Sawazki wrote:
>> Signed-off-by: Sergej Sawazki <sergej@taudac.com>
>> ---
>>   sound/soc/codecs/wm8741.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
>> index b8c1940..d552a8a 100644
>> --- a/sound/soc/codecs/wm8741.c
>> +++ b/sound/soc/codecs/wm8741.c
>> @@ -351,6 +351,17 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
>>   	return 0;
>>   }
>>   
>> +int wm8741_mute(struct snd_soc_dai *codec_dai, int mute)
>> +{
>> +	struct snd_soc_codec *codec = codec_dai->codec;
>> +
>> +	dev_dbg(codec->dev, "%s:    mute = %d\n", __func__, mute);
> 
> Its not really normal style to use __func__ in this sort of
> print, just make it descriptive of what it does. Although I would
> also say you could just drop it as well if you fancied it is a
> little verbose even for debug output.
> 
> Otherwise this patch looks ok to me.
> 
> Thanks,
> Charles
> 
