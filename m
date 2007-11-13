From: Chris Pemberton <cjpembo@gmail.com>
Subject: Re: Intel HD Audio
Date: Tue, 13 Nov 2007 10:43:43 -0600
Message-ID: <4739D43F.8090205@gmail.com>
References: <4737A76C.3080400@gmail.com> <s5hejeuv1nf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by alsa0.perex.cz (Postfix) with ESMTP id 4716124570
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 17:43:57 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so1144381nzf
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 08:43:56 -0800 (PST)
In-Reply-To: <s5hejeuv1nf.wl%tiwai@suse.de>
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
> At Sun, 11 Nov 2007 19:07:56 -0600,
> Chris Pemberton wrote:
>   
>> I've been trying to fix audio on my Lenovo 3000 N100 laptop for quite 
>> some time; on this list and via bug #0003468.  I finally got tired of 
>> the xorg graphics woes and hacking for sound, so I am now "temporarily" 
>> running Vista. 
>> I'd like to get this audio fixed permanently, so if you need any details 
>> from the working Vista drivers, let me know before I get sick of Windows 
>> and switch back to Linux.
>>     
>
> Well, an over-all experience, what is missing, would be a good input
> (preferablly with a patch ;)
>
>
> thanks,
>
> Takashi
>
>   
The machine is a Lenovo 3000 N100.

There are two methods I can choose to get sound working partially:

1.  Edit patch_realtek.c (near line 10971):
     from     SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo", ALC861VD_LENOVO)
     to         SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo", ALC861VD_3ST)


2.  Use modprobe snd-hda-intel model=3stack

I guess both methods accomplish the same thing.  I'm not saying I know 
the reason why this works, but I'd like to help find out why the 
ALC861VD_LENOVO quirk is not working on my machine.

Using this hack, I can hear sound from the speakers and headphones, yet 
headphones do not mute the speakers when pluged in.  I can record from 
either the built-in or external mic.  Is pluging in an external mic 
supposed to mute the internal mic?  (It doesn't).

Here is a pastbin using Kubuntu 7.10 with model=3stack:
http://pastebin.ca/772177

Is there any information I could get from Vista to help?  I can dual boot.

Thanks,

Chris
