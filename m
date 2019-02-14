From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH] ASoC: stm32: sai: add missing put_device()
Date: Thu, 14 Feb 2019 10:39:29 +0000
Message-ID: <c62d0064-93b4-7839-7042-47a15c78b909@st.com>
References: <HK0PR02MB36348FCAF73000463738C017B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
 <18decbe3-5a7c-1b75-4c64-0b16fdd0efec@st.com>
 <HK0PR02MB3634F3A1A0C8BF4EEC5C3874B2660@HK0PR02MB3634.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 53117267482
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 11:39:33 +0100 (CET)
In-Reply-To: <HK0PR02MB3634F3A1A0C8BF4EEC5C3874B2660@HK0PR02MB3634.apcprd02.prod.outlook.com>
Content-Language: en-US
Content-ID: <8C67A01B8471844D9B1833C9434BB5A4@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wen Yang <yellowriver2010@hotmail.com>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 TORGUE <alexandre.torgue@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Acked-by: Olivier Moysan <olivier.moysan@st.com>

On 2/13/19 3:41 PM, Wen Yang wrote:
> From: Olivier MOYSAN <olivier.moysan@st.com>
> Sent: 11 February 2019 15:09
> To: Wen Yang; Arnaud POULIQUEN; Liam Girdwood; Mark Brown; Jaroslav Kysela; Takashi Iwai; Maxime Coquelin; Alexandre TORGUE
> Cc: alsa-devel@alsa-project.org; linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ASoC: stm32: sai: add missing put_device()
> 
>> On 2/9/19 11:41 AM, Wen Yang wrote:
>>> The of_find_device_by_node() takes a reference to the underlying device
>>> structure, we should release that reference.
>>>
>>> Fixes: 7dd0d835582f ("ASoC: stm32: sai: simplify sync modes management")
>>> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
>>> ---
>>>    sound/soc/stm/stm32_sai.c | 11 ++++++++---
>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
>>> index bcb35ca..14c9591 100644
>>> --- a/sound/soc/stm/stm32_sai.c
>>> +++ b/sound/soc/stm/stm32_sai.c
>>> @@ -112,16 +112,21 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
>>
>> goto error also in previous test
>>        if (!pdev) {
>>                ...
>>                ret = -ENODEV;
>>                 goto error;
>>         }
>>
>>>        if (!sai_provider) {
>>>                dev_err(&sai_client->pdev->dev,
>>>                        "SAI sync provider data not found\n");
>>> -             return -EINVAL;
>>> +             ret = -EINVAL;
>>> +             goto out_put_dev;
>>>        }
>>>
>>>        /* Configure sync client */
>>>        ret = stm32_sai_sync_conf_client(sai_client, synci);
>>>        if (ret < 0)
>>> -             return ret;
>>> +             goto out_put_dev;
>>>
>>>        /* Configure sync provider */
>>> -     return stm32_sai_sync_conf_provider(sai_provider, synco);
>>> +     ret = stm32_sai_sync_conf_provider(sai_provider, synco);
>>> +
>>> +out_put_dev:
>>> +     put_device(&pdev->dev);
>>> +     return ret;
>>
>> Here I propose:
>> error:
>>         of_node_put(np_provider);
>>         return ret;
>>
>>>    }
>>>
>>>    static int stm32_sai_probe(struct platform_device *pdev)
>>>
> 
>> Thanks for your patch. Please, see my comments above.
> 
> Thanks for your comments, in this patch we only fix the problem of missing put_device().
> The problem of missing of_node_put() is a bit more complicated:
> For the variable np_provider(np_sync_provider):
> 1, it is obtained by of_get_parent(), but it is not released;
> 2, error code not obtained when calling sai->pdata->set_sync()
> 

I agree, release of np_sync_provider node is missing, as well as
returned error on set_sync.
So yes, this requires a dedicated patch.
Thanks

Regards
Olivier

> We will submit another patch to fix the failure of np_sync_provider
> Thank you.
> > Regards
> Wen
> 
> 
