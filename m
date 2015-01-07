From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH] ASoC: wm5102: Use put_unaligned_be16
Date: Wed, 7 Jan 2015 20:54:58 +0530
Message-ID: <CAK-LDbJxb7KBoX1jUXi7_OChJc2NPMT1rRATTK8ci_8gSZvXCA@mail.gmail.com>
References: <20141226044457.GA12777@vaishali-Ideapad-Z570>
 <20150107100103.GR14516@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 82EB4260547
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 16:24:59 +0100 (CET)
Received: by mail-wg0-f49.google.com with SMTP id n12so1368942wgh.8
 for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2015 07:24:59 -0800 (PST)
In-Reply-To: <20150107100103.GR14516@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 7, 2015 at 3:31 PM, Charles Keepax
<ckeepax@opensource.wolfsonmicro.com> wrote:
> On Fri, Dec 26, 2014 at 10:14:57AM +0530, Vaishali Thakkar wrote:
>> This patch introduces the use of function put_unaligned_be16.
>>
>> This is done using Coccinelle and semantic patch used is as follows:
>>
>> @a@
>> typedef u16, __be16, uint16_t;
>> {u16,__be16,uint16_t} e16;
>> identifier tmp;
>> expression ptr;
>> expression y,e;
>> type T;
>> @@
>>
>> - tmp = cpu_to_be16(y);
>>
>> <+... when != tmp
>> (
>> - memcpy(ptr, (T)&tmp, \(2\|sizeof(u16)\|sizeof(__be16)\|sizeof(uint16_t)\|sizeof(e16)\));
>> + put_unaligned_be16(y,ptr);
>> |
>> - memcpy(ptr, (T)&tmp, ...);
>> + put_unaligned_be16(y,ptr);
>> )
>> ...+>
>> ? tmp = e
>>
>> @@ type T; identifier a.tmp; @@
>>
>> - T tmp;
>> ...when != tmp
>>
>> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
>> ---
>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>
> CCing patches@opensource.wolfsonmicro.com would be handy though.

Ok. Will keep this in mind while sending patches of audio drivers.

Do I need to send this patch again with CC??

> Thanks,
> Charles



-- 
Vaishali
