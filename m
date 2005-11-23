From: "Yang, Libin" <libin.yang@intel.com>
Subject: RE: [ALSA - driver 0001563]: No Sound on Cybersystem S28 (hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...)
Date: Wed, 23 Nov 2005 10:45:33 +0800
Message-ID: <D4DBC33C8102AB409C7F44B414D9943801593CE2@bjsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from orsfmr004.jf.intel.com (fmr19.intel.com [134.134.136.18])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF883177
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 03:45:39 +0100 (MET)
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bugtrack@alsa-project.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I think I have found the reason which may cause the problem. But I don't =
 how to submit the patch or just write the reason here? Thanks. =20

-----Original Message-----
From: alsa-devel-admin@lists.sourceforge.net =
[mailto:alsa-devel-admin@lists.sourceforge.net] On Behalf Of =
bugtrack@alsa-project.org
Sent: 2005=C4=EA11=D4=C223=C8=D5 2:32
To: alsa-devel@alsa-project.org
Subject: [Alsa-devel] [ALSA - driver 0001563]: No Sound on Cybersystem =
S28 (hda_codec: Unknown model for ALC880, trying auto-probe from =
BIOS...)


The following issue has been UNset as DUPLICATE OF issue 0000790.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1563>=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                mbab
Assigned To:                tiwai
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Issue ID:                   1563
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian Unstable (all but the driver)
Kernel Version:             2.6.14.2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             11-16-2005 06:48 CET
Last Modified:              11-22-2005 19:32 CET
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    No Sound on Cybersystem S28 (hda_codec: =
Unknown
model for ALC880, trying auto-probe from BIOS...)
Description:=20
I just cannot get any sound from this system. Then I tried the release
candidate.
The message sounds as if the problem might not be so severe. I can play
back, but there is no sound. If I need to provide additional =
information,
please contact me.=20

When using alsamixer i get:
spike:/tmp# alsamixer

alsamixer: function snd_mixer_load failed: Invalid argument

I used alsaconf (from debian unstable ALSA configurator version 1.0.9a)
for
configuration.


>From dmesg:
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
hda_codec: num_steps =3D 0 for NID=3D0x8
hda_codec: num_steps =3D 0 for NID=3D0x8
hda_codec: num_steps =3D 0 for NID=3D0x8
hda_codec: num_steps =3D 0 for NID=3D0x8
hda_codec: num_steps =3D 0 for NID=3D0x9
hda_codec: num_steps =3D 0 for NID=3D0x9
hda_codec: num_steps =3D 0 for NID=3D0x9
hda_codec: num_steps =3D 0 for NID=3D0x9
...

spike:/tmp# lspci
0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI
Express Root Port (rev 03)
0000:00:1b.0 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
High Definition Audio Controller (rev 04)
0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 04)
0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW =
(ICH6
Family) USB UHCI #1 (rev 04)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW =
(ICH6
Family) USB UHCI #2 (rev 04)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW =
(ICH6
Family) USB UHCI #3 (rev 04)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW =
(ICH6
Family) USB UHCI #4 (rev 04)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW =
(ICH6
Family) USB2 EHCI Controller (rev 04)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev
d4)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC =
Interface
Bridge (rev 04)
0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW =
(ICH6
Family) IDE Controller (rev 04)
0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA
Controller (rev 04)
0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 =
Family)
SMBus Controller (rev 04)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce
Go 6600] (rev a2)
0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053
Gigabit Ethernet Controller (rev 19)
0000:06:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21
IEEE-1394a-2000 Controller (PHY/Link)
0000:06:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG
(rev 05)
0000:06:04.0 CardBus bridge: Texas Instruments PCI1620 PC Card =
Controller
(rev 01)
0000:06:04.1 CardBus bridge: Texas Instruments PCI1620 PC Card =
Controller
(rev 01)
0000:06:04.2 System peripheral: Texas Instruments PCI1620 Firmware =
Loading
Function (rev 01)

spike:/tmp# lsmod
Module                  Size  Used by
snd_hda_intel          18704  0
snd_hda_codec          92544  1 snd_hda_intel
snd_pcm_oss            55392  0
snd_mixer_oss          20032  1 snd_pcm_oss
snd_pcm                97032  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              26948  1 snd_pcm
snd                    60132  6
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10784  1 snd
snd_page_alloc         11080  2 snd_hda_intel,snd_pcm
tun                    11904  1
af_packet              23624  0
aes                    29760  1
nvidia               3700424  14
rfcomm                 43420  0
l2cap                  28996  5 rfcomm
thermal                13384  0
fan                     4612  0
button                  6480  0
ac                      4676  0
battery                 9412  0
ipv6                  278848  12
ipt_LOG                 7040  1
ipt_limit               2496  1
ipt_state               1792  1
ip_conntrack           50064  1 ipt_state
iptable_filter          2880  1
ip_tables              22848  4
ipt_LOG,ipt_limit,ipt_state,iptable_filter
nls_iso8859_1           3968  1
nls_cp437               5632  1
vfat                   14592  1
fat                    55132  1 vfat
speedstep_centrino      7764  1
processor              24444  2 thermal,speedstep_centrino
cryptoloop              3584  1
loop                   18440  3 cryptoloop
cpufreq_powersave       1664  0
cpufreq_conservative     7268  1
sbp2                   24580  0
eth1394                21384  0
hci_usb                16464  2
bluetooth              52420  7 rfcomm,l2cap,hci_usb
ipw2200                76584  0
joydev                  9920  0
firmware_class         11136  1 ipw2200
ieee80211              23816  1 ipw2200
ieee80211_crypt         5956  1 ieee80211
yenta_socket           28364  0
rsrc_nonstatic         14208  1 yenta_socket
pcmcia_core            44688  2 yenta_socket,rsrc_nonstatic
ohci1394               37108  0
ieee1394              104376  3 sbp2,eth1394,ohci1394
evdev                   9600  0
irtty_sir               9024  0
mousedev               12000  1
sir_dev                20012  1 irtty_sir
i2c_i801                8908  0
ehci_hcd               37576  0
irda                  207484  2 irtty_sir,sir_dev
i2c_core               23184  1 i2c_i801
sk98lin               218904  0
uhci_hcd               34768  0
rtc                    14200  0
intel_agp              24156  1
agpgart                36296  2 nvidia,intel_agp
crc_ccitt               1984  1 irda
usbcore               128384  4 hci_usb,ehci_hcd,uhci_hcd
psmouse                39940  0
unix                   30128  552

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001589 broken support for a SB450 Azalia since...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 mbab - 11-18-05 06:49=20
----------------------------------------------------------------------
I just tried with 1.0.10 Release.
The problem looks exactly the same. Playback works but no sound. Cannot
open Mixer. Kernel-Messages the same.

----------------------------------------------------------------------
 tiwai - 11-18-05 17:00=20
----------------------------------------------------------------------
Did you try different model option values?  See ALSA-Configuration.txt.

----------------------------------------------------------------------
 mbab - 11-18-05 19:49=20
----------------------------------------------------------------------
I didnt notice that file before. I tried all of them now. No avail =
though.
The kernel messages didnt seem to change much. (Maybe the number of
"num_steps" messages varied, but I didnt check that.)
In every case the mixer didnt work and i got no sound while playing =
back.
:o(

----------------------------------------------------------------------
 tvignaud - 11-22-05 18:36=20
----------------------------------------------------------------------
this bug looks like
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1589

Issue History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
11-16-05 06:48 mbab           New Issue                                  =
 =20
11-16-05 06:48 mbab           Distribution              =3D> Debian =
Unstable (all
but the driver)
11-16-05 06:48 mbab           Kernel Version            =3D> 2.6.14.2    =
   =20
11-18-05 06:49 mbab           Note Added: 0006750                        =
 =20
11-18-05 17:00 tiwai          Note Added: 0006752                        =
 =20
11-18-05 19:49 mbab           Note Added: 0006757                        =
 =20
11-22-05 18:36 tvignaud       Note Added: 0006793                        =
 =20
11-22-05 19:08 rlrevell       Relationship added       has duplicate =
0001589
11-22-05 19:15 rlrevell       Relationship added       duplicate of =
0000790
11-22-05 19:32 rlrevell       Relationship deleted     duplicate of =
0000790
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
