From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v8 07/13] slimbus: Add support for 'clock-pause' feature
Date: Fri, 1 Dec 2017 09:54:32 +0000
Message-ID: <5a882bef-3928-4865-8f05-cdfa3d220ad3@linaro.org>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
 <20171130174200.6684-8-srinivas.kandagatla@linaro.org>
 <CAOFm3uE+ehT+WGHO2tYz4W8h35wBgge+BO5fS=yuxemq28TERg@mail.gmail.com>
 <20171201095131.GF9353@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171201095131.GF9353@kroah.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
Cc: Mark <broonie@kernel.org>, ALSA <alsa-devel@alsa-project.org>, Sagar Dharia <sdharia@codeaurora.org>, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, Joe Perches <joe@perches.com>, "David S. Miller" <davem@davemloft.net>, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, Rob Herring <robh+dt@kernel.org>, pawel.moll@arm.com, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org



On 01/12/17 09:51, Greg Kroah-Hartman wrote:
> On Thu, Nov 30, 2017 at 08:25:26PM +0100, Philippe Ombredanne wrote:
>> On Thu, Nov 30, 2017 at 6:41 PM,<srinivas.kandagatla@linaro.org>  wrote:
>> []
>>> diff --git a/drivers/slimbus/sched.c b/drivers/slimbus/sched.c
>>> new file mode 100644
>>> index 000000000000..74300f1a6898
>>> --- /dev/null
>>> +++ b/drivers/slimbus/sched.c
>>> @@ -0,0 +1,128 @@
>>> +/* Copyright (c) 2011-2016, The Linux Foundation. All rights reserved.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 and
>>> + * only version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> + * GNU General Public License for more details.
>> Could it make sense to use the new SPDX ids here? e.g.
>>
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +// Copyright (c) 2011-2016, The Linux Foundation
>> This neat and cleaner, is it?
>> See tglx doc posted as patches and Linus comments for a rationale on
>> the comment styles.
> Yes please, otherwise I'll just have to write add-on patches to do just
> this:)
> 
Yep, I will take care of this before sending another version.


Thanks,
srini


> thanks,
> 
> greg k-h
