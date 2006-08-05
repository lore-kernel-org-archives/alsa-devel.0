From: "Lubomir Schmidt" <017623780966@o2online.de>
Subject: Re: No chance to get the soundcard working
Date: Sat, 5 Aug 2006 17:04:32 +0200
Message-ID: <005501c6b8a0$755bdab0$8801a8c0@dell4150>
References: <s5h7j1phqgr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h7j1phqgr.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello, I tried that with pci=3Dnoacpi (there is no BIOS-update available). =

Now I see more mistakes in dmesg. The sound is not wrking.
Here the mistakes from dmesg:
PCI: No IRQ known for interrupt pin A of device 0000:00:1b.0. Please try
using pci=3Dbiosirq.
setup_irq: irq handler mismatch
 <c0138e38> setup_irq+0x118/0x120  <f89f4800> azx_interrupt+0x0/0xc0
[snd_hda_intel]
 <c0138feb> request_irq+0x8b/0xc0  <f89f57b1> azx_create+0x121/0x4d0
[snd_hda_intel]
 <f89f4800> azx_interrupt+0x0/0xc0 [snd_hda_intel]  <f89f5bb8>
azx_probe+0x58/0x100 [snd_hda_intel]
 <c02452a5> __pci_device_probe+0x65/0x80  <c02452ef>
pci_device_probe+0x2f/0x60
 <c02b5189> driver_probe_device+0x99/0xf0  <c03ddf2b>
klist_dec_and_del+0x1b/0x20
 <c02b5260> __driver_attach+0x0/0x90  <c02b52e3> __driver_attach+0x83/0x90
 <c02b446d> bus_for_each_dev+0x5d/0x80  <c023afd3>
kobject_set_name+0x43/0xe0
 <c02b5315> driver_attach+0x25/0x30  <c02b5260> __driver_attach+0x0/0x90
 <c02b4a74> bus_add_driver+0x84/0xe0  <c02b5806> driver_register+0x66/0xa0
 <c02b5780> klist_devices_get+0x0/0x10  <c02b5790>
klist_devices_put+0x0/0x10
 <c02455b0> __pci_register_driver+0x40/0x60  <c0124d42>
blocking_notifier_call_chain+0x32/0x50
 <f887c018> alsa_card_azx_init+0x18/0x1c [snd_hda_intel]  <c0132135>
sys_init_module+0xe5/0x150
 <c0102fcf> sysenter_past_esp+0x54/0x75 =

ALSA
/var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-driver-1.0.12rc1/pci/hd
a/../../alsa-kernel/pci/hda/hda_intel.c:1491: hda-intel: unable to grab IRQ
0
HDA Intel: probe of 0000:00:1b.0 failed with error -16

There are olso that messages by boot with the green stars in front of them.
There is olso a mistake:
   Loading: snd-seq =85
ERROR: Failed to load necessary drivers

Thank you for your help

-----Urspr=FCngliche Nachricht-----
Von: Takashi Iwai [mailto:tiwai@suse.de] =

Gesendet: Donnerstag, 3. August 2006 15:57
An: 017623780966@o2online.de
Cc: alsa-devel@lists.sourceforge.net
Betreff: Re: [Alsa-devel] No chance to get the soundcard working

At Thu, 3 Aug 2006 13:04:10 +0100 (BST),
017623780966@o2online.de wrote:
> =

> Hello, i have a big problem with my soundcard. It have a Realtek alc260 =

> chip (intel-hda) and its build in an Acer c204tmi notebook. I can not get =

> that card working with linux. I tried over 20 linux live cds and have
installed =

> now gentoo linux on it. The problem i have is: the sound card is been
found =

> by alsaconf and can be configured. Alsamixer also found the card and can =

> configure it. I have unmuted every channel and set it up to max. I have =

> always tired the headphone. I never could get sound of that notebook. In =

> dmesg i found that -> ALSA
/var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-
> driver-1.0.12rc1/pci/hda/..
> /../alsa-kernel/pci/hda/hdaintel.c:525: hda_intel: azx_get_response
timeout, =

> switching to single_cmd mode...

This is usually a BIOS problem.

> i do not know is that the reason why i have no sound. I have testet the =

> sound with xmms,KsCD,Noatun, and other. xmms and noatun do not start
playing =

> and KsCD start playing, but i can not hear anything.
> I also cant ask someone who got alsa running, because i am the only person

> who use that notebook under linux.
> I do not know what i could do. Can you help me?

Try to update BIOS if available, at first.
If still doesn't work, try pci=3Dnoacpi or acpi=3Doff boot option.


Takashi


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
