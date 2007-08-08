From: Songmao Tian <tiansm@lemote.com>
Subject: Re: ALSA on MIPS platform
Date: Wed, 08 Aug 2007 08:40:14 +0800
Message-ID: <46B910EE.2010905@lemote.com>
References: <46B332AC.8020403@lemote.com>	<5861a7880708062253x7133659cm1ff17f451e4f82f8@mail.gmail.com>	<5861a7880708062317t21970c81w3f16580858bf50af@mail.gmail.com>
	<20070807.230157.59463765.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lemote.com (unknown [222.92.8.141])
	by alsa0.perex.cz (Postfix) with SMTP id EEF2E1037EA
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Aug 2007 02:40:27 +0200 (CEST)
In-Reply-To: <20070807.230157.59463765.anemo@mba.ocn.ne.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, tiwai@suse.de, greg@kroah.com, ralf@linux-mips.org, jiankemeng@gmail.com
List-Id: alsa-devel@alsa-project.org

Atsushi Nemoto wrote:
> On Tue, 7 Aug 2007 10:18:04 +0400, "Dajie Tan" <jiankemeng@gmail.com> wrote:
>   
>>  static inline unsigned long virt_to_phys(volatile const void *address)
>>  {
>> -       return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
>> +       return ((unsigned long)address & 0x1fffffff) + PHYS_OFFSET;
>>  }
>>     
>
> This makes virt_to_phys() a bit slower, and more importantly, breaks
> 64-bit kernel.
>   

I have tried this way, and disassemble result show 32-bit kernel add 
only one instruction.
But I don't really insist on this patch, for it doesn't resolve some 
driver code requirement.
> ---
> Atsushi Nemoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>   
