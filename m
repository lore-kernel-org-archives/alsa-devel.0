From: =?UTF-8?B?SsO2cmcgTcO8bGxlcg==?= <joerg.mueller7744@gmail.com>
Subject: Re: Cannot combine audio devices with more than 64
	channels
Date: Wed, 8 Feb 2017 18:22:16 +0100
Message-ID: <CAKw=HF28wg3cd9bWMQf3qF9GP76RG7h+wqzSF5daWDqHU5qmhg@mail.gmail.com>
References: <CAKw=HF0hbhxJ1YGjukjFr72xtEh2FjtH6k0Bh+rFcMwejgwcUg@mail.gmail.com>
 <1cdef19b-a458-7441-2ede-2ba8984ec7cd@ladisch.de>
 <s5hh94khiao.wl-tiwai@suse.de>
 <CAKw=HF1kZ12YOUuBX0MmiyYsPqQ68kafP-cVmWA8FP0dHOAuDw@mail.gmail.com>
 <20170131193159.GA17070@localhost.localdomain>
 <CAKw=HF10J=Sr=qrR6yTB_m3yznDh8boUv_qP1MKN75SXFth40w@mail.gmail.com>
 <20170208162012.GA26820@localhost.localdomain>
 <20170208163110.GA26916@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EA10266AB2
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 18:22:18 +0100 (CET)
Received: by mail-oi0-f66.google.com with SMTP id x84so11494746oix.2
 for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2017 09:22:17 -0800 (PST)
In-Reply-To: <20170208163110.GA26916@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Rigg <aldev2@jrigg.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In common/JackConstants.h, there is the line:
#define DRIVER_PORT_NUM 256
(https://github.com/jackaudio/jack2/blob/master/common/JackConstants.h#L53)

in linux/alsa/JackAlsaDriver.cpp, there are the lines throwing the error:
assert(fCaptureChannels < DRIVER_PORT_NUM);
assert(fPlaybackChannels < DRIVER_PORT_NUM);
(https://github.com/jackaudio/jack2/blob/master/linux/alsa/JackAlsaDriver.cpp#L122-L123)

They both compare against DRIVER_PORT_NUM, which always caps them at
256 since its a constant. So the problem may be there?

2017-02-08 17:31 GMT+01:00 John Rigg <aldev2@jrigg.co.uk>:
> On Wed, Feb 08, 2017 at 04:20:12PM +0000, John Rigg wrote:
>> In jack2/common/JackGlobals.h it has the following:
>> #ifndefine PORT_NUM_MAX
>> #define PORT_NUM_MAX 4096
>> #endif
>>
>
> Sorry, that should be JackConstants.h
>
> John

2017-02-08 17:31 GMT+01:00 John Rigg <aldev2@jrigg.co.uk>:
> On Wed, Feb 08, 2017 at 04:20:12PM +0000, John Rigg wrote:
>> In jack2/common/JackGlobals.h it has the following:
>> #ifndefine PORT_NUM_MAX
>> #define PORT_NUM_MAX 4096
>> #endif
>>
>
> Sorry, that should be JackConstants.h
>
> John
