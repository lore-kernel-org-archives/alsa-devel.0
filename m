From: Songmao Tian <tiansm@lemote.com>
Subject: Re: ALSA on MIPS platform
Date: Thu, 09 Aug 2007 09:24:45 +0800
Message-ID: <46BA6CDD.7020907@lemote.com>
References: <46B332AC.8020403@lemote.com>
	<5861a7880708062253x7133659cm1ff17f451e4f82f8@mail.gmail.com>
	<5861a7880708062317t21970c81w3f16580858bf50af@mail.gmail.com>
	<20070807.230157.59463765.anemo@mba.ocn.ne.jp>
	<20070807175402.GA24731@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lemote.com (unknown [222.92.8.141])
	by alsa0.perex.cz (Postfix) with SMTP id A87CC103910
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 03:24:59 +0200 (CEST)
In-Reply-To: <20070807175402.GA24731@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, tiwai@suse.de, greg@kroah.com, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, jiankemeng@gmail.com
List-Id: alsa-devel@alsa-project.org

Ralf Baechle wrote:
> On Tue, Aug 07, 2007 at 11:01:57PM +0900, Atsushi Nemoto wrote:
>
>   
>> On Tue, 7 Aug 2007 10:18:04 +0400, "Dajie Tan" <jiankemeng@gmail.com> wrote:
>>     
>>>  static inline unsigned long virt_to_phys(volatile const void *address)
>>>  {
>>> -       return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
>>> +       return ((unsigned long)address & 0x1fffffff) + PHYS_OFFSET;
>>>  }
>>>       
>> This makes virt_to_phys() a bit slower, and more importantly, breaks
>> 64-bit kernel.
>>     
>
> It's ALSA that is doing funny things here so there is no point in fixing
> the arch code to work for ALSA.
>
>   Ralf
>
>
>   
arm has made a dma_mmap_coherent, but I don't quite understand the code 
and I am not sure the situation is the same.


Tian
