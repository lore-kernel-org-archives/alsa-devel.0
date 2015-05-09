From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: No sound from Mac Pro headphone port
Date: Sat, 9 May 2015 21:07:01 +0800
Message-ID: <CAN8cciaSiJBr4RKP6Rj3JurnrPEGufBsnLEACdvrhRLcRfPkcg@mail.gmail.com>
References: <554CC0EC.5000506@todddailey.ca>
 <CAN8cciYJdMeKyYL1mqUkN3bKmEhwqHN1-pZzCvBDazBPKdH7vw@mail.gmail.com>
 <554CCCAF.6000608@todddailey.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 39B5F260504
 for <alsa-devel@alsa-project.org>; Sat,  9 May 2015 15:07:02 +0200 (CEST)
Received: by oift201 with SMTP id t201so76898346oif.3
 for <alsa-devel@alsa-project.org>; Sat, 09 May 2015 06:07:01 -0700 (PDT)
In-Reply-To: <554CCCAF.6000608@todddailey.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Todd Dailey <todd@todddailey.ca>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2015-05-08 22:48 GMT+08:00 Todd Dailey <todd@todddailey.ca>:

> Bingo: the pin-outs are very incorrect.
>
> This is the (original) tech specs of the machine.
>
> https://support.apple.com/kb/SP506?viewlocale=en_US&locale=en_US
>
> Note:
>
> 1 x internal speaker
> 1 x FRONT headphone port
>

Refer to user manual ,
Headphone Jack
Connect headphones, including Apple Earphone with remote and mic through
the headphone mini jack

Is node 0x18  headset mic ?
need specific sequence number and parser_flags

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=cb420b1186e0090f24137855e14e6f3bf7cb769d

+#define HDA_PINCFG_HEADSET_MIC   (1 << 2) /* Try to find headset mic; mark
seq number as 0xc to trigger */


> 1 x REAR line out port
>
1 x REAR line in port
> 1 x REAR optical TOSLINK out port
> 1 x REAR optical TOSLINK in port
>
> The machine does not have a built-in mic port.
>

you need to use hdajacksensetest to verify hp, line out , line in jacks are
node 0x19, 0x14 and 0x1a by plug and unplug those jacks

clear bit 8 of pin default of Line Out Jack if it return correct jack state


> Should have noted, if not clear from the physical ports, no, the machine
does not have outputs for 5.1 surround sound.


http://www.intel.com/support/motherboards/desktop/sb/CS-034206.htm


you can enable multi-streaming by indep_hp=1

>
>
>>     Linux 4. Mac Pro 2009. ACL889A codec.
>>
>>     No sound from headphone port. Seems to detect plug / unplug OK.
>>
>>     Works OK when machine booted to OS X or Windows 7.
>>
>>     Have found several bug repors on similar issues with Mac laptops but
>>     no fixes.
>>
>>     Have written e-mail with David Henningsson on problem but unable to
>>     find a solution.
>>
>>     ALSA-info output:
>>
>>
>> http://www.alsa-project.org/db/?f=1dc7146eb34af5ad307d029868f775fac5e2764e
>>
>>
>> Do your macpro spec support 5.1 ?
>>
>> Simple mixer control 'Channel Mode',0
>>    Capabilities: enum
>>    Items: '2ch' '4ch' '6ch'
>>    Item0: '2ch'
>>
>> Pin default seem incorrect
>>
>> 1) Headphone at ext Rear
>> 2) Line Out does not support jack detection
>> 3) Mic jack ????
>>
>> /sys/class/sound/hwC0D0/init_pin_configs:
>> 0x14 0x01010150
>> 0x15 0x400000f0
>> 0x16 0x400000f0
>> 0x17 0x400000f0
>> 0x18 0x01a19070
>> 0x19 0x01214040
>> 0x1a 0x01813010
>> 0x1b 0x90100130
>> 0x1c 0x400000f0
>> 0x1d 0x400000f0
>> 0x1e 0x0145e160
>> 0x1f 0x01c5e120
>>
>> /sys/class/sound/hwC0D0/driver_pin_configs:
>>
>>
>>
>> [    4.057250] sound hdaudioC0D0: ALC889A: SKU not ready 0x400000f0
>> [    4.057633] sound hdaudioC0D0: autoconfig for ALC889A: line_outs=1
>> (0x14/0x0/0x0/0x0/0x0) type:line
>> [    4.057636] sound hdaudioC0D0:    speaker_outs=1 (0x1b/0x0/0x0/0x0/0x0)
>> [    4.057638] sound hdaudioC0D0:    hp_outs=1 (0x19/0x0/0x0/0x0/0x0)
>> [    4.057639] sound hdaudioC0D0:    mono: mono_out=0x0
>> [    4.057641] sound hdaudioC0D0:    dig-out=0x1e/0x0
>> [    4.057642] sound hdaudioC0D0:    inputs:
>> [    4.057645] sound hdaudioC0D0:      Mic=0x18
>> [    4.057646] sound hdaudioC0D0:      Line=0x1a
>> [    4.057648] sound hdaudioC0D0:    dig-in=0x1f
>>
>>
