From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] - arecord - remove "front" and related
	devices from the output of list-pcm option of arecord
Date: Sat, 3 Jul 2010 10:36:55 +0800
Message-ID: <AANLkTinxEaSMl1SJJ5BTA0-te9BsB5-MdvtmMNuwglis@mail.gmail.com>
References: <AANLkTinyBpf_qh6DGvj_V4UGY-JZUomNX6N32_WJpOjo@mail.gmail.com>
	<alpine.LNX.2.00.1007010745470.15497@eeebox2.perex-int.cz>
	<AANLkTimGJu_9tdOMhPutnW0MepWCr075y7rzXziNbdia@mail.gmail.com>
	<alpine.LNX.2.00.1007020736530.15497@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id E31A824456
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Jul 2010 04:36:56 +0200 (CEST)
Received: by vws9 with SMTP id 9so1019586vws.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Jul 2010 19:36:56 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1007020736530.15497@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/2 Jaroslav Kysela <perex@perex.cz>

> On Fri, 2 Jul 2010, Raymond Yau wrote:
>
>  2010/7/1 Jaroslav Kysela <perex@perex.cz>
>>
>>  On Thu, 1 Jul 2010, Raymond Yau wrote:
>>>
>>>  Replace "front" device by "hw" device  and remove "rear", "center_lfe" ,
>>>
>>>> "side" , "surroundxx" from the output of "arecord -L" since "front"
>>>> device
>>>> cannot be used for capturing and the front device is for playback only
>>>>  .
>>>>
>>>>
>>> NAK. Fix alsa-lib/configuration to return proper "IOID".
>>>
>>>                                       Jaroslav
>>>
>>>
>> I guess  the hint "IOID" has not implemented , the namehint.c did not add
>> "Input" or "Output" to the hint_list and snd_device_name_get_hint() is
>> unable to retrieve "IOID" from the hint_list
>>
>
> Use device_input and device_output in the hint {} section instead device.
>
>                                                Jaroslav
>

The only conf file which contain device_input and device_output is
alsa-lib/src/conf/pcm/default.conf


    hint {
        description "Default Audio Device"
        device_output {
            @func refer
            name defaults.pcm.dmix.device
        }
        device_input {
            @func refer
            name defaults.pcm.dsnoop.device
        }
    }

But arecord -L or aplay -L show both dmix:CARD=xxx , dsnopp:CARD=xxx devices

Any example how to set the correct syntax to use device_input and
device_output ?

Do I need to put them in every card's conf file or just pcm/front.conf ?
