From: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH v3 1/6] ASoC: fsl_ssi: Real hardware
 channels max number is 32
Date: Mon, 18 Jan 2016 16:56:00 +0100
Message-ID: <569D0B10.8090809@invoxia.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1453130771-24419-2-git-send-email-arnaud.mouiche@invoxia.com>
 <569D08BF.7000008@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id C14DA260534
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 16:56:02 +0100 (CET)
Received: by mail-wm0-f49.google.com with SMTP id 123so57857933wmz.0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 07:56:02 -0800 (PST)
In-Reply-To: <569D08BF.7000008@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org



Le 18/01/2016 16:46, Timur Tabi a =E9crit :
> Arnaud Mouiche wrote:
>> The max number of slots in TDM mode is 32:
>> - Frame Rate Divider Control is a 5bit value
>> - Time slot mask registers control 32 slots.
>>
>> Signed-off-by: Arnaud Mouiche<arnaud.mouiche@invoxia.com>
>> ---
>>   sound/soc/fsl/fsl_ssi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
>> index 40dfd8a..cfc78b8 100644
>> --- a/sound/soc/fsl/fsl_ssi.c
>> +++ b/sound/soc/fsl/fsl_ssi.c
>> @@ -1167,14 +1167,14 @@ static struct snd_soc_dai_driver =

>> fsl_ssi_dai_template =3D {
>>       .playback =3D {
>>           .stream_name =3D "CPU-Playback",
>>           .channels_min =3D 1,
>> -        .channels_max =3D 2,
>> +        .channels_max =3D 32,
>
> TDM mode is not normally used.  What happens if we're not in TDM mode, =

> and the user tries to start a stream with more than 2 channels?
For the user point of view, the maximum of available channels (like =

available through aplay command) is the intersection of the CPU and =

Codec DAIs.
So the max will still be the max provided by the whole hardware.

In other words, if the SSI is connected to a simple 2 channels codec, =

"aplay -c 4" will still failed.
But if you build a multi-codec hardware, it will work.

Arnaud
