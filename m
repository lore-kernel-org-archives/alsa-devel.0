From: Paul Davis <pbd@op.net>
Subject: Re: Re: hdsp on big-endian
Date: Wed, 22 May 2002 09:29:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17AW9s-0008Px-00@usw-sf-list1.sourceforge.net>
References: <s5hptzofijc.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 22 May 2002 14:56:07 +0200."
             <s5hptzofijc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> >anyway...  after looking at the hdsp code again, i found that these
>> >endian conversions are not necessary at all!
>> >IIRC, readX/writeX already convert the endianess in itself.  thus, the
>> 
>> absolutely not. readl/writel on most architectures translate to:
>> 
>> 	   *addr = val;
>> 
>
>really?  for example, ppc uses in_le32() for readl(), which implies
>byte swapping.

what does CONFIG_APUS do? thats the conditional on which in_le32 is
used or not. AFAIK, readl is not supposed to have
endian-characteristics, but if true, that would make the non-APUS ppc
version totally wrong.

on x86:

#define __io_virt(x) ((void *)(x))
#define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
#define writel(b,addr) (*(volatile unsigned int *) __io_virt(addr) = (b))

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
