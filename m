From: Sergej Sawazki <sergej@taudac.com>
Subject: Re: [PATCH v2] ASoC: wm8741: Add digital mute callback
Date: Tue, 31 Oct 2017 10:36:26 +0100
Message-ID: <9fd5fafe-0d07-75e2-a868-a349bd094a7c@taudac.com>
References: <1509352096-5491-1-git-send-email-sergej@taudac.com>
 <20171030154110.5vl2ajatnsr5c4sm@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id D54BD266A0C
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 10:36:28 +0100 (CET)
In-Reply-To: <20171030154110.5vl2ajatnsr5c4sm@localhost.localdomain>
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
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, ckeepax@opensource.wolfsonmicro.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 30.10.2017 um 16:41 schrieb Charles Keepax:
> On Mon, Oct 30, 2017 at 09:28:16AM +0100, Sergej Sawazki wrote:
>> Signed-off-by: Sergej Sawazki <sergej@taudac.com>
>> ---
>> Changes in v2:
>>   * Refactored debug message.
>>
>>   sound/soc/codecs/wm8741.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
>> index b8c1940..5571882 100644
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
>> +	dev_dbg(codec->dev, "wm8741_mute:    mute = %d\n", mute);
> 
> It is still not really normal style to include the function name
> in the debug messages. How about just "digital mute = %d\n" or
> something like that?
> 

Maybe not really normal, but CONSISTENT. That's the style used
throughout the entire file. And it makes the log look consistent.
