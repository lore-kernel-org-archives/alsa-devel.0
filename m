From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 01/10] ASoC: tlv320aic32x4: Remove filename
 from header and switch to SPDX
Date: Wed, 13 Dec 2017 09:50:34 -0600
Message-ID: <aa585d9a-a68c-95a1-b156-26f65aa1b890@ti.com>
References: <20171212224311.24045-1-afd@ti.com>
 <1513131575.3036.67.camel@perches.com>
 <3ff091f8-1366-ab38-dd7b-2633e6f3dd80@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CDF826698E
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 16:50:35 +0100 (CET)
In-Reply-To: <3ff091f8-1366-ab38-dd7b-2633e6f3dd80@ti.com>
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
To: Joe Perches <joe@perches.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/13/2017 09:44 AM, Andrew F. Davis wrote:
> On 12/12/2017 08:19 PM, Joe Perches wrote:
>> On Tue, 2017-12-12 at 16:43 -0600, Andrew F. Davis wrote:
>>> The filename is often wrong after moves and adds nothing of value,
>>> lets drop it. While already here, switch to SPDX.
>> []
>>> diff --git a/sound/soc/codecs/tlv320aic32x4-i2c.c b/sound/soc/codecs/tlv320aic32x4-i2c.c
>> []
>>> @@ -1,21 +1,10 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>>  /*
>>> - * linux/sound/soc/codecs/tlv320aic32x4-i2c.c
>>> - *
>>>   * Copyright 2011 NW Digital Radio
>>>   *
>>>   * Author: Jeremy McDermond <nh6z@nh6z.net>
>>>   *
>>>   * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
>>> - *
>>> - * This program is free software; you can redistribute it and/or modify
>>> - * it under the terms of the GNU General Public License as published by
>>> - * the Free Software Foundation; either version 2 of the License, or
>>> - * (at your option) any later version.
>>> - *
>>> - * This program is distributed in the hope that it will be useful,
>>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> - * GNU General Public License for more details.
>>
>> nack.  Note the "(at your option) any later version"
>>
>> If you are going to update to spdx and remove the old license
>> verbiage, make sure you are adding the correct spdx tag.
>>
> 
> My bad, will fix.
> 
> By the way, do you like these spdx update patch? Or would you rather I
> drop this one and wait to let some script do it for the whole subsystem?
> 

This last question was directed at Mark btw :)

Actually, I'll just drop the spdx change from this patch, no reason to
do these manually.
