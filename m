From: risc@volumehost.com
Subject: Re: BUG in >=1.0.13rc1
Date: Thu, 28 Dec 2006 12:05:33 -0600
Message-ID: <20061228180533.GD28449@volumehost.com>
References: <20061227220022.GB28449@volumehost.com>
	<s5hodpoxja6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hodpoxja6.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 28, 2006 at 02:05:37PM +0100, Takashi Iwai wrote:
> At Wed, 27 Dec 2006 16:00:22 -0600,
> risc@volumehost.com wrote:
> > 
> > I own a toshiba L35 laptop, with a ATI SB450 sound card in it.
> > 
> > This card functions "adequately" with alsa 1.0.12.
> > it gets the "
> > ALSA /usr/src/alsa-driver-1.0.12/pci/hda/hda_codec.c:213: hda_codec: invalid dep_range_val 0:7fff
> > " errors scrolling off the screen, as reported by others,
> > and plays through the speakers only. this laptop has a mic (untested) and a headphone jack. plugging headphones in does stop the speakers, but dosent produce sound through the headphones.
> > 
> > however, switching to 1.0.13rc1 or newer (tried up to 1.0.14rc1) causes a kernel panic right after those errors stop.
> > sound does not function in these versions.
> > 
> > I've tried the disable_msi=1 option, however, i was not getting a "nobody cared" message before, and turning this option on does nothing.
> > So, i'm thinking this dosent have to do with the MSI changes recently.
> > 
> > the panic is as follows:
> > BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
> >  printing eip:
> > f8b7b4e8
> > *pde = 00000000
> > Oops: 0002 [#1]
> > SMP 
> > Modules linked in: snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc nfs nfsd exportfs lockd nfs_acl sunrpc ipv6 dm_snapshot dm_mirror dm_mod usbhid uhci_hcd usbkbd orinoco_cs orinoco hermes tsdev joydev pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core i2c_piix4 shpchp pci_hotplug psmouse ati_agp agpgart i2c_core evdev serio_raw pcspkr rtc ext3 jbd mbcache ide_cd cdrom 8139cp sd_mod 8139too mii atiixp ehci_hcd ohci_hcd sata_sil usbcore libata scsi_mod generic ide_core thermal processor fan
> > CPU:    0
> > EIP:    0060:[<f8b7b4e8>]    Not tainted VLI
> > EFLAGS: 00010202   (2.6.18 #1) 
> > EIP is at get_input_type+0x67/0x85 [snd_hda_codec]
> > eax: 00000007   ebx: dfd169c0   ecx: 00000001   edx: 00000000
> > esi: 00000000   edi: f8b836c5   ebp: f7bce880   esp: f5017d3c
> > ds: 007b   es: 007b   ss: 0068
> > Process modprobe (pid: 2367, ti=f5016000 task=f75ba000 task.ti=f5016000)
> > Stack: 00000001 f8b7bea2 0000032d dfd16a40 dfd169c0 dfd169e4 f50e2800 00000000 
> >        00000286 00000000 ffffe000 f5017d84 f5746ec0 00010000 00000002 c01b769c 
> >        f57468c0 c0185edb 0000032d 00008000 f57468c0 c0186316 f5746ec0 f5746940 
> > Call Trace:
> >  [<f8b7bea2>] build_generic_controls+0x1ed/0x2c9 [snd_hda_codec]
> 
> Could you try ALSA HG version?
> There was a bug in hda_generic.c that may cause Oops, and got fixed
> recently after 1.0.14rc1.
> 
> 
> Takashi
well, thats somewhat better.

note: a hint that you need to download alsa-kernel to compile alsa-driver from hg would be nice.

same behavior as 1.0.12, only, of course, more debugging is turned on in this version.

which means, i have sound, through the speakers, no headphone jack functioning, and no kernel oops.

the last output of loading the module reads as follows:
Dec 28 18:56:04 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff
Dec 28 18:56:04 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff
Dec 28 18:56:04 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:623: hda-intel: get_response timeout: IRS=0x0
Dec 28 18:56:04 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff
Dec 28 18:56:04 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:623: hda-intel: get_response timeout: IRS=0x0
Dec 28 18:56:04 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:623: hda-intel: get_response timeout: IRS=0x0
Dec 28 18:56:04 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:684: hda_generic: no proper input path found
Dec 28 18:56:04 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:431: hda_generic: no proper output path found
Dec 28 18:56:04 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:1002: hda_generic: no PCM found
Dec 28 18:56:04 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:245: si3054: cannot initialize. EXT MID = 0000
Dec 28 18:56:04 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:257: Link Frame Detect(FDT) is not ready (line status: 0000)

using the sound results in the following kernel messages, repeatedly.
Dec 28 18:57:15 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff
Dec 28 18:57:15 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff
Dec 28 18:57:15 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:623: hda-intel: get_response timeout: IRS=0x0
Dec 28 18:57:15 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff
until you close the sound, in which case you recieve the following:
Dec 28 18:57:28 faiserver kernel: hda-intel: Invalid position buffer, using LPIB read method instead.

so, this is a newer version, with the same functionality as 1.0.12, only now, it fills up my syslog. :P
no biggie. i use my laptop with headphones, so this is still "non-woring" as far as i'm concerned. i wont run out of diskspace playing sound. ;P

ask if you need any more debugging information.

Julia Longtin <risc@volumehost.com>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
