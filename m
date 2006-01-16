From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001756]: Detects soundcard, alsamixer is ok, fiddled with switches, but no audio output
Date: Mon, 16 Jan 2006 18:51:18 +0100
Message-ID: <0fea30b84d95d092825fe1fcb9bf68a9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7FD73147
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2006 18:51:19 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1756> 
======================================================================
Reported By:                rawsock
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1756
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Breezy Badger
Kernel Version:             2.6.12-i686
======================================================================
Date Submitted:             01-16-2006 18:51 CET
Last Modified:              01-16-2006 18:51 CET
======================================================================
Summary:                    Detects soundcard, alsamixer is ok, fiddled with
switches, but no audio output
Description: 
Tried switching External Amplifier, SPDIF output, Mic, PC Speaker, etc ...
but to no avail. My laptop is a Packard Bell EasyNote A8, but the chipset
seems pretty standard. The output of dmesg does not show any error while
loading modules.

On full volume settings, i can hear popping sounds when switching mic, pcm
or lfe on/off. I can also hear the same loud pop when loading the sound
module.

== lspci output

0000:00:00.0 Host bridge: Intel Corp. Mobile Memory Controller Hub (rev
03)
0000:00:02.0 VGA compatible controller: Intel Corp. Mobile Graphics
Controller (rev 03)
0000:00:02.1 Display controller: Intel Corp. Mobile Graphics Controller
(rev 03)
0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 1 (rev 04)
0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04)
0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04)
0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04)
0000:00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 04)
0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 04)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d4)
0000:00:1e.2 Multimedia audio controller: Intel Corp.
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
0000:00:1e.3 Modem: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97
Modem Controller (rev 04)
0000:00:1f.0 ISA bridge: Intel Corp. 82801FBM (ICH6M) LPC Interface Bridge
(rev 04)
0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 04)
0000:00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus
Controller (rev 04)
0000:06:01.0 CardBus bridge: Texas Instruments: Unknown device 8031
0000:06:01.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8032
0000:06:01.3 Unknown mass storage controller: Texas Instruments: Unknown
device 8033
0000:06:03.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
0000:06:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)

== lsmod output

snd_intel8x0           35036  2
snd_ac97_codec         99136  1 snd_intel8x0
snd_ac97_bus            2144  1 snd_ac97_codec
snd_pcm_oss            56352  0
snd_mixer_oss          20512  1 snd_pcm_oss
snd_pcm                96776  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              26916  1 snd_pcm
snd                    58756  10
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10816  1 snd
snd_page_alloc         10984  2 snd_intel8x0,snd_pcm
binfmt_misc            12456  1
rfcomm                 41816  0
l2cap                  28196  5 rfcomm
bluetooth              52452  4 rfcomm,l2cap
speedstep_centrino      7600  1
cpufreq_powersave       1696  0
cpufreq_stats           5860  0
cpufreq_userspace       4472  1
cpufreq_ondemand        6300  0
cpufreq_conservative     7332  0
freq_table              4548  2 speedstep_centrino,cpufreq_stats
pcmcia                 41548  2
i915                   20576  1
drm                    77204  2 i915
tc1100_wmi              6660  0
video                  16036  0
battery                 9444  0
container               4384  0
button                  6480  0
pcc_acpi               10848  0
sony_acpi               5292  0
ac                      4708  0
dev_acpi               10916  0
hotkey                 11300  0
ipv6                  281856  8
xfrm_user              20132  2
xfrm4_tunnel            3748  0
ipcomp                  8456  0
esp4                    8192  0
ah4                     6400  0
af_packet              23560  2
tsdev                   7808  0
rtc                    14292  0
ipw2200               110988  0
ieee80211              34888  1 ipw2200
ieee80211_crypt         6560  1 ieee80211
firmware_class         11328  1 ipw2200
ohci1394               37172  0
yenta_socket           29228  2
rsrc_nonstatic         14336  1 yenta_socket
pcmcia_core            44976  3 pcmcia,yenta_socket,rsrc_nonstatic
hw_random               5620  0
shpchp                 48576  0
pci_hotplug            31060  1 shpchp
intel_agp              24284  1
agpgart                36264  3 drm,intel_agp
deflate                 4064  0
zlib_deflate           24248  1 deflate
twofish                47616  0
serpent                20672  0
aes                    29792  0
blowfish                8352  0
des                    17664  0
sha256                 10944  0
sha1                    2624  0
crypto_null             2240  0
af_key                 36144  0
nls_cp437               5664  1
ntfs                  109936  1
joydev                 10272  0
dm_mod                 61752  1
sr_mod                 17828  0
sbp2                   24740  0
scsi_mod              144264  2 sr_mod,sbp2
ieee1394              107704  2 ohci1394,sbp2
psmouse                39556  0
mousedev               12288  2
parport_pc             37604  0
lp                     11876  0
parport                39176  2 parport_pc,lp
md_mod                 76404  0
reiserfs              280432  2
thermal                13448  0
processor              23456  2 speedstep_centrino,thermal
fan                     4612  0
usbhid                 40384  0
8139cp                 23328  0
8139too                28832  0
mii                     6048  2 8139cp,8139too
ehci_hcd               36968  0
uhci_hcd               35120  0
usbcore               136996  4 usbhid,ehci_hcd,uhci_hcd
ide_cd                 43972  0
cdrom                  41472  2 sr_mod,ide_cd
ide_disk               18944  5
ide_generic             1280  0
piix                   11236  1
generic                 5156  0
ide_core              147956  5 ide_cd,ide_disk,ide_generic,piix,generic
unix                   30416  668
vga16fb                13448  0
vgastate                9984  1 vga16fb
cfbimgblt               2880  1 vga16fb
cfbfillrect             4128  1 vga16fb
cfbcopyarea             3872  1 vga16fb
tileblit                2560  0
font                    8096  0

== output of /proc/interrupts

 0:    1467003    IO-APIC-edge  timer
  1:      27671    IO-APIC-edge  i8042
  8:          1    IO-APIC-edge  rtc
  9:        334   IO-APIC-level  acpi
 12:     232936    IO-APIC-edge  i8042
 14:     107773    IO-APIC-edge  ide0
 16:      45563   IO-APIC-level  ipw2200, Intel ICH6
 17:     101668   IO-APIC-level  uhci_hcd:usb4, yenta, ohci1394, eth1,
i915@pci:0000:00:02.0
 19:     359145   IO-APIC-level  uhci_hcd:usb3
 20:          2   IO-APIC-level  uhci_hcd:usb1, ehci_hcd:usb5
 21:          0   IO-APIC-level  uhci_hcd:usb2
NMI:          0
LOC:     192512
ERR:          0
MIS:          0



======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-16-06 18:51 rawsock        New Issue                                    
01-16-06 18:51 rawsock        Distribution              => Ubuntu Breezy Badger
01-16-06 18:51 rawsock        Kernel Version            => 2.6.12-i686     
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
