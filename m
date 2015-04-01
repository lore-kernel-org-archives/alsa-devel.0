From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: ASoC: cs4271: init/timing problem
Date: Wed, 1 Apr 2015 14:47:57 +0000
Message-ID: <9FF9C0F5-716B-4F31-AFAC-17B1C8991AB8@cirrus.com>
References: <551A5FC9.4010109@gmail.com>
 <alpine.DEB.2.10.1503311600000.13828@heelrod-desktop>
 <551BC102.6010403@gmail.com> <551BCE01.2070007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077474.ppops.net (mx0b-001ae601.pphosted.com [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id AFEBA265255
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 16:48:01 +0200 (CEST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by m0077474.ppops.net (8.14.7/8.14.7) with SMTP id t31EiCa3029368
 for <alsa-devel@alsa-project.org>; Wed, 1 Apr 2015 09:47:59 -0500
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
 by mx0b-001ae601.pphosted.com with ESMTP id 1tghg7r35x-1
 for <alsa-devel@alsa-project.org>; Wed, 01 Apr 2015 09:47:59 -0500
Received: from ex4.ad.cirrus.com (ex4.ad.cirrus.com [141.131.36.35])
 by mail1.cirrus.com (Postfix) with ESMTP id 90EBE34036
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 09:48:19 -0500 (CDT)
In-Reply-To: <551BCE01.2070007@gmail.com>
Content-Language: en-US
Content-ID: <4275777FE96F8C46BC16C07EC5053BEE@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pascal Huerst <pascal.huerst@gmail.com>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


On Apr 1, 2015, at 5:52 AM, Pascal Huerst <pascal.huerst@gmail.com> wrote:

> Hey Brian,
> 
> On 01.04.2015 11:57, Pascal Huerst wrote:
>> Hey Brian,
>> 
>> On 31.03.2015 23:01, Brian Austin wrote:
>>> On Tue, 31 Mar 2015, Pascal Huerst wrote:
>>> 
>>>> Hey all,
>>>> 
>>>> We have a custom built hw, based on am335x and from time to time we need
>>>> to rmmod/modprobe the ASoC machine driver. Depending on the hw, the
>>>> first call to regmap_update_bits(..) in cs4271_codec_probe(..) fails
>>>> with -EREMOTEIO.
>>>> 
>>>> The error is originated in:
>>>> 
>>>> drivers/i2c/busses/i2c-omap.c
>>>> 
>>>> and happens if no i2c package acknowledge is received by the host.
>>>> 
>>>> I think this is a timing issue and on some devices, the codec is just
>>>> not ready yet, for communication.
>>>> 
>>>> What is the right way to fix that? My attempt would be something like this:
>>> 
>>> The error you are referring to is a NACK from a device (CODEC). That is 
>>> usually seen when you dont have it hooked up correctly. Could also be that 
>>> the I2C bus is too fast. How fast are you running the bus?
>> 
>> clock-frequency is set to 100000, hence 100 kHz, which should be ok,
>> according to the datasheet.
> 
> I just lowered the clock-frequency to 50 kHz and I face the same
> problem, but it very much depends on the hardware. On some devices I
> don't face the problem at all and on others I can reproduce it very
> reliable. If I add a mdelay(20), or use the loop I postet earlier, the
> issue is gone on all devices.
Are there any other devices on the I2C bus? Lets take this off the ALSA list until there
is a determination that it is an ASoC issue which it does not appear to be right now.
OK?

Thanks,
Brian
