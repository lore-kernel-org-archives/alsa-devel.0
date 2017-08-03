From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 4/6] ASoC: codecs: msm8916-wcd-analog:
	add MBHC support
Date: Thu, 3 Aug 2017 14:10:18 +0100
Message-ID: <6fd8f95f-6378-c6bf-acd7-a4e0a9d1cc5e@linaro.org>
References: <20170802170930.26083-1-srinivas.kandagatla@linaro.org>
 <20170802170930.26083-5-srinivas.kandagatla@linaro.org>
 <20170802233323.blx36uutaytdexvb@workotop.localdomain>
 <56b54da2-0e87-a466-6184-ffbd85f631c4@linaro.org>
 <20170803125355.l5m5mk5utl4nlbwk@workotop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DBB3266847
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 15:10:20 +0200 (CEST)
Received: by mail-wm0-f45.google.com with SMTP id t201so14894300wmt.1
 for <alsa-devel@alsa-project.org>; Thu, 03 Aug 2017 06:10:20 -0700 (PDT)
In-Reply-To: <20170803125355.l5m5mk5utl4nlbwk@workotop.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 03/08/17 13:53, Damien Riegel wrote:
> On Thu, Aug 03, 2017 at 12:11:04PM +0100, Srinivas Kandagatla wrote:
>>
>>
>> On 03/08/17 00:33, Damien Riegel wrote:
>>> Hi Srinivas,
>>>
>>>
>>> On Wed, Aug 02, 2017 at 07:09:28PM +0200, srinivas.kandagatla@linaro.org wrote:
>>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>
>>>> MBHC (MultiButton Headset Control) support is available in pm8921 in two
>>>> blocks, one to detect mechanical headset insertion and removal and other
>>>> block to support headset type detection and 5 button detection and othe
>>>> features like impedance calculation.
>>>>
>>>> This patch adds support to:
>>>> 1> Support to NC and NO type of headset Jacks.
>>>> 2> Mechanical insertion and detection of headset jack.
>>>> 3> Detect a 3 pole Headphone and a 4 pole Headset.
>>>> 4> Detect 5 buttons.
>>>>
>>>> Tested it on DB410c with Audio Mezz board with 4 pole and 3 pole
>>>> headset/headphones.
>>>
>>
>>> Good news! This version has better results. I still have an issue where
>>> a headphone is reported as a headset when I do this sequence:
>>
>> Hi Damien,
>>
>> Thanks for testing..
>>
>>
>>> 	1. connect headset
>>> 	2. disconnect headset
>>> 	3. connect headphone
>>
>>> Following headphone connections/disconnections are reported correctly.
>>> Note that I don't press the media key, it's wrongly detected when I pull
>>> off the cable.
>>
>> If you do step 3 slowly there is a chance that we get KEY_MEDIA events, as
>> headphone is a 3 pole, during hp inserting we would end up shorting the MIC
>> and GND lines on the connector, as 3-pole connectors have longer GND
>> pole/connector length, this action is same as pressing MEDIA KEY.
>>
>> The logic in the driver uses this MEDIA KEY press release as advantage to
>> detect the accessory type before hs insertion, but this logic could break if
>> we are inserting headphone slowly, which is not a normal usecase.
>>
>> Any solution to this issue can be always break if we are doing slow
>> insertion of hs or we endup making the driver complex. I will think about
>> this once again and see how other drivers handle this usecase.
> 
> Understood, and you're right we should keep this driver as simple as
> possible.
> 
> I get the KEY_MEDIA event when doing step 2 (disconnecting headset), and
> I understand why it's doing that (and I think it's okay if we don't
> filter out that spurious event), but we should at least get a KEY_MEDIA
> release event at the same time as SW_{MICROPHONE,HEADPHONE}_INSERT
> removal. It doesn't really matter if I disconnect it fast or slowly,
> sometimes I'll get the KEY_MEDIA, some other times I won't.

I will see if I can fix this in a much better way and let you know.

> 
> Shouldn't mbhc_btn0_pressed be reset to false when physical removal is
> detected? I think that would solve the issue of headphone being detected
> as headset.
> 
Yes, I have considered that change to my next version.

> 
> Regards,
> 
