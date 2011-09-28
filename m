From: Abdelghani Ouchabane <abdelghani@ezono.com>
Subject: Re: "modprobe snd_hda_intel" crashes on my hardware
Date: Wed, 28 Sep 2011 15:22:21 +0200
Message-ID: <4E831F8D.7090508@ezono.com>
References: <4E817010.7030607@ezono.com>	<s5hipodciju.wl%tiwai@suse.de>	<4E82D2C6.9060307@ezono.com>	<s5hpqikbx42.wl%tiwai@suse.de>	<4E83116A.7070000@ezono.com>	<s5hipocbva1.wl%tiwai@suse.de>
	<4E83184E.10203@ezono.com> <4E8336BB.2090502@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ezo.ezono.com (ezo.ezono.com [50.22.105.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 17158103A6C
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 17:22:36 +0200 (CEST)
In-Reply-To: <4E8336BB.2090502@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Abdelghani Ouchabane wrote:
>   
>> in /proc/asound/card0/codec#2
>>
>> system 1 : Subsystem Id: 0x7fafffdd
>> system 2 : Subsystem Id: 0xffffffff
>> system 3 : Subsystem Id: 0xff7f7fa3
>>
>> Why the "Subsystem Id" is different between the three systems?
>>     
>
> This is a HDA codec register that should be initialized by the BIOS.
> Apparently, yours doesn't, and the register contents are somewhat random.
>
> Bug whoever is responsible for that BIOS.  A system not initializing
> the pin config and subsystem registers is a violation of the HDA
> specification.
>
>
> Regards,
> Clemens
>   
Thanks, I will use your solution + patch and I will contact the 
manufacturer of the boards to fix the BIOS.

Many thanks Clemens & Takashi for your great supports.

Cheers,
Ghani
