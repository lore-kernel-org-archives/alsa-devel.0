From: Chris Pemberton <cjpembo.mailing.lists@gmail.com>
Subject: Re: Lenovo 3000 N100 ALC861-VD quirk
Date: Fri, 25 Apr 2008 01:54:47 -0500
Message-ID: <48118037.4090007@gmail.com>
References: <481175CD.7000500@gmail.com> <s5hej8u4f8b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by alsa0.perex.cz (Postfix) with ESMTP id AF9A0103816
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 08:55:35 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id w49so4056040pyg.36
	for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2008 23:55:34 -0700 (PDT)
In-Reply-To: <s5hej8u4f8b.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 25 Apr 2008 01:10:21 -0500,
> Chris Pemberton wrote:
>   
>> Hello,
>>
>> I'm revisiting an unresolved bug report I opened several months ago: bug 
>> # 0003468
>> The bug still exists as of ALSA v1.0.15 (Ubuntu 8.04).
>>     
>
> Oh, 1.0.15?  Whan an old version.  Could you check whether the
> latest HG version (or at least 1.0.16) works?
> Or, 2.6.25 kernel, which includes most of 1.0.16 stuff.
>
>
>   
>> A quick recap:
>>
>> The following line in patch_realtek.c is my machine:
>>
>> SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo", ALC861VD_LENOVO),
>>
>> If I edit this line as follows, I get sound:
>>
>> SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo" ALC861VD_3ST),
>>
>> (or I can just pass model=3stack to get sound).
>>
>> Inserting headphones doesn't mute the speakers or power the headphones.  
>> But I can manually unmute the headphones via alsamixer (but speakers are 
>> still not muted).
>>
>> I do see that the special keyboard keys for speaker mute, volume up and 
>> volume down are working correctly; but I don't know if this is something 
>> ALSA is responsible for, or X, or Ubuntu.  So if this is ALSA, thanks!
>>     
>
> Depends.  Somethings it's controlled via hd-audio but sometimes over
> ACPI.  Anyway, you have to try the latest version (HG version) so that
> you can test any patches over it.
>
>
> thanks,
>
> Takashi
>
>   
Just downloaded the lastest HG tarball from:
ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver
and patch_realtek.c, line #12684 still looks wrong, at least for me.

I'll get the latest ALSA from HG installed on this machine (Ubuntu 8.04) 
and get back to you soon.

Thanks
