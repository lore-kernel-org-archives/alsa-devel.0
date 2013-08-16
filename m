From: "Nathanael D. Noblet" <nathanael@gnat.ca>
Subject: Re: RealTek Inverted Mic Patch
Date: Fri, 16 Aug 2013 09:28:40 -0600
Message-ID: <520E4528.7020002@gnat.ca>
References: <520D399B.6020607@gnat.ca> <s5hvc36ma1m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060706030203010406020903"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hvc36ma1m.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, David Henningsson <david.henningsson@canonical.com>, Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060706030203010406020903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

   Thanks for applying it - there is one more piece of hardware that 
needs the same type of fix. Here's an updated patch...
just the addition of

SND_PCI_QUIRK(0x1025, 0x022f, "Acer Aspire One", ALC662_FIXUP_INV_DMIC),

over and above what was already in the last patch..

On 08/16/2013 12:20 AM, Takashi Iwai wrote:
> At Thu, 15 Aug 2013 14:27:07 -0600,
> Nathanael D. Noblet wrote:
>>
>> Hello,
>>
>>     I have hardware that suffers from an internal phase inverted mic that
>> isn't properly detected. Below is a patch that fixes the issue for my
>> particular hardware.
>>
>> Pre patch alsa-info:
>>
>> http://www.alsa-project.org/db/?f=a922c77ddf473a8f478ec334fa9dca684f213b59
>>
>> Post patch alsa-info:
>> http://www.alsa-project.org/db/?f=14cd25b323d3bbb02fabbac78e62851569893c3f
>>
>> Incase you care. The patch is small. I don't know if you need any kind
>> of signed off/written by etc for something so small. In any case there
>> is no intellectual property in this at all. Feel free to do as you wish
>> with it. However including it in the kernel would make my life easier.
>
> Thanks, I fixed it in sound git tree now.
>
>
> Takashi
>
>>
>> Thanks,
>> --
>> Nathanael d. Noblet
>> t 403.875.4613
>> [2 alsa-realtek-inverted-mic.patch <text/x-patch (7bit)>]
>> --- a/sound/pci/hda/patch_realtek.c.org	2013-08-15 13:17:49.804492932 -0600
>> +++ b/sound/pci/hda/patch_realtek.c	2013-08-15 13:18:40.582364931 -0600
>> @@ -4208,6 +4208,7 @@
>>   	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
>>   	SND_PCI_QUIRK(0x19da, 0xa130, "Zotac Z68", ALC662_FIXUP_ZOTAC_Z68),
>>   	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
>> +    SND_PCI_QUIRK(0x1025, 0x034a, "Gateway LT27", ALC662_FIXUP_INV_DMIC),
>>
>>   #if 0
>>   	/* Below is a quirk table taken from the old code.
>


-- 
Nathanael d. Noblet
t 403.875.4613

--------------060706030203010406020903
Content-Type: text/x-patch;
 name="alsa-realtek-inverted-mic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsa-realtek-inverted-mic.patch"

--- a/sound/pci/hda/patch_realtek.c	2013-08-15 13:17:49.804492932 -0600
+++ b/sound/pci/hda/patch_realtek.c	2013-08-15 15:17:46.390273328 -0600
@@ -4208,6 +4208,8 @@
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x19da, 0xa130, "Zotac Z68", ALC662_FIXUP_ZOTAC_Z68),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
+	SND_PCI_QUIRK(0x1025, 0x034a, "Gateway LT27", ALC662_FIXUP_INV_DMIC),
+	SND_PCI_QUIRK(0x1025, 0x022f, "Acer Aspire One", ALC662_FIXUP_INV_DMIC),
 
 #if 0
 	/* Below is a quirk table taken from the old code.

--------------060706030203010406020903--
