From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/5] allow up to 32 PCM devices
Date: Wed, 12 May 2010 12:20:33 +0200
Message-ID: <4BEA80F1.7040600@ladisch.de>
References: <20100512013015.752623810@intel.com>	<20100512015713.762299923@intel.com>	<alpine.LNX.2.00.1005120925400.6856@eeebox2.perex-int.cz>	<s5htyqdsg0w.wl%tiwai@suse.de>
	<20100512083950.GB11001@localhost> <s5hbpclsdbu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A634824153
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 12:20:37 +0200 (CEST)
In-Reply-To: <s5hbpclsdbu.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Wu Fengguang wrote:
> > > Jaroslav Kysela wrote:
> > > > I don't agree to have only 4 slots for soundcards in the static minor 
> > > > numbering. Maybe the driver should be converted to use subdevices or we 
> > > > might drop the static minor number allocation at all (it might have only 
> > > > impact for old distros).
> > 
> > Jaroslav, will there be so many sound cards in one system?
> 
> In the old time, yes.  Now we have less and less PCI slots.
> In theory, we may have lots of USB audio devices, though :)

I implemented CONFIG_SND_DYNAMIC_MINORS because people had been asking
for more than eight cards.  (And by now I have lots of cards too,
although my computer probably isn't very typical.)

Anyway, static numbering is needed only for systems without udev/devfs,
and there we shouldn't change it for backwards compatibility.  The HDA
driver already requires kernels >= 2.6, so I don't see a problem with
requiring CONFIG_SND_DYNAMIC_MINORS to get all HDMI outputs.

> Another possible solution would be to change the minor number
> assignment to a really dynamic one.  So far, due to legacy /dev/aload
> and co, we have some static restriction per card basis.

What restriction would that be?  With CONFIG_SND_DYNAMIC_MINORS, we
don't allocate minors that would be used by /dev/aload*, but there are
no restrictions on the number of cards or devices.


-- 
Regards,
Clemens


cat /proc/asound/cards
 0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xfe7f4000 irq 16
 1 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xfe9e8000 irq 19
 2 [D2             ]: AV200 - Xonar D2
                      Asus Virtuoso 200 (rev 2) at 0xe800, irq 20
 3 [YMF754         ]: YMF754 - Yamaha DS-1E (YMF754)
                      Yamaha DS-1E (YMF754) at 0xfebf8000, irq 22
 4 [UA1A           ]: USB-Audio - EDIROL UA-1A
                      Roland EDIROL UA-1A at usb-0000:00:12.2-4.3, full speed
 5 [SC8820         ]: USB-Audio - SC-8820
                      Roland SC-8820 at usb-0000:00:13.0-2, full speed
 6 [UM2            ]: USB-Audio - UM-2
                      EDIROL UM-2 at usb-0000:00:12.0-2, full speed
 7 [NX             ]: USB-Audio - SB Audigy 2 NX
                      Creative Technology Ltd SB Audigy 2 NX at usb-0000:00:12.2-3, high speed
 8 [UART16550A     ]: Serial - Serial MIDI (UART16550A)
                      Serial MIDI (UART16550A) [Soundcanvas] at 0x3f8, irq 4
 9 [VirMIDI        ]: VirMIDI - VirMIDI
                      Virtual MIDI Card 1
10 [Dummy          ]: Dummy - Dummy
                      Dummy 1
11 [Live           ]: EMU10K1 - SB Live! Value [CT4670]
                      SB Live! Value [CT4670] (rev.5, serial:0x201102) at 0xec00, irq 21
12 [pcsp           ]: PC-Speaker - pcsp
                      Internal PC-Speaker at port 0x61
13 [AudioFire2     ]: FireWorks - AudioFire2
                      Echo Digital Audio AudioFire2 (v3.2) at fw1.0, S400
