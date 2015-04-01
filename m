From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Re: ASoC: cs4271: init/timing problem
Date: Wed, 01 Apr 2015 17:37:28 +0200
Message-ID: <551C10B8.5080409@gmail.com>
References: <551A5FC9.4010109@gmail.com>
 <alpine.DEB.2.10.1503311600000.13828@heelrod-desktop>
 <551BC102.6010403@gmail.com> <551BCE01.2070007@gmail.com>
 <9FF9C0F5-716B-4F31-AFAC-17B1C8991AB8@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 665AE2652E9
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 17:37:29 +0200 (CEST)
Received: by wgoe14 with SMTP id e14so57515131wgo.0
 for <alsa-devel@alsa-project.org>; Wed, 01 Apr 2015 08:37:29 -0700 (PDT)
In-Reply-To: <9FF9C0F5-716B-4F31-AFAC-17B1C8991AB8@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On 01.04.2015 16:47, Austin, Brian wrote:
> 
> On Apr 1, 2015, at 5:52 AM, Pascal Huerst <pascal.huerst@gmail.com> wrote:
> 
>> Hey Brian,
>>
>> On 01.04.2015 11:57, Pascal Huerst wrote:
>>> Hey Brian,
>>>
>>> On 31.03.2015 23:01, Brian Austin wrote:
>>>> On Tue, 31 Mar 2015, Pascal Huerst wrote:
>>>>
>>>>> Hey all,
>>>>>
>>>>> We have a custom built hw, based on am335x and from time to time we need
>>>>> to rmmod/modprobe the ASoC machine driver. Depending on the hw, the
>>>>> first call to regmap_update_bits(..) in cs4271_codec_probe(..) fails
>>>>> with -EREMOTEIO.
>>>>>
>>>>> The error is originated in:
>>>>>
>>>>> drivers/i2c/busses/i2c-omap.c
>>>>>
>>>>> and happens if no i2c package acknowledge is received by the host.
>>>>>
>>>>> I think this is a timing issue and on some devices, the codec is just
>>>>> not ready yet, for communication.
>>>>>
>>>>> What is the right way to fix that? My attempt would be something like this:
>>>>
>>>> The error you are referring to is a NACK from a device (CODEC). That is 
>>>> usually seen when you dont have it hooked up correctly. Could also be that 
>>>> the I2C bus is too fast. How fast are you running the bus?
>>>
>>> clock-frequency is set to 100000, hence 100 kHz, which should be ok,
>>> according to the datasheet.
>>
>> I just lowered the clock-frequency to 50 kHz and I face the same
>> problem, but it very much depends on the hardware. On some devices I
>> don't face the problem at all and on others I can reproduce it very
>> reliable. If I add a mdelay(20), or use the loop I postet earlier, the
>> issue is gone on all devices.
> Are there any other devices on the I2C bus? Lets take this off the ALSA list until there
> is a determination that it is an ASoC issue which it does not appear to be right now.

Well I think it is. There is a delay needed in sound/soc/codec/cs4271.c
at line 569, in certain cases, because the call to regmap_update_bits on
line 570 fails sometimes. If I add a delay of a few us on line 569, the
call never fails.

But let me just send in a patch so we really know what we are talking
about, then.
