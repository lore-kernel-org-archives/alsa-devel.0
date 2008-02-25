From: "Federico Briata" <federicobriata@gmail.com>
Subject: Re: installation steps for us-122l tascam driver
Date: Mon, 25 Feb 2008 01:47:45 +0100
Message-ID: <b35229e90802241647v108bc4e0o52923154035de2c8@mail.gmail.com>
References: <b35229e90802241643y317e5cb4o39b5c6f2da254f81@mail.gmail.com>
Reply-To: federicobriata@tiscali.it
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 216C51038A0
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 01:47:47 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so3431567fka.0
	for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2008 16:47:46 -0800 (PST)
In-Reply-To: <b35229e90802241643y317e5cb4o39b5c6f2da254f81@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

follow step-by-step instruction which i used compile everything.
I'm using debian lenny, for ubuntu should be the same...

------- download patch for us-122l---------
mkdir /usr/src/us-122l
cd /usr/src/us-122l
wget -c http://cache.gmane.org//gmane/linux/alsa/devel/49344-001.bin -O
0001-Driver-for-the-US-122L-usb-soundcard.patch
wget -c http://cache.gmane.org//gmane/linux/alsa/devel/49344-002.bin -O
0001-Midi-in-support-for-the-US-122L-usb-soundcard.patch
wget -c http://cache.gmane.org//gmane/linux/alsa/devel/49344-003.bin -O
0001-usb-stream-for-isochrone-usb-i-o.patch
wget -c http://marc.info/?l=linux-usb-devel&m=119444869917392&q=raw -O
ehci-hcd_complete_iso_urbs_ASAP.patch
wget -c http://cache.gmane.org//gmane/linux/alsa/devel/49345-001.bin -O
jackd-usb_stream-driver.diff.bz2

-------recompile the kernel---------

apt-get install debhelper kernel-package libncurses5-dev fakeroot

cd /usr/src
wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.1.tar.bz2
wget
http://www.kernel.org/pub/linux/kernel/projects/rt/older/patch-2.6.23.1-rt11.bz2(Nb.
this is only if u want lowlatency)

tar xjvf linux-2.6.23.1.tar.bz2
cd linux-2.6.23.1

bzcat ../patch-2.6.23.1-rt11.bz2 |patch -p1 (Nb. this is only if u want
lowlatency)

from
patch -p1 < ../us-122l/0001-Driver-for-the-US-122L-usb-soundcard.patch
patch -p1 < ../us-122l/0001-
Midi-in-support-for-the-US-122L-usb-soundcard.patch
patch -p1 < ../us-122l/0001-usb-stream-for-isochrone-usb-i-o.patch
patch -p1 < ../us-122l/ehci-hcd_complete_iso_urbs_ASAP.patch

make-kpkg clean
cp /boot/config-2.6.22-3-amd64 .config
make oldconfig
- say 'yes' when u found your hardware and 'no' for unnecessary driver or
press just enter if u r not sure

make menuconfig
- add driver for us-122l
Device Drivers -> Sound -> Advanced Linux Sound Architecture -> USB devices
-> Tascam US-122L USB driver
- add tweaks for Alsa low-latency, u can get from this howto
http://alsa-project.org/main/index.php/Low_latency_howto

fakeroot make-kpkg --append-to-version -lowlatency --revision=1 --initrd
kernel_image
dpkg -i ../linux-image-2.6.23.1-rt11-lowlatency_1_amd64.deb
update-initramfs -c -k 2.6.23.1-rt11-lowlatency

----------recompile jackd 0.103------------
apt-get install dh-buildinfo libasound2-dev libsndfile1-dev doxygen
libcap-dev libreadline5-
dev libraw1394-dev libfreebob0-dev chrpath cdbs type-handling

cd /usr/src

wget -c
http://ftp.de.debian.org/debian/pool/main/j/jack-audio-connection-kit/jack-audio-connection-kit_0.103.0-6.diff.gz
wget -c
http://ftp.de.debian.org/debian/pool/main/j/jack-audio-connection-kit/jack-audio-connection-kit_0.103.0-6.dsc
wget -c
http://ftp.de.debian.org/debian/pool/main/j/jack-audio-connection-kit/jack-audio-connection-kit_0.103.0.orig.tar.gz
cp ../us-122l/jackd-usb_stream-driver.diff.bz2
jack-audio-connection-kit-0.103.0/debian/patches/

dpkg-source -x jack-audio-connection-kit_0.103.0-6.dsc
cd jack-audio-connection-kit-0.103.0/

fakeroot dpkg-buildpackage -b -uc
dpkg -i ../*jack*.deb

----end

Unfortunately when i plug the interface  i get some error in kernel log.

usbcore: registered new interface driver snd-usb-us122l
usb 5-4: USB disconnect, address 5
usb 5-4: new high speed USB device using ehci_hcd and address 6
usb 5-4: configuration #1 chosen from 1 choice
snd_us122l_probe:380:ffff810023 435800:0
snd-usb-us122l: probe of 5-4:1.0 failed with error -5
snd_us122l_probe:380:ffff81002a9a3000:1
us122l_create_card:302
us122l_start:225
us122l_start:228
us122l_start:230
playback_prep_freqn:58 idle=-18 ul=1518 ps=1536
playback_prep_freqn:58 idle=0 ul=1554 ps=1536
i_capture_start:566: 0 0 0 30 36 36 30 36 30 36 30 36 30 36 30 36 30 36 30
36 30 36 30 36 30 36 30 36 30 36 30 36 30 36 36 36 30 36 30 36 30 36 30 36
30 36
playback_prep_freqn:58 idle=-12 ul=1524 ps=1536
playback_prep_freqn:58 idle=-30 ul=1518 ps=1536
stream_start:510 253 0
stream_start:510 254 0
i_capture_start:558
us122l_start error -14
snd-usb-us122l: probe of 5-4:1.1 failed with error -5

$ lsmod
Module                  Size  Used by
nls_iso8859_1           9600  0
nls_cp437              11392  0
vfat                   18176  0
fat                    59056  1 vfat
mmc_block              18816  0
tifm_sd                16392  0
usb_storage            91424  0
snd_rtctimer            8400  0
snd_usb_us122l         23008  0
snd_usb_lib            22272  1 snd_usb_us122l
snd_seq_dummy           8452  2
snd_seq_oss            37568  0
snd_seq_midi           13376  0
snd_seq_midi_event     12416  2 snd_seq_oss,snd_seq_midi
snd_seq                59872  6
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_rawmidi            31136  2 snd_usb_lib,snd_seq_midi
snd_seq_device         12948  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi
snd_hwdep              15240  1 snd_usb_us122l
i915                   31744  2
drm                   101928  3 i915
binfmt_misc            17676  1
rfcomm                 50344  4
l2cap                  33024  9 rfcomm
ppdev                  13704  0
lp                     17448  0
ipv6                  301576  27
acpi_cpufreq           14224  1
cpufreq_powersave       6272  0
cpufreq_userspace       9604  0
cpufreq_stats          10384  0
cpufreq_ondemand       13328  0
freq_table              9600  3 acpi_cpufreq,cpufreq_stats,cpufreq_ondemand
cpufreq_conservative    12424  0
fuse                   50608  1
tun                    16384  0
usbserial              42704  0
loop                   24324  0
wlan_scan_sta          18688  1
ath_rate_sample        17664  1
ath_pci                99760  0
wlan                  206488  4 wlan_scan_sta,ath_rate_sample,ath_pci
ath_hal               223088  3 ath_rate_sample,ath_pci
snd_hda_intel         334756  1
irtty_sir              13312  0
sir_dev                22280  1 irtty_sir
joydev                 15744  0
snd_pcm_oss            48928  0
pcmcia                 47008  0
firmware_class         15744  1 pcmcia
snd_mixer_oss          21760  1 snd_pcm_oss
tsdev                  13440  0
parport_pc             42408  1
snd_pcm                90888  2 snd_hda_intel,snd_pcm_oss
parport                45708  3 ppdev,lp,parport_pc
iTCO_wdt               17360  0
usbhid                 34384  0
tifm_7xx1              12800  0
sdhci                  23180  0
irda                  202956  2 irtty_sir,sir_dev
hid                    33408  1 usbhid
snd_timer              29704  3 snd_rtctimer,snd_seq,snd_pcm
tifm_core              16648  2 tifm_sd,tifm_7xx1
serio_raw              11908  0
yenta_socket           31628  2
rsrc_nonstatic         16000  1 yenta_socket
pcmcia_core            47268  3 pcmcia,yenta_socket,rsrc_nonstatic
crc_ccitt               6656  1 irda
mmc_core               37000  3 mmc_block,tifm_sd,sdhci
psmouse                45852  0
battery                18064  0
button                 13856  0
container               9856  0
ac                     10760  0
video                  26004  0
output                  8704  1 video
hci_usb                21532  2
bluetooth              68228  7 rfcomm,l2cap,hci_usb
snd                    67000  13
snd_usb_us122l,snd_seq_oss,snd_seq,snd_rawmidi,snd_seq_device,snd_hwdep,snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              13968  1 snd
intel_agp              31776  1
snd_page_alloc         15376  2 snd_hda_intel,snd_pcm
evdev                  15360  6
ext3                  137744  3
jbd                    67152  1 ext3
mbcache                14336  1 ext3
dm_mirror              28544  0
dm_snapshot            22096  0
dm_mod                 66168  9 dm_mirror,dm_snapshot
sd_mod                 33792  3
generic                10372  0 [permanent]
ide_core              146832  2 usb_storage,generic
ata_piix               24452  2
ata_generic            13188  0
libata                131344  2 ata_piix,ata_generic
scsi_mod              164888  3 usb_storage,sd_mod,libata
ehci_hcd               38412  0
tg3                   111876  0
uhci_hcd               30112  0
thermal                22304  0
processor              43592  2 acpi_cpufreq,thermal
fan                    10120  0

Arch: Hp compaq nc4400 (amd64)

any idea? plz help!!
regards,
Federico
