From: Todd Dailey <todd@todddailey.ca>
Subject: Re: No sound from Mac Pro headphone port
Date: Wed, 17 Jun 2015 11:28:36 -0400
Message-ID: <55819224.5090105@todddailey.ca>
References: <554CC0EC.5000506@todddailey.ca>
 <CAN8cciYJdMeKyYL1mqUkN3bKmEhwqHN1-pZzCvBDazBPKdH7vw@mail.gmail.com>
 <554CCCAF.6000608@todddailey.ca>
 <CAN8cciaSiJBr4RKP6Rj3JurnrPEGufBsnLEACdvrhRLcRfPkcg@mail.gmail.com>
 <5555460D.3060907@todddailey.ca>
 <CAN8cciaEdt3zM_V7M4_8YVBHrs+GQsfs1jV32owfsR_2oO52AA@mail.gmail.com>
 <CAN8cciaepxbsuprm+EFr4jE24so1-WMnNDOfdQQPaM9AsK2hNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yonca.sibername.com (yonca.sibername.com [67.212.91.121])
 by alsa0.perex.cz (Postfix) with ESMTP id C5722260483
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 17:28:48 +0200 (CEST)
Received: from 23-248-0-172.tpia.execulink.com ([23.248.0.172]:46429
 helo=[192.168.1.190])
 by yonca.sibername.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
 (Exim 4.85) (envelope-from <todd@todddailey.ca>) id 1Z5FGT-0001ZT-Lz
 for alsa-devel@alsa-project.org; Wed, 17 Jun 2015 11:28:39 -0400
In-Reply-To: <CAN8cciaepxbsuprm+EFr4jE24so1-WMnNDOfdQQPaM9AsK2hNQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Has there been any progress on fixing this issue?

It seems that no matter what combination of settings I try with 
hdajackretask, I cannot get sound from the headphone port.

Jack in / out plugged status is correctly detected. However, selecting 
Headphones for output plays sound from the Line Out port. The Line Out 
port selection works as expected. I can set separate volume levels for 
both Headphone and Line Out but both selections play through the Line 
Out port.

I'm surprised that this is so difficult to get right. Both OS X and 
Windows control all ports perfectly.


-- 
TD
todd@todddailey.ca

On 14/05/15 11:57 PM, Raymond Yau wrote:
>
>  >
>  > You will need to provide more specific instructions on what you want.
> I do not read code.
>  >
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=29ebe40284c75a5888c601872059fca7e258528d
>
>  >>
>  >>
>  >>     Bingo: the pin-outs are very incorrect.
>  >>
>  >>     This is the (original) tech specs of the machine.
>  >>
>  >> https://support.apple.com/kb/SP506?viewlocale=en_US&locale=en_US
> <https://support.apple.com/kb/SP506?viewlocale=en_US&locale=en_US>
>  >>
>  >>     Note:
>  >>
>  >>     1 x internal speaker
>  >>     1 x FRONT headphone port
>  >>
>  >>
>  >> Refer to user manual ,
>  >> Headphone Jack
>  >> Connect headphones, including Apple Earphone with remote and mic through
>  >> the headphone mini jack
>  >>
>  >> Is node 0x18  headset mic ?
>  >> need specific sequence number and parser_flags
>  >>
>  >>https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=cb420b1186e0090f24137855e14e6f3bf7cb769d <https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=cb420b1186e0090f24137855e14e6f3bf7cb769d>
>  >>
>  >> +#define HDA_PINCFG_HEADSET_MIC   (1 << 2) /* Try to find headset mic;
>  >> mark seq number as 0xc to trigger */
>  >>
>  >>     1 x REAR line out port
>  >>
>  >>     1 x REAR line in port
>  >>     1 x REAR optical TOSLINK out port
>  >>     1 x REAR optical TOSLINK in port
>  >>
>  >>     The machine does not have a built-in mic port.
>  >>
>  >>
>  >> you need to use hdajacksensetest to verify hp, line out , line in jacks
>  >> are node 0x19, 0x14 and 0x1a by plug and unplug those jacks
>  >>
>  >> clear bit 8 of pin default of Line Out Jack if it return correct
> jack state
>  >>
>  >>
>  >>
>  >>              Linux 4. Mac Pro 2009. ACL889A codec.
>  >>
>  >>              No sound from headphone port. Seems to detect plug /
> unplug OK.
>  >>
>  >>              Works OK when machine booted to OS X or Windows 7.
>  >>
>  >>              Have found several bug repors on similar issues with Mac
>  >>         laptops but
>  >>              no fixes.
>  >>
>  >>              Have written e-mail with David Henningsson on problem but
>  >>         unable to
>  >>              find a solution.
>  >>
>  >>              ALSA-info output:
>  >>
>  >>
> http://www.alsa-project.org/db/?f=1dc7146eb34af5ad307d029868f775fac5e2764e
> <http://www.alsa-project.org/db/?f=1dc7146eb34af5ad307d029868f775fac5e2764e>
>  >>
>  >>
>  >>         Do your macpro spec support 5.1 ?
>  >>
>  >>         Simple mixer control 'Channel Mode',0
>  >>             Capabilities: enum
>  >>             Items: '2ch' '4ch' '6ch'
>  >>             Item0: '2ch'
>
> Channel mode is created when there are three or more jacks at same location
>
> Use hdajackretask to change location of HP and Mic from Ext Rear to Ext
> Front
>
> Advanced override and set as boot default
>
> http://git.alsa-project.org/?p=alsa-tools.git;a=blob;f=hdajackretask/README;hb=HEAD
>
> http://voices.canonical.com/david.henningsson/2011/11/29/turn-your-mic-jack-into-a-headphone-jack/
>
> http://git.alsa-project.org/?p=alsa-tools.git;a=tree;f=hdajacksensetest;hb=HEAD
>
> Use hdajacksensetest -a to verify line out support jack detect
>
> clear MISC = NO_PRESENCE bit 8 of pin default of Line out by hdajackretask
>
> Pin Default 0x01010050: [Jack] Line Out at Ext Rear
>      Conn = 1/8, Color = Unknown
>      DefAssociation = 0x5, Sequence = 0x0
>
> Most likely need vendor coefficient to support mono  mic of apple earphones
>
>  >>
>  >>         Pin default seem incorrect
>  >>
>  >>         1) Headphone at ext Rear
>  >>         2) Line Out does not support jack detection
>  >>         3) Mic jack ????
>  >>
>  >>         /sys/class/sound/hwC0D0/init_pin_configs:
>  >>         0x14 0x01010150
>  >>         0x15 0x400000f0
>  >>         0x16 0x400000f0
>  >>         0x17 0x400000f0
>  >>         0x18 0x01a19070
>  >>         0x19 0x01214040
>  >>         0x1a 0x01813010
>  >>         0x1b 0x90100130
>  >>         0x1c 0x400000f0
>  >>         0x1d 0x400000f0
>  >>         0x1e 0x0145e160
>  >>         0x1f 0x01c5e120
>  >>
>  >>         /sys/class/sound/hwC0D0/driver_pin_configs:
>  >>
>  >>
>  >>
>  >>         [    4.057250] sound hdaudioC0D0: ALC889A: SKU not ready
> 0x400000f0
>  >>         [    4.057633] sound hdaudioC0D0: autoconfig for ALC889A:
>  >>         line_outs=1
>  >>         (0x14/0x0/0x0/0x0/0x0) type:line
>  >>         [    4.057636] sound hdaudioC0D0:    speaker_outs=1
>  >>         (0x1b/0x0/0x0/0x0/0x0)
>  >>         [    4.057638] sound hdaudioC0D0:    hp_outs=1
>  >>         (0x19/0x0/0x0/0x0/0x0)
>  >>         [    4.057639] sound hdaudioC0D0:    mono: mono_out=0x0
>  >>         [    4.057641] sound hdaudioC0D0:    dig-out=0x1e/0x0
>  >>         [    4.057642] sound hdaudioC0D0:    inputs:
>  >>         [    4.057645] sound hdaudioC0D0:      Mic=0x18
>  >>         [    4.057646] sound hdaudioC0D0:      Line=0x1a
>  >>         [    4.057648] sound hdaudioC0D0:    dig-in=0x1f
>  >>
>  >>
>
