From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: /dev/snd/seq unavailable with opl3 (Re: [RFC]
 ymfpci - re-enable legacy audio after suspend resume)
Date: Thu, 15 Mar 2012 08:41:48 +0800
Message-ID: <CAN8cciZpDMCF-nwbC7jzFrw+qOfi4oE0zSGDQ02D_fu4KV4wPg@mail.gmail.com>
References: <CAN8ccibfK6Cpho5F5vk8jq_gbZQKp4_C3bMcZ6Ef4c+TU2=EBQ@mail.gmail.com>
	<s5h399jpohv.wl%tiwai@suse.de>
	<CAN8ccia-mdoS4w5FHN_0tPnuCzfi2HaDb4nhZ3TdvV-8OezBvA@mail.gmail.com>
	<s5hboo6nvq9.wl%tiwai@suse.de>
	<CAN8ccib6ki86e9At-umn6nPCLa-ub4E8Gv0p2gHp=ApeEy=Lvg@mail.gmail.com>
	<s5h7gyqw7d2.wl%tiwai@suse.de>
	<CAN8ccib8=gE=A-VaJJx619h+WM1Eh1gZTNrWiEnxmdQ0umgQ7w@mail.gmail.com>
	<s5h4nts3b1j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CAF0124421
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 01:41:48 +0100 (CET)
Received: by wibhn6 with SMTP id hn6so2796335wib.2
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 17:41:48 -0700 (PDT)
In-Reply-To: <s5h4nts3b1j.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2012/3/13, Takashi Iwai <tiwai@suse.de>:
> At Tue, 13 Mar 2012 19:34:41 +0800,
> Raymond Yau wrote:
>>
>> 2012/3/12, Takashi Iwai <tiwai@suse.de>:
>> > At Sun, 11 Mar 2012 07:37:30 +0800,
>> > Raymond Yau wrote:
>> >>
>> >> 2012/3/9 Takashi Iwai <tiwai@suse.de>:
>> >> > At Fri, 9 Mar 2012 07:28:26 +0800,
>> >> > Raymond Yau wrote:
>> >> >>
>> >> >> 2012/3/8, Takashi Iwai <tiwai@suse.de>:
>> >> >> > At Thu, 8 Mar 2012 12:12:33 +0800,
>> >> >> > Raymond Yau wrote:
>> >> >> >>
>> >> >> >> Since the Legacy Audio Control register is reset to default after
>> >> >> >> suspend resume cycle
>> >> >> >>
>> >> >> >> need to enable the Legacy Audio Control Bit in order to use OPL3
>> >> >> >> FM
>> >> >> >> Synth
>> >> >> >>
>> >> >> >> however it is still need to use sbiload  instrument loader to
>> >> >> >> reload
>> >> >> >> the instruments
>> >> >> >
>> >> >> > Isn't it better to save and restore these PCI registers like
>> >> >> > below?
>> >> >> > It still doesn't solve the lost instrument problem, though.
>> >> >> >
>> >> >>
>> >> >> I only use std.o3 and drums.o3
>> >> >>
>> >> >> It seem that the playback of midi using aplaymidi can resume
>> >> >> playback
>> >> >> after suspend with my ymf724f
>> >> >>
>> >> >> so it seem that there is no need to reload the instrument with your
>> >> >> patch
>> >> >>
>> >> >> >
>> >> >> > ---
>> >> >> > diff --git a/include/sound/ymfpci.h b/include/sound/ymfpci.h
>> >> >> > index 444cd6b..1e35b16 100644
>> >> >> > --- a/include/sound/ymfpci.h
>> >> >> > +++ b/include/sound/ymfpci.h
>> >> >> > @@ -366,6 +366,8 @@ struct snd_ymfpci {
>> >> >> >  #ifdef CONFIG_PM
>> >> >> >     u32 *saved_regs;
>> >> >> >     u32 saved_ydsxgr_mode;
>> >> >> > +   u16 saved_saved_dsxg_legacy;
>> >> >> > +   u16 saved_saved_dsxg_elegacy;
>> >> >>
>> >> >>
>> >> >> Should be saved_dsxg_legacy and save_dsxg_elegacy.
>> >> >
>> >> > Err, of course.
>> >> >
>> >> >> How can this change back port to 2.6 kernel ?
>> >> >
>> >> > I guess the patch can be applied as is.  There have been no big
>> >> > changes
>> >> > in that driver since ages.
>> >> >
>> >> >
>> >>
>> >> This patch may be useless when oss is disabled in kernel 3.x
>> >>
>> >> aplaymidi -l
>> >> open /dev/snd/seq failed: No such file or directory
>> >>
>> >> it only happen with snd-ymfpci  when there oss is disabled
>> >
>> > This is a different problem.  Please don't mix up.
>> >
>> > Is CONFIG_SND_OPL3_LIB_SEQ=y in your kernel config?
>> >
>> >
>> > Takashi
>> >
>>
>> config1.h:#define CONFIG_SND_OPL3_LIB_SEQ_MODULE 1
>> linux/autoconf.h:#define CONFIG_SND_OPL3_LIB_SEQ_MODULE 1
>>
>> http://thread.gmane.org/gmane.linux.alsa.devel/6363
>
> This sounds irrelevant from the probing problem.

seem fix by modprobe snd_seq

I know understand why this solve the problem

Neither mpu401 nor gameport are available in linux or windows for ymf724f

but opl3 fm can be used

does it need IRQ 9 or 16 bit io address for legacy port for mpu401 and
gameport ?

cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0071 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0290-0297 : pnp 00:07
0388-038b : YMFPCI OPL3
03c0-03df : vga+
03f8-03ff : serial
0400-041f : 0000:00:1f.3
  0400-041f : i801_smbus
0480-04bf : 0000:00:1f.0
  0480-04bf : pnp 00:08
04d0-04d1 : pnp 00:08
0800-087f : 0000:00:1f.0
  0800-087f : pnp 00:08
    0800-0803 : ACPI PM1a_EVT_BLK
    0804-0805 : ACPI PM1a_CNT_BLK
    0808-080b : ACPI PM_TMR
    0810-0815 : ACPI CPU throttle
    0828-082f : ACPI GPE0_BLK
    0860-087f : iTCO_wdt
0cf8-0cff : PCI conf1
a000-afff : PCI Bus 0000:02
  a400-a40f : 0000:02:00.1
    a400-a40f : pata_jmicron
  a480-a483 : 0000:02:00.1
    a480-a483 : pata_jmicron
  a800-a807 : 0000:02:00.1
    a800-a807 : pata_jmicron
  a880-a883 : 0000:02:00.1
    a880-a883 : pata_jmicron
  ac00-ac07 : 0000:02:00.1
    ac00-ac07 : pata_jmicron
b000-bfff : PCI Bus 0000:04
  b800-b8ff : 0000:04:04.0
    b800-b8ff : skge
  bc00-bc7f : 0000:04:03.0
c480-c48f : 0000:00:1f.5
  c480-c48f : ata_piix
c800-c80f : 0000:00:1f.5
  c800-c80f : ata_piix
c880-c883 : 0000:00:1f.5
  c880-c883 : ata_piix
cc00-cc07 : 0000:00:1f.5
  cc00-cc07 : ata_piix
d000-d003 : 0000:00:1f.5
  d000-d003 : ata_piix
d080-d087 : 0000:00:1f.5
  d080-d087 : ata_piix
d400-d41f : 0000:00:1d.0
  d400-d41f : uhci_hcd
d480-d49f : 0000:00:1d.1
  d480-d49f : uhci_hcd
d800-d81f : 0000:00:1d.2
  d800-d81f : uhci_hcd
d880-d89f : 0000:00:1a.0
  d880-d89f : uhci_hcd
dc00-dc1f : 0000:00:1a.1
  dc00-dc1f : uhci_hcd
e000-e00f : 0000:00:1f.2
  e000-e00f : ata_piix
e080-e08f : 0000:00:1f.2
  e080-e08f : ata_piix
e400-e403 : 0000:00:1f.2
  e400-e403 : ata_piix
e480-e487 : 0000:00:1f.2
  e480-e487 : ata_piix
e800-e803 : 0000:00:1f.2
  e800-e803 : ata_piix
e880-e887 : 0000:00:1f.2
  e880-e887 : ata_piix
ec00-ec07 : 0000:00:02.0


cat /proc/interrupts
           CPU0       CPU1
  0:        155          0   IO-APIC-edge      timer
  1:       8496          0   IO-APIC-edge      i8042
  4:          2          0   IO-APIC-edge
  8:         20          0   IO-APIC-edge      rtc0
  9:          0          0   IO-APIC-fasteoi   acpi
 12:     145521          0   IO-APIC-edge      i8042
 16:          1     187746   IO-APIC-fasteoi   ahci, uhci_hcd:usb3, i915@pci:000
0:00:02.0
 17:      73909          0   IO-APIC-fasteoi   uhci_hcd:usb4, pata_jmicron
 18:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb7
 19:       5239     156519   IO-APIC-fasteoi   ata_piix, ata_piix, uhci_hcd:usb6
, eth0
 21:        112          0   IO-APIC-fasteoi   firewire_ohci
 22:        532          1   IO-APIC-fasteoi   snd_hda_intel
 23:         35          0   IO-APIC-fasteoi   ehci_hcd:usb2, uhci_hcd:usb5, snd
_ymfpci
NMI:          0          0   Non-maskable interrupts
LOC:    1107924    1273516   Local timer interrupts
RES:      31414      34972   Rescheduling interrupts
CAL:       1537       2019   function call interrupts
TLB:       5824      55363   TLB shootdowns
TRM:          0          0   Thermal event interrupts
SPU:          0          0   Spurious interrupts
ERR:          0
MIS:          0
