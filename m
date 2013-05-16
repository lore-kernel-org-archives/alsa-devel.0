From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] ASoC: dfbmcs320: make the driver common
 for other BT modules
Date: Thu, 16 May 2013 20:00:17 +0800
Message-ID: <CAGsJ_4yn2uodRKrFKYrX85XA7A=hQs2w0cyGoEEHsYgCJHD7eQ@mail.gmail.com>
References: <1368687184-12169-1-git-send-email-Baohua.Song@csr.com>
 <5194AC3C.4080206@metafoo.de>
 <CAGsJ_4yoXj+e7A20SM5+ctLvE2QRTp0bzDeKfCZSUHTO8BPq5A@mail.gmail.com>
 <5194C2FC.70804@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f42.google.com (mail-qe0-f42.google.com
 [209.85.128.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 1759B2654E3
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 14:00:37 +0200 (CEST)
Received: by mail-qe0-f42.google.com with SMTP id 1so1885858qee.15
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 05:00:37 -0700 (PDT)
In-Reply-To: <5194C2FC.70804@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, workgroup.linux@csr.com, Graeme Gregory <graeme@openmoko.org>, broonie@kernel.org, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2013/5/16 Lars-Peter Clausen <lars@metafoo.de>:
> On 05/16/2013 12:31 PM, Barry Song wrote:
>> 2013/5/16 Lars-Peter Clausen <lars@metafoo.de>:
>>> On 05/16/2013 08:53 AM, Barry Song wrote:
>>>> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
>>>> we don't want everyone to have a seperate codec driver. anyway, the
>>>> feature of Bluetooth handsfree is same on all platforms, so this patch
>>>> makes the DFBM-CS320 driver become a common BT handsfree driver.
>>> [...]
>>>> -static struct platform_driver dfmcs320_driver = {
>>>> +static struct platform_driver bt_handsfree_driver = {
>>>>       .driver = {
>>>> -             .name = "dfbmcs320",
>>>> +             .name = "bt-handsfree",
>>>>               .owner = THIS_MODULE,
>>>
>>> In my opinion it's a good idea to keep a platform_id list of all the
>>> supported devices.
>>
>> i have no idea how many bluetooth handsfree module exist in the world.
>> there must be many. actually the driver works for almost all BT
>> handsfree.
>> so my basic idea is making the codes as common as possible.
>
> you don't have to know all the device names, but I'd prefer to keep at least
> dfbmcs320 in the device id list.

i did think it is a good idea to have device id list while i sent the
last mail. and it matches with the generic device driver engineering
sense. the problem is i don't how long the list will be.
if you like to keep dfbmcs320 at least for the moment, i would agree.

>
> - Lars

-barry
