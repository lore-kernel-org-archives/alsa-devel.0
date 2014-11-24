From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] ASoC: bt-sco: support wide band speech
Date: Mon, 24 Nov 2014 20:58:37 +0800
Message-ID: <CAGsJ_4wTHDGBW19PHSyyeOx-9HYJsXojTUWk3ub_eESLgEXmog@mail.gmail.com>
References: <1416832172-4875-1-git-send-email-21cnbao@gmail.com>
 <54732875.5070605@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 14660260548
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 13:58:59 +0100 (CET)
Received: by mail-pa0-f47.google.com with SMTP id kq14so9496615pab.20
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 04:58:58 -0800 (PST)
In-Reply-To: <54732875.5070605@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Yibo Cai <yibo.cai@csr.com>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Mark Brown <broonie@kernel.org>, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

2014-11-24 20:45 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 11/24/2014 01:29 PM, Barry Song wrote:
>>
>> From: Yibo Cai <yibo.cai@csr.com>
>>
>> HFP1.6 requires support for wide band speech(16KHz) over Bluetooth.
>>
>> Signed-off-by: Yibo Cai <yibo.cai@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>   sound/soc/codecs/bt-sco.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
>> index c4cf069..fc0664b 100644
>> --- a/sound/soc/codecs/bt-sco.c
>> +++ b/sound/soc/codecs/bt-sco.c
>> @@ -31,14 +31,14 @@ static struct snd_soc_dai_driver bt_sco_dai = {
>>                 .stream_name = "Playback",
>>                 .channels_min = 1,
>>                 .channels_max = 1,
>> -               .rates = SNDRV_PCM_RATE_8000,
>> +               .rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
>
>
> This will break those bluetooth modules that only work with 8k.

how do you think if we use device-tree "compatible" to differentiate
these two kinds of BT modules?
for non-DT platform, platform_device_id?

>
> - Lars

-barry
