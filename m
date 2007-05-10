From: Chris Pemberton <cjpembo@gmail.com>
Subject: Re: alsa-driver-1.0.14rc3 won't compile with kernel
 2.6.20.3 when Processor family is Core2
Date: Thu, 10 May 2007 11:17:22 -0500
Message-ID: <46434592.4080906@gmail.com>
References: <46429F60.1000206@gmail.com> <s5hirb1jbce.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by alsa0.perex.cz (Postfix) with ESMTP id D3C56243CC
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 18:17:23 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a25so582021pyi
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 09:17:22 -0700 (PDT)
In-Reply-To: <s5hirb1jbce.wl%tiwai@suse.de>
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
> At Wed, 09 May 2007 23:28:16 -0500,
> Chris Pemberton wrote:
>   
>> Laptop has Pentium Dual Core and Intel HD Audio
>> Kernel is 2.6.20.3 compiled for Processor family Core2.
>> In-kernel alsa drivers are 1.0.14rc3 (cat /proc/asound/version) and 
>> compile ok.
>> In-kernel drivers do not work for this sound card.
>>
>> Downloaded 1.0.14rc3 and applied patch_realtek.c
>> ./configure --prefix=/usr --with-cards=hda-intel
>> "make" gives the following error:
>>
>> make[1]: Entering directory `/usr/src/linux-2.6.20.3'
>>     
>>> /usr/src/linux-2.6.20.3/Makefile:491: 
>>> /usr/src/linux-2.6.20.3/arch//Makefile: No such file or directory
>>>       
>> If the kernel is compiled with Processor family = Pentium M, the 
>> external alsa drivers compile clean and the soundcard works.
>>
>> So, Processor family = Core2 cannot be selected when using external 
>> alsa-driver-1.0.14rc3.
>>     
>
> This should have been fixed on 1.0.14rc4.  Give it a try.
>
>
> Takashi
>
>   
Does 1.0.14rc4 contain the patch_realtek.c?  Or will I have to apply the 
patch there too?
