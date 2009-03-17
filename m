From: Emmanuel Chanel <emmanuelchanel@gmail.com>
Subject: Re: My PC has 6GB memory but the limitation of the
 alsa-driver is 4GB.
Date: Tue, 17 Mar 2009 13:32:44 +0900
Message-ID: <1237264364.26545.1.camel@localhost.localdomain>
References: <1237056610.21086.72.camel@localhost.localdomain>
	<fd3eb9bf0903141235v1878ae03h8e51b8bcebb4c87d@mail.gmail.com>
	<1237061065.2581.3.camel@localhost.localdomain>
	<1237093356.3501.45.camel@localhost.localdomain>
	<s5hocw2rl9y.wl%tiwai@suse.de>
	<1237197183.3501.64.camel@localhost.localdomain>
	<s5hocw1rdoq.wl%tiwai@suse.de>
	<1237209483.13649.3.camel@localhost.localdomain>
	<s5hiqm9r44x.wl%tiwai@suse.de>
	<1237216549.29020.13.camel@localhost.localdomain>
	<s5h3addqy4b.wl%tiwai@suse.de> <s5hzlflpje2.wl%tiwai@suse.de>
	<1237224576.6808.2.camel@localhost.localdomain>
	<s5hhc1tpdwk.wl%tiwai@suse.de>
	<1237226578.21372.2.camel@localhost.localdomain>
	<s5hskldyzw3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-UUyfcDJIJbXZHPLDD0BA"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 824C010388A
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2009 05:32:50 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id c5so2936529rvf.32
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 21:32:49 -0700 (PDT)
In-Reply-To: <s5hskldyzw3.wl%tiwai@suse.de>
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


--=-UUyfcDJIJbXZHPLDD0BA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2009-03-16 (Mon) =E3=81=AE 21:30 +0100 Takashi Iwai Wrote:
> At Tue, 17 Mar 2009 03:02:58 +0900,
> Emmanuel Chanel wrote:
> >=20
> > Your revice on the mail below didn't work. I cannot listen the
sound.
>=20
> Hm, did you really test the latest patch (the third version)?
> It actually does set only 32bit DMA as Daniel's change, but just after
> checking the controller model.
>=20
> If it doesn't work, I suspect something wrong in your test or
patching.
>=20
>=20
> Takashi

Maybe. I cannot patch the third version by "patch -p1 < YourPatch",
neither and I modified by hand. I don't know why I cannot patch all
three.
I have a problem "patch". Maybe because I haven't used that command
often, I cannot "patch -p1 < YourPatch" correctly. I don't know why.
Copy of your patches on mail may be wrong.
Maybe it's better for me to receive the attachment of all three patched
hda_intel.c ... :(
I retested your 3 all patches(Actually, I modified hda_intel.c by hand ,
though...)

patch no. 1: Soundcard not detected.
patch no. 2: Sound not work but card detected by alsa.
patch no. 3: Soundcard not detected.

--=20
Emmanuel Chanel <emmanuelchanel@gmail.com>

--=-UUyfcDJIJbXZHPLDD0BA
Content-Disposition: attachment; filename="alsa-info-1.txt"
Content-Type: text/plain; name="alsa-info-1.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Tue Mar 17 04:01:15 UTC 2009


!!Linux Distribution
!!------------------

Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge)


!!Kernel Information
!!------------------

Kernel release:    2.6.27.19-170.2.35.fc10.x86_64
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.19
Library version:    1.0.19
Utilities version:  1.0.19


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

--- no soundcards ---


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 1458:a002


!!Loaded sound module options
!!--------------------------


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root root 116,  1 Mar 17 13:00 /dev/snd/seq
crw-rw----+ 1 root root 116, 33 Mar 17 13:00 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#

@hooks [
	{
		func load
		files [
			"/etc/alsa/pulse-default.conf"
		]
		errors false
	}
]


!!Aplay/Arecord output
!!------------

APLAY

aplay: device_list:217: no soundcards found...

ARECORD

arecord: device_list:217: no soundcards found...

!!Amixer output
!!-------------


!!Alsactl output
!!-------------

--startcollapse--
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_seq_dummy
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_timer
snd
soundcore
snd_page_alloc
ext2
fuse
nfs
lockd
nfs_acl
bridge
stp
bnep
sco
l2cap
bluetooth
sunrpc
ipv6
cpufreq_ondemand
powernow_k8
freq_table
reiserfs
dm_multipath
uinput
ata_generic
pata_acpi
usb_storage
ppdev
firewire_ohci
pata_atiixp
i2c_piix4
k8temp
firewire_core
parport_pc
parport
pcspkr
floppy
r8169
i2c_core
crc_itu_t
hwmon
mii



--=-UUyfcDJIJbXZHPLDD0BA
Content-Disposition: attachment; filename="alsa-info-2.txt"
Content-Type: text/plain; name="alsa-info-2.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Tue Mar 17 03:45:40 UTC 2009


!!Linux Distribution
!!------------------

Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge)


!!Kernel Information
!!------------------

Kernel release:    2.6.27.19-170.2.35.fc10.x86_64
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     
Library version:    1.0.19
Utilities version:  1.0.19


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------



!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 1458:a002


!!Loaded sound module options
!!--------------------------


!!ALSA Device nodes
!!-----------------



!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#

@hooks [
	{
		func load
		files [
			"/etc/alsa/pulse-default.conf"
		]
		errors false
	}
]


!!Aplay/Arecord output
!!------------

APLAY

aplay: device_list:217: no soundcards found...

ARECORD

arecord: device_list:217: no soundcards found...

!!Amixer output
!!-------------


!!Alsactl output
!!-------------

--startcollapse--
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ext2
fuse
nfs
lockd
nfs_acl
bridge
stp
bnep
sco
l2cap
bluetooth
sunrpc
ipv6
cpufreq_ondemand
powernow_k8
freq_table
reiserfs
dm_multipath
uinput
ata_generic
pata_acpi
usb_storage
ppdev
firewire_ohci
pata_atiixp
i2c_piix4
k8temp
firewire_core
parport_pc
parport
pcspkr
floppy
r8169
i2c_core
crc_itu_t
hwmon
mii



--=-UUyfcDJIJbXZHPLDD0BA
Content-Disposition: attachment; filename="alsa-info-3.txt"
Content-Type: text/plain; name="alsa-info-3.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Tue Mar 17 03:30:35 UTC 2009


!!Linux Distribution
!!------------------

Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge)


!!Kernel Information
!!------------------

Kernel release:    2.6.27.19-170.2.35.fc10.x86_64
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.19
Library version:    1.0.19
Utilities version:  1.0.19


!!Loaded ALSA modules
!!-------------------



!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

--- no soundcards ---


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 1458:a002


!!Loaded sound module options
!!--------------------------


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root root 116,  1 Mar 17 12:28 /dev/snd/seq
crw-rw----+ 1 root root 116, 33 Mar 17 12:28 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#

@hooks [
	{
		func load
		files [
			"/etc/alsa/pulse-default.conf"
		]
		errors false
	}
]


!!Aplay/Arecord output
!!------------

APLAY

aplay: device_list:217: no soundcards found...

ARECORD

arecord: device_list:217: no soundcards found...

!!Amixer output
!!-------------


!!Alsactl output
!!-------------

--startcollapse--
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_seq_dummy
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_timer
snd
soundcore
snd_page_alloc
ext2
fuse
nfs
lockd
nfs_acl
bridge
stp
bnep
sco
l2cap
bluetooth
sunrpc
ipv6
cpufreq_ondemand
powernow_k8
freq_table
reiserfs
dm_multipath
uinput
ata_generic
pata_acpi
usb_storage
ppdev
firewire_ohci
pata_atiixp
i2c_piix4
k8temp
firewire_core
parport_pc
parport
pcspkr
floppy
r8169
i2c_core
crc_itu_t
hwmon
mii



--=-UUyfcDJIJbXZHPLDD0BA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-UUyfcDJIJbXZHPLDD0BA--
