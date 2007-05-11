From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Fri, 11 May 2007 23:42:48 +0200
Message-ID: <4644E358.8090601@gmail.com>
References: <20070511164410.96BA11BF281@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 354FF244DC
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 23:45:21 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so667151ugf
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 14:45:20 -0700 (PDT)
In-Reply-To: <20070511164410.96BA11BF281@ws1-1.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ramkromberg@mail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/11/2007 06:44 PM, ramkromberg@mail.com wrote:

> o, I thought the epprom settings are default until the
> driver kicks in...

Only if you set the JMPCFG jumper to EEPROM; otherwise the card's just dead 
in the water until software enables it (by writing to some specific I/O 
port; not sure which).

> So I set the jumpers accordingly and still no luck:
> IDESEL: 1-2 (Disabled - Its the CD IDE ON\OFF)
> JMPCFG: 1-2 (EPPROM ON)
> JMPB0: 1-2 (22XH)
> IDEIRQ: 1 (IRQ 15 - shouldn't make a different)
> JX1: 2-3 (Carbon MIC - again just letting you know though it shouldn't 
> make a different)
> 
> This should make sense with the picture I sent earlier...
> I also removed another card I had connected - ISA Modem, Just making 
> sure their are no conflicts...
> 
> Here's the grim results:
> 
> sudo modprobe snd-sb8 port=0x220 irq=5 dma8=1
> FATAL: Error inserting snd_sb8 
> (/lib/modules/2.6.20-15-generic/kernel/sound/isa/sb/snd-sb8.ko): No such 
> device

Okay, that's unfortunate. It works fine here with my AZT2316R and AZT1605 cards.

1. Did you restore the default settings to the EEPROM with "HWSET /MR /MS"?

If an "EEPROM.SYS" is being loaded from your CONFIG.SYS in the DOS setup 
also try that HWSET after rebooting with that line commented out. maybe it's 
interfering (EEPROM.SYS is the "software" that takes on the role of the 
physical EEPROM when you have the JMPCFG jumper set to "software").

2. What do the last few lines of "dmesg" say after the modprobe?

3. Both my AZT2316A cards actually needed the JMPCFG jumper set to the 
"software" setting to even have the DSP show up at 0x220 which seems like it 
just might be a strange fluke. But if it really won't work, try the HWSET 
and loading of the snd-sb8 driver also with the JMPCFG jumper switched again...

Don't seem to have more bright ideas...

Rene.
