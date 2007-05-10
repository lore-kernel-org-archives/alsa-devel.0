From: Chris Pemberton <cjpembo@gmail.com>
Subject: Re: alsa-driver-1.0.14rc3 won't compile with kernel
 2.6.20.3 when Processor family is Core2
Date: Thu, 10 May 2007 13:54:08 -0500
Message-ID: <46436A50.8090703@gmail.com>
References: <46429F60.1000206@gmail.com>	<s5hirb1jbce.wl%tiwai@suse.de>	<46434592.4080906@gmail.com>
	<s5hsla4iqn8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.227])
	by alsa0.perex.cz (Postfix) with ESMTP id E2548243E5
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 20:54:09 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so641457wxd
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 11:54:08 -0700 (PDT)
In-Reply-To: <s5hsla4iqn8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 10 May 2007 11:17:22 -0500,
> Chris Pemberton wrote:
>   
>> Takashi Iwai wrote:
>>     
>>> At Wed, 09 May 2007 23:28:16 -0500,
>>> Chris Pemberton wrote:
>>>   
>>>       
>>>> Laptop has Pentium Dual Core and Intel HD Audio
>>>> Kernel is 2.6.20.3 compiled for Processor family Core2.
>>>> In-kernel alsa drivers are 1.0.14rc3 (cat /proc/asound/version) and 
>>>> compile ok.
>>>> In-kernel drivers do not work for this sound card.
>>>>
>>>> Downloaded 1.0.14rc3 and applied patch_realtek.c
>>>> ./configure --prefix=/usr --with-cards=hda-intel
>>>> "make" gives the following error:
>>>>
>>>> make[1]: Entering directory `/usr/src/linux-2.6.20.3'
>>>>     
>>>>         
>>>>> /usr/src/linux-2.6.20.3/Makefile:491: 
>>>>> /usr/src/linux-2.6.20.3/arch//Makefile: No such file or directory
>>>>>       
>>>>>           
>>>> If the kernel is compiled with Processor family = Pentium M, the 
>>>> external alsa drivers compile clean and the soundcard works.
>>>>
>>>> So, Processor family = Core2 cannot be selected when using external 
>>>> alsa-driver-1.0.14rc3.
>>>>     
>>>>         
>>> This should have been fixed on 1.0.14rc4.  Give it a try.
>>>
>>>
>>> Takashi
>>>
>>>   
>>>       
>> Does 1.0.14rc4 contain the patch_realtek.c?  Or will I have to apply the 
>> patch there too?
>>     
>
> It has since a few years ago.  I don't know which patch you're
> referring, but most of patches have been already merged in 1.0.14rc4.
>
>
> Takashi
>
>   
I recompiled my 2.6.20.3 kernel for core2, and tried alsa 1.0.14rc4 as 
you suggested:

make[1]: Entering directory `/usr/src/linux-2.6.20.3'
  CC [M]  /usr/src/alsa-driver-1.0.14rc4/acore/memalloc.o
In file included from /usr/src/alsa-driver-1.0.14rc4/acore/memalloc.inc:13,
                 from /usr/src/alsa-driver-1.0.14rc4/acore/memalloc.c:1:
/usr/src/alsa-driver-1.0.14rc4/include/adriver.h: In function 
'snd_pci_orig_save_state':
/usr/src/alsa-driver-1.0.14rc4/include/adriver.h:1168: error: too many 
arguments to function 'pci_save_state'
/usr/src/alsa-driver-1.0.14rc4/include/adriver.h: In function 
'snd_pci_orig_restore_state':
/usr/src/alsa-driver-1.0.14rc4/include/adriver.h:1172: error: too many 
arguments to function 'pci_restore_state'
make[4]: *** [/usr/src/alsa-driver-1.0.14rc4/acore/memalloc.o] Error 1
make[3]: *** [/usr/src/alsa-driver-1.0.14rc4/acore] Error 2
make[2]: *** [_module_/usr/src/alsa-driver-1.0.14rc4] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.20.3'
make: *** [compile] Error 2

Then I tried again it with the patch_realtek.c patch copied in 1.0.14rc4 
and got the exact same error.

I've tried when newer kernels as well: no good with core2 in kernel.

Chris
