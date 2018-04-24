From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH v2 1/5] ALSA: xen-front: Introduce Xen
 para-virtualized sound frontend driver
Date: Tue, 24 Apr 2018 16:59:14 +0300
Message-ID: <6f9b9e79-e6c8-493a-6dd5-717ec9fab881@gmail.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-2-andr2000@gmail.com> <s5htvs0so92.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C64126722C
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 15:59:16 +0200 (CEST)
Received: by mail-lf0-f45.google.com with SMTP id j16-v6so3229668lfb.7
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 06:59:16 -0700 (PDT)
In-Reply-To: <s5htvs0so92.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Juergen Gross <jgross@suse.com>, alsa-devel@alsa-project.org, konrad.wilk@oracle.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
List-Id: alsa-devel@alsa-project.org

On 04/24/2018 04:55 PM, Takashi Iwai wrote:
> On Mon, 16 Apr 2018 08:24:49 +0200,
> Oleksandr Andrushchenko wrote:
>> --- /dev/null
>> +++ b/sound/xen/Kconfig
>> @@ -0,0 +1,10 @@
>> +# ALSA Xen drivers
>> +
>> +config SND_XEN_FRONTEND
>> +	tristate "Xen para-virtualized sound frontend driver"
>> +	depends on XEN && SND_PCM
> Please do select SND_PCM instead of depends.
will do
>> +	select XEN_XENBUS_FRONTEND
>> +	default n
> "default n" is superfluous, drop it.
will drop
>
> thanks,
>
> Takashi
Thank you,
Oleksandr
