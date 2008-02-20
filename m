From: =?ISO-8859-1?Q?Anders_R=F8nningen?= <andersronningen@gmail.com>
Subject: Re: Problem with DELL XPS M1530
Date: Wed, 20 Feb 2008 16:14:43 +0100
Message-ID: <47BC43E3.5010501@gmail.com>
References: <mailman.1.1203505202.15472.alsa-devel@alsa-project.org>	<194b8d500802200430j2be27899vf5ae8a2ddaca7389@mail.gmail.com>
	<s5hablvsque.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id EE03F2438E
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 16:14:49 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so857613nfd.32
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 07:14:46 -0800 (PST)
In-Reply-To: <s5hablvsque.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, anders.ronningen@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi again. Here's the results of the testing.

1. alsa-driver-hg20080217, --with-debug=full and the 
"SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022e, "Dell     ", 
STAC_DELL_BIOS)," line in patch_sigmatel.c commented out.

dmesg output:

[   13.844000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:2994: 
autoconfig: line_outs=1 (0xf/0x0/0x0/0x0/0x0)
[   13.844000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:2998:    
speaker_outs=1 (0xd/0x0/0x0/0x0/0x0)
[   13.844000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3002:    
hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
[   13.844000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3003:    
mono: mono_out=0x0
[   13.844000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/hda_codec.c:3011:    
inputs: mic=0x13, fmic=0x0, line=0xe, fline=0x0, cd=0x0, aux=0x0
[   13.844000] ALSA 
/mnt/storage/source/alsa/alsa-driver-hg20080217/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2224: 
dac_nids=2 (0x5/0x4/0x0/0x0/0x0)

alsa-info.sh

http://pastebin.ca/911134

2. alsa-driver 1.0.16, --with-debug=full, but else unmodified.

dmesg output:

[   14.452000] ALSA 
/mnt/storage/source/alsa/alsa-driver-1.0.16/pci/hda/hda_codec.c:2894: 
autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
[   14.452000] ALSA 
/mnt/storage/source/alsa/alsa-driver-1.0.16/pci/hda/hda_codec.c:2898:    
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   14.452000] ALSA 
/mnt/storage/source/alsa/alsa-driver-1.0.16/pci/hda/hda_codec.c:2902:    
hp_outs=2 (0xf/0xa/0x0/0x0/0x0)
[   14.452000] ALSA 
/mnt/storage/source/alsa/alsa-driver-1.0.16/pci/hda/hda_codec.c:2903:    
mono: mono_out=0x0
[   14.452000] ALSA 
/mnt/storage/source/alsa/alsa-driver-1.0.16/pci/hda/hda_codec.c:2911:    
inputs: mic=0xe, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
[   14.456000] ALSA 
/mnt/storage/source/alsa/alsa-driver-1.0.16/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2212: 
dac_nids=3 (0x5/0x2/0x4/0x0/0x0)

alsa-info.sh

http://pastebin.ca/911147

Now the odd thing is that after the last compile of alsa-driver 1.0.16 
... stuff works! Both HP jacks, the internal speakers and the mic work 
just fine. I don't really know what to make of it, since all I have done 
is compile like I did earlier and reboot...


- Anders

Takashi Iwai wrote:
> At Wed, 20 Feb 2008 13:30:06 +0100,
> =?ISO-8859-1?Q?Anders_R=F8nningen?= wrote:
>   
>> I'll do the tests when I get home from work. Just wanted to check that I
>> understood the instructions.
>>
>> The problem is like you said. The left HP and the internal speakers never
>> give any sound, regardless of whether the right HP is connected.
>>
>> You want me to:
>> 1. remove the mentioned line from alsa-kernel/pci/hda/patch_sigmatel.c.
>> 2. configure and build the driver with full debug
>> 3. reboot, run alsa-info.sh and upload the output
>>
>> Is that right?
>>     
>
> Yes.
>
>   
>>> No difference in the output but there must be a difference in the codec
>>>       
>> setting.
>> You mean before and after I remove the line from patch_sigmatel.c?
>>     
>
> In each case whatever you change something.  I have to check the codec
> state whether the surround volume really does the right job as
> expected. 
> Also, we need to check the state with and without the code in
> patch_sigmatel.c, with and without HP plugged.
>
> Also, try the original 1.0.16 and get alsa-info.sh as well.
>
> Yeah, there are lots of required tests.  That's why it's so nasty to
> debug this kind of problem...
>
>   
>>> What is the original configuration of pin 0xf?
>>>       
>> How can I know/find out this?
>>     
>
> This can be found from alsa-info.sh.
>
>
> thanks,
>
> Takashi
>   
