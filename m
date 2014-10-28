From: Qais Yousef <qais.yousef-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/11] drivers: char: add AXD Audio Processing IP driver
Date: Tue, 28 Oct 2014 14:36:39 +0000
Message-ID: <544FA9F7.1020101@imgtec.com>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com> <1414495589-8579-4-git-send-email-qais.yousef@imgtec.com> <20141028141038.GA18384@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141028141038.GA18384-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 10/28/2014 02:10 PM, Greg Kroah-Hartman wrote:
> On Tue, Oct 28, 2014 at 11:26:21AM +0000, Qais Yousef wrote:
>> AXD is Audio Processing IP by Imagination Technologies that can
>> perform decoding, encoding, equalisation, resampling, mixing,
>> synchronisation and audio playback.
> Isn't that a codec?  Why is this a "char" driver and not one that fits
> into our existing audio subsystem?

As far as I understand it doesn't fit into current alsa framework 
because of a number of unsupported features that we need. Specifically 
the range of compressed decoders we support and their configurations and 
encoding. I might have gotten it wrong though so I'll wait to see what 
alsa people say.

>> this patch adds defs and initialisation files
> Spell check :)

Hmm UK spelling vs US spelling :) Unless you mean the defs then I'll 
expand it.


>> Signed-off-by: Qais Yousef <qais.yousef-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
>> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> Cc: <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
>> ---
>>   drivers/char/axd/axd_api.h    |  641 +++++++++++++++++++++++++
>>   drivers/char/axd/axd_module.c | 1064 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/char/axd/axd_module.h |   99 ++++
>>   include/linux/axd.h           |   32 ++
>>   4 files changed, 1836 insertions(+)
>>   create mode 100644 drivers/char/axd/axd_api.h
>>   create mode 100644 drivers/char/axd/axd_module.c
>>   create mode 100644 drivers/char/axd/axd_module.h
>>   create mode 100644 include/linux/axd.h
>>
>> diff --git a/drivers/char/axd/axd_api.h b/drivers/char/axd/axd_api.h
>> new file mode 100644
>> index 000000000000..0d732f173f55
>> --- /dev/null
>> +++ b/drivers/char/axd/axd_api.h
>> @@ -0,0 +1,641 @@
>> +/*
>> + *  Copyright (C) 2011-2014 Imagination Technologies Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version 2
>> + * of the License, or (at your option) any later version.
> Do you really mean "any later version"?
>

Nope. I probably copied that from the wrong source.

>> + *
>> + *  Main API to the AXD for access from the host.
>> + */
>> +#ifndef AXD_API_H_
>> +#define AXD_API_H_
>> +
>> +#include <linux/types.h>
>> +
>> +
>> +#define THREAD_COUNT 4
>> +#define AXD_MAX_PIPES 3
>> +
>> +
>> +#define AXD_DESCRIPTOR_READY_BIT	0x80000000
>> +#define AXD_DESCRIPTOR_INUSE_BIT	0x40000000
>> +#define AXD_DESCRIPTOR_EOS_BIT		0x20000000
>> +#define AXD_DESCRIPTOR_SIZE_MASK	0x0000FFFF
>> +
>> +struct axd_buffer_desc {
>> +	uint32_t status_size;
>> +	uint32_t data_ptr;
>> +	uint32_t pts_high;
>> +	uint32_t pts_low;
> Please always use standard Linux kernel types, "u32" in this case.

OK.

Thanks,
Qais

> thanks,
>
> greg k-h

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
