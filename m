From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH] sound: codecs: fix a potential NULL pointer dereference
Date: Mon, 25 Mar 2019 12:24:18 +0530
Message-ID: <ddedc6d6-823a-44ea-e02b-b83fa80a4483@codeaurora.org>
References: <20190324231237.2246-1-kjlu@umn.edu>
 <4fa0e2cb-7044-12e1-33b3-14015c94e48d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4fa0e2cb-7044-12e1-33b3-14015c94e48d@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Kangjje/Aditya,

Please do take care of the return value you are sending upstream whether 
still is checked or not
otherwise NULL pointer dereference will still come.
Also resource release properly otherwise your patch may looks simple but 
it can introduce memory leak as well in other path.


Thanks,
Mukesh

On 3/25/2019 12:15 PM, Mukesh Ojha wrote:
>
> On 3/25/2019 4:42 AM, Kangjie Lu wrote:
>> In case devm_kzalloc fails, the patch returns -ENOMEM to avoid
>> potential NULL pointer dereference.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>>   sound/soc/codecs/rt5663.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
>> index da6647015708..909ab99a1995 100644
>> --- a/sound/soc/codecs/rt5663.c
>> +++ b/sound/soc/codecs/rt5663.c
>> @@ -3480,6 +3480,8 @@ static int rt5663_parse_dp(struct rt5663_priv 
>> *rt5663, struct device *dev)
>>           table_size = sizeof(struct impedance_mapping_table) *
>>               rt5663->pdata.impedance_sensing_num;
>>           rt5663->imp_table = devm_kzalloc(dev, table_size, GFP_KERNEL);
>> +        if (!rt5663->imp_table)
>> +            return -ENOMEM;
>
> add checks in rt5663_parse_dp  as well.
>
> Thanks.
> Mukesh
>
>
>> device_property_read_u32_array(dev,
>>               "realtek,impedance_sensing_table",
>>               (u32 *)rt5663->imp_table, table_size);
