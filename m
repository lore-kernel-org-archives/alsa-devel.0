From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/16] ASoC: cs4270: Remove redundant OOM
 message
Date: Fri, 20 Jun 2014 13:07:39 +0200
Message-ID: <53A415FB.3060107@metafoo.de>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
 <53A4152C.2050702@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-006.synserver.de (smtp-out-013.synserver.de
 [212.40.185.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 90FA0261A68
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 13:07:39 +0200 (CEST)
In-Reply-To: <53A4152C.2050702@st.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "spk.linux@gmail.com" <spk.linux@gmail.com>, Sachin Kamat <sachin.kamat@samsung.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/20/2014 01:04 PM, Rajeev kumar wrote:
> On 6/20/2014 3:28 PM, Sachin Kamat wrote:
>> Let memory subsystem handle the error logging.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>> ---
>>   sound/soc/codecs/cs4270.c |    4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
>> index 9947a9583679..e6d4ff9fd992 100644
>> --- a/sound/soc/codecs/cs4270.c
>> +++ b/sound/soc/codecs/cs4270.c
>> @@ -664,10 +664,8 @@ static int cs4270_i2c_probe(struct i2c_client
>> *i2c_client,
>>
>>       cs4270 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs4270_private),
>>                     GFP_KERNEL);
>> -    if (!cs4270) {
>> -        dev_err(&i2c_client->dev, "could not allocate codec\n");
>
> You are just removing a information which are required in error condition.
> In my view it should be here..

devm_kzalloc already prints a error message when the allocation fails.
