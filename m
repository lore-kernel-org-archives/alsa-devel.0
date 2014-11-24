From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: bt-sco: support wide band speech
Date: Mon, 24 Nov 2014 14:36:02 +0100
Message-ID: <54733442.6020409@metafoo.de>
References: <1416832172-4875-1-git-send-email-21cnbao@gmail.com>
 <54732875.5070605@metafoo.de>
 <CAGsJ_4wTHDGBW19PHSyyeOx-9HYJsXojTUWk3ub_eESLgEXmog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-176.synserver.de (smtp-out-179.synserver.de
 [212.40.185.179])
 by alsa0.perex.cz (Postfix) with ESMTP id C81942650C3
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 14:36:01 +0100 (CET)
In-Reply-To: <CAGsJ_4wTHDGBW19PHSyyeOx-9HYJsXojTUWk3ub_eESLgEXmog@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Yibo Cai <yibo.cai@csr.com>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Mark Brown <broonie@kernel.org>, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

On 11/24/2014 01:58 PM, Barry Song wrote:
> 2014-11-24 20:45 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:
>> On 11/24/2014 01:29 PM, Barry Song wrote:
>>>
>>> From: Yibo Cai <yibo.cai@csr.com>
>>>
>>> HFP1.6 requires support for wide band speech(16KHz) over Bluetooth.
>>>
>>> Signed-off-by: Yibo Cai <yibo.cai@csr.com>
>>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>> ---
>>>    sound/soc/codecs/bt-sco.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
>>> index c4cf069..fc0664b 100644
>>> --- a/sound/soc/codecs/bt-sco.c
>>> +++ b/sound/soc/codecs/bt-sco.c
>>> @@ -31,14 +31,14 @@ static struct snd_soc_dai_driver bt_sco_dai = {
>>>                  .stream_name = "Playback",
>>>                  .channels_min = 1,
>>>                  .channels_max = 1,
>>> -               .rates = SNDRV_PCM_RATE_8000,
>>> +               .rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
>>
>>
>> This will break those bluetooth modules that only work with 8k.
>
> how do you think if we use device-tree "compatible" to differentiate
> these two kinds of BT modules?
> for non-DT platform, platform_device_id?

Yes, I think that's what we need to do.

- Lars
