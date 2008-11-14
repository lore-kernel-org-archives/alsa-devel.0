From: Manuel Naranjo <manuel@aircable.net>
Subject: Re: Mute Beep (was Regression on alsa-driver-1.0.18a
 on HDA for Dell Inspiron 1521)
Date: Fri, 14 Nov 2008 10:34:16 -0200
Message-ID: <491D7048.9070401@aircable.net>
References: <a10be5a00811120606s12672837secdda91b80659ac8@mail.gmail.com>	<491AE402.3030507@aircable.net>	<s5hk5b9jaim.wl%tiwai@suse.de>	<491AE7F3.2040203@aircable.net>	<s5h7i79j8k8.wl%tiwai@suse.de>	<Pine.LNX.4.61.0811121603350.13649@tm8103.perex-int.cz>	<s5hzlk5htlu.wl%tiwai@suse.de>	<491B2603.9070802@aircable.net>	<s5hwsf7hlyz.wl%tiwai@suse.de>	<s5hfxlvheio.wl%tiwai@suse.de>	<491CDF89.4030907@aircable.net>
	<s5hiqqqk895.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id D73101037F3
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 13:33:52 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so1463807rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 04:33:51 -0800 (PST)
In-Reply-To: <s5hiqqqk895.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Could you check the debug messages with the patch below?
>
>
> thanks,
>
> Takash
Sure no problem. I'm not getting any GENERATE BEEP, or BEEP EVENT on 
dmesg, just the enable disable when I press the enable disable button. 
The switch reflects the correct state.

I've gone through the patch over and over, but I can't figure out why 
would it stop working. Shouldn't the switch alert the beep part about 
changes?

Also how should I test? I tried with 'echo -e "\\a"', beep and the old 
way that was driving me crazy (pressing del in pidgin when there's no 
more text).

Anyway here's the log just in case:
snd: Not freed snd_alloc_kmalloc = 18
snd: kmalloc(9) from f8ed1d9a not freed
snd: kmalloc(9) from f8ed1d9a not freed
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:2596: 
hda_codec: model 'dell-m42' is selected
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3312: 
autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3316:    
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3320:    
hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3321:    
mono: mono_out=0x0
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3329:    
inputs: mic=0xb, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
ALSA 
/home/manuel/tmp/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2786: 
dac_nids=1 (0x10/0x0/0x0/0x0/0x0)
input: HDA Digital PCBeep as /class/input/input18
input: HDA ATI SB at 0xfebfc000 irq 16 Mic at Ext Left Jack as 
/class/input/input19
input: HDA ATI SB at 0xfebfc000 irq 16 HP Out at Ext Left Jack as 
/class/input/input20
hda-intel: Invalid position buffer, using LPIB read method instead.
XXX BEEP SW 0
XXX BEEP SW 1
