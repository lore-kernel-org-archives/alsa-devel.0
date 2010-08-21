From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: aplay -l  vs.  aplay -L: Missing PCMs?
Date: Sat, 21 Aug 2010 07:56:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008210751000.10278@eeebox2.perex-int.cz>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE376614@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008200802560.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE376668@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008202215590.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE376692@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 775DB103837
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Aug 2010 07:56:29 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF02FE376692@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Aug 2010, Stephen Warren wrote:

> Jaroslav Kysela wrote:
>>
>> On Fri, 20 Aug 2010, Stephen Warren wrote:
>>
>>> Jaroslav Kysela wrote:
>>>>
>>>> On Thu, 19 Aug 2010, Stephen Warren wrote:
>>>>
>>>>> The Azalia controller on NVIDIA GPUs gives 4 ALSA hw devices:
>>>>>
>>>>> (on card 1):
>>>>>
>>>>> [swarren@swarren-lx2 ~]$ sudo aplay -l
>>>>> << includes hw=1,3 hw=1,7 hw=1,8 hw=1,9 >>
>>>>> ... all of which appear to work OK.
>>>>>
>>>>> However, the list of available "PCMs" from aplay -L doesn't expose them all:
>>>>>
>>>>> [swarren@swarren-lx2 ~]$ sudo aplay -L
>>>>> <<card 0 "Nvidia" elided>>
>>>>> hdmi:CARD=NVidia_1
>>>>>    HDA NVidia, NVIDIA HDMI
>>>>>    HDMI Audio Output
>>>>>
>>>>> Instead, I imagined that I'd see 4 PCMs listed by "aplay -L"; one for each
>>>>> converter. Is this an incorrect assumption? How would I make that happen?
>>>>
>>>> There is a bug in alsa-lib to namehint.c. The code assumes that hw device
>>>> number is similar to logical device numbers which is not true in case of
>>>> your HDMI devices:
>>>>
>>>> 3, 7, 8, 9
>>>>
>>>> The fallback code is used and only first logical device 0 is created.
>>>>
>>>> Could you test this patch?
>>>>
>>>> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=97d25c0766405453d3c298bd51dd4916121a4f6a
>>>
>>> I tested that, and unfortunately it doesn't seem to work; I get the exact same
>>> aplay -L output.
>>>
>>> I debugged this a little, and see that add_card() is calculating the correct
>>> max_devices value for card=1 str=hdmi. However, in the loop that right after
>>> that calls try_config, when device=0, it returns 0, but when device=1, it
>>> returns -2 (-ENOENT). This happens inside try_config where it calls
>>> snd_config_search_definition (line 244 in latest git). At that point, buf is:
>>>
>>> hdmi:CARD=NVidia_1,DEV=1
>>>
>>> ... which seems reasonable.
>>>
>>> I'm a little confused about the device numbering though: The max_devices
>>> value is counting values "3, 7, 8, 9" and hence gets 9. However, the
>>> loop that calls try_config loops 0..max_devices-1, but bails out as soon
>>> as any error is found, thus disallowing "holes" in the numbering. That
>>> implies that "device" in that loop is a different numbering space? After
>>> I noticed that, I hacked that loop to continue instead of break on
>>> errors, and also removed the "err >= 0" condition from the loop,
>>> expecting that when device==3/7/8/9, try_config might work. In fact, 0
>>> still works (of course) and 1..8 all fail with err=-2, so I assume at
>>> the same place in try_config.
>>
>> See my description. It's assumed that the logical devices
>> (hdmi:DEV=<logical_device>) are continous. Does
>> 'aplay -D hdmi:CARD=NVidia_1,DEV=1' work in your system?
>
> Sure, the logical device IDs should be contiguous. But then, I don't see why
> the code would need to calculate max_devices (which is max HW device ID and
> hence something other than logical device ID). Anyway...

There is no way to get the maximum logical device number at the moment.
We can add some variables to the configuration files in future. The code
just assumes that logical numbers does not go above the maximum hw device 
number.

> [swarren@swarren-lx2 ~]$ aplay -D hw:1,7 Shamisen-C4.wav
> Playing WAVE 'Shamisen-C4.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
>
> [swarren@swarren-lx2 ~]$ aplay -D hdmi:CARD=NVidia_1,DEV=1 
> Shamisen-C4.wav ALSA lib confmisc.c:1286:(snd_func_refer) Unable to find 
> definition 
> 'cards.HDA-Intel.pcm.hdmi.1:CARD=NVidia_1,AES0=4,AES1=130,AES2=0,AES3=2'

Have you updated the HDA-Intel.conf file in the /usr/share/alsa/cards 
directory? There should be definition of:

HDA-Intel.pcm.hdmi.1 {
         @args [ CARD AES0 AES1 AES2 AES3 ]
         @args.CARD { type string }
         @args.AES0 { type integer }
         @args.AES1 { type integer }
         @args.AES2 { type integer }
         @args.AES3 { type integer }
         @func refer
         name {

....

}

This addition is recent:

commit e6d5dcf1f625984605d362338d71162de45a6c60
Author: Anssi Hannula <anssi.hannula@iki.fi>
Date:   Tue Aug 3 20:27:49 2010 +0300

     HDA-Intel: present all 4 HDMI outputs instead of just the first one

     Commit 92608badc519a8c1f65d93743396517aaa582b53 in linux kernel added
     the possibility of 3 additional HDMI devices on indexes 7-9.

     Present all those additional devices using the "hdmi" alias as well.

     Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
     Signed-off-by: Takashi Iwai <tiwai@suse.de>

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
