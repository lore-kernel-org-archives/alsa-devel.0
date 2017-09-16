From: Melvin Vermeeren <mail@mel.vin>
Subject: DICE Stereo-192-DSD-DAC issues since 2016-02-08 /
	kernel >= ~4.6
Date: Sat, 16 Sep 2017 23:35:39 +0200
Message-ID: <7073472.eAesDT94h8@melvin-pc>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3333570698531110957=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 16ECF26691F
 for <alsa-devel@alsa-project.org>; Sat, 16 Sep 2017 23:35:40 +0200 (CEST)
Received: from melvin-pc.localnet (unknown [213.152.161.20])
 (Authenticated sender: melvin@mel.vin)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 53B5AFB886
 for <alsa-devel@alsa-project.org>; Sat, 16 Sep 2017 23:35:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============3333570698531110957==
Content-Type: multipart/signed; boundary="nextPart2206105.UFIvYMkTZA"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2206105.UFIvYMkTZA
Content-Type: multipart/mixed; boundary="nextPart2177518.l4YsraJrz4"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart2177518.l4YsraJrz4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi all,

Sometime in 2016, I believe with kernel ~4.6, my DAC started having weird 
behaviour. I found some mails about heavy firewire/DICE dev at the time so I 
sticked with 4.4 LTS for a while. I decided to do some proper research now and 
found out some details which hopefully will help solving the problem.

The hardware, problem is with DAC only:
https://www.siig.com/it-products/firewire/firewire-400/pcie/dp-firewire-2-port-pcie.html
https://mytekdigital.com/hifi/products/stereo-192dsd-dac/
https://us.focusrite.com/firewire-audio-interfaces/saffire-pro-24

The Saffire works perfectly for all modules I tried. I believe my DAC's 
firmware may have some quirks with control/notification messages.

Behaviour comparison
--------------------

Old modules (2eb65d67afbf9364b525b657f1475d1a2cbc27de):
* Playback is instant, but DAC very rarely misses the lock. Need to restart 
the stream (stop, play MPD or restart jack) in that case. DAC's display still 
displays the samplerate change correctly, so probably firmware inconsistency.
* Songs with different sample rate (e.g. 44100 -> 96000) switch instantly, 
unless DAC misses lock like above. DAC's display updates sample rate in 1-5 
sec or so.
* Sound itself is perfect, no cracks, pops or other issues.
* Stop ALSA stream and DAC will indicate "No Lock", but procfs says locked.
* dmesg is silent about firewire/dice/dac.

New modules (4.1.1.12 and 4.13):
* Takes ~2 sec before playback starts, but always works.
* When MPD changes music track to track with different format it will always
hang ~2 sec and fail to change format anyway.
* Sound has very consistent popping in it. Very noticeable on higher 
frequencies, some timing issue? Besides that no other issues.
* Power cycle the DAC and it will be "unlocked". After that the first stream 
opened will perma-lock the format. Changing to other frequency will not work.
* Stop ALSA stream and DAC will indicate "No Lock", but procfs says locked.
* dmesg shows only:
	"snd_dice fw1.0: Invalid CIP header for AMDTP: 00000000:00000000"
	probably when it's trying to change frequency. No other messages.

I attached /proc/asound/DAC/dice output for old and new when idle, 44100 and 
96000. global/notification and sample/lock change but that's basically it.

Module details
--------------

To test modules on my current kernel, which is
4.11.12-1-rt13-rt, I git checkout desired version of /sound/firewire and make 
those modules. After that I insmod snd-firewire-lib and snd-dice.

The "old" modules refer to:
2eb65d67afbf9364b525b657f1475d1a2cbc27de
ALSA: dice: expand timeout to wait for Dice notification

These work like kernel ~4.4 did on the new kernel, just needed to include 
<linux/sched/signal.h> to get it to compile.

New modules are as shipped as in kernel 4.11.12, might contain realtime 
patches. Also tried with mainline kernel 4.13's modules with same results.

The commit that breaks it for my DAC is the one directly after "old" when it 
comes to the DICE module:
0d5ee195b1091e6ebcc121c091ce8646e95a48b6
ALSA: dice: limit to current sampling transfer frequency

I don't notice any difference between the commit that "breaks" and current 
stable (4.13) when it comes to behaviour.

Suspected cause
---------------

I haven't read too much of the source code and all the development over time, 
so this is just a guess.

Before the module would probably just send the audio stream and hope it works 
whereas the newer versions try to do it properly, perhaps violating some 
standard.

The fact that according to procfs DAC's status is locked even when not playing 
might be why the current module will refuse to play at any different 
frequency. At least, that is what I think the description of 
0d5ee195b1091e6ebcc121c091ce8646e95a48b6 is describing.

So probably some quirk in my DAC's firmware is causing this. I remember that 
the Windows drivers always locked even without playback. Changing frequency 
from the driver software caused DAC display to update instantly with the lock 
changing shortly after. Though I believe Focusrite's software did the same 
thing for the mic interface.

lspci -vv of my firewire card
-----------------------------

Doubt this is related, but just in case.
03:00.0 FireWire (IEEE 1394): Texas Instruments XIO2200A IEEE-1394a-2000 
Controller (PHY/Link) (rev 01) (prog-if 10 [OHCI])
        Subsystem: AFAVLAB Technology Inc Device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32 (500ns min, 1000ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at fb704000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at fb700000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
        Kernel driver in use: firewire_ohci
        Kernel modules: firewire_ohci

P.S. Seems my DAC has dedicated stereo channels for DSD128 (probably also for 
DSD64) besides the PCM stereo channels. Any idea if/how that may work?

Melvin Vermeeren.
--nextPart2177518.l4YsraJrz4
Content-Disposition: attachment; filename="new_96000.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="new_96000.txt"

sections:
  global: offset 10, size 95
  tx: offset 105, size 142
  rx: offset 247, size 282
  ext_sync: offset 529, size 4
  unused2: offset 0, size 0
global:
  owner: ffc0:000100000000
  notification: 00000040
  nick name: Stereo192-DSD DAC
  clock select: internal 44100
  enable: 1
  status: locked 44100
  ext status: 00000040
  sample rate: 44100
  version: 1.0.12.0
  clock caps: 44100 48000 88200 96000 176400 192000 aes2 aes3 aes4 adat wc arx1
  clock source names: Unused\AES\TOSLINK\SPDIF\Unused\ADAT\Unused\Stereo192DAC\Unused\Unused\Unused\Unused\Unused\\
tx 0:
  iso channel: 0
  audio channels: 8
  midi ports: 0
  speed: S400
  names: AES L\AES R\TOSLINK L\TOSLINK R\SPDIF L\SPDIF R\ADAT0\ADAT1\\
  ac3 caps: 00000000
  ac3 enable: 00000000
rx 0:
  iso channel: 1
  sequence start: 0
  audio channels: 4
  midi ports: 0
  names: ANALOG L\ANALOG R\DSD1281\DSD1282\\
  ac3 caps: 00000000
  ac3 enable: 00000000
ext status:
  clock source: internal
  locked: 1
  rate: 44100
  adat user data: -

--nextPart2177518.l4YsraJrz4
Content-Disposition: attachment; filename="new_44100.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="new_44100.txt"

sections:
  global: offset 10, size 95
  tx: offset 105, size 142
  rx: offset 247, size 282
  ext_sync: offset 529, size 4
  unused2: offset 0, size 0
global:
  owner: ffc0:000100000000
  notification: 00000040
  nick name: Stereo192-DSD DAC
  clock select: internal 44100
  enable: 1
  status: locked 44100
  ext status: 00000040
  sample rate: 44100
  version: 1.0.12.0
  clock caps: 44100 48000 88200 96000 176400 192000 aes2 aes3 aes4 adat wc arx1
  clock source names: Unused\AES\TOSLINK\SPDIF\Unused\ADAT\Unused\Stereo192DAC\Unused\Unused\Unused\Unused\Unused\\
tx 0:
  iso channel: 0
  audio channels: 8
  midi ports: 0
  speed: S400
  names: AES L\AES R\TOSLINK L\TOSLINK R\SPDIF L\SPDIF R\ADAT0\ADAT1\\
  ac3 caps: 00000000
  ac3 enable: 00000000
rx 0:
  iso channel: 1
  sequence start: 0
  audio channels: 4
  midi ports: 0
  names: ANALOG L\ANALOG R\DSD1281\DSD1282\\
  ac3 caps: 00000000
  ac3 enable: 00000000
ext status:
  clock source: internal
  locked: 1
  rate: 44100
  adat user data: -

--nextPart2177518.l4YsraJrz4
Content-Disposition: attachment; filename="new_nostream.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="new_nostream.txt"

sections:
  global: offset 10, size 95
  tx: offset 105, size 142
  rx: offset 247, size 282
  ext_sync: offset 529, size 4
  unused2: offset 0, size 0
global:
  owner: ffc0:000100000000
  notification: 00000040
  nick name: Stereo192-DSD DAC
  clock select: internal 44100
  enable: 0
  status: locked 44100
  ext status: 00000000
  sample rate: 44100
  version: 1.0.12.0
  clock caps: 44100 48000 88200 96000 176400 192000 aes2 aes3 aes4 adat wc arx1
  clock source names: Unused\AES\TOSLINK\SPDIF\Unused\ADAT\Unused\Stereo192DAC\Unused\Unused\Unused\Unused\Unused\\
tx 0:
  iso channel: -1
  audio channels: 8
  midi ports: 0
  speed: S400
  names: AES L\AES R\TOSLINK L\TOSLINK R\SPDIF L\SPDIF R\ADAT0\ADAT1\\
  ac3 caps: 00000000
  ac3 enable: 00000000
rx 0:
  iso channel: -1
  sequence start: 0
  audio channels: 4
  midi ports: 0
  names: ANALOG L\ANALOG R\DSD1281\DSD1282\\
  ac3 caps: 00000000
  ac3 enable: 00000000
ext status:
  clock source: internal
  locked: 1
  rate: 44100
  adat user data: -

--nextPart2177518.l4YsraJrz4
Content-Disposition: attachment; filename="old_44100.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="old_44100.txt"

sections:
  global: offset 10, size 95
  tx: offset 105, size 142
  rx: offset 247, size 282
  ext_sync: offset 529, size 4
  unused2: offset 0, size 0
global:
  owner: ffc0:000100000000
  notification: 00000050
  nick name: Stereo192-DSD DAC
  clock select: internal 44100
  enable: 1
  status: locked 44100
  ext status: 00000040
  sample rate: 44100
  version: 1.0.12.0
  clock caps: 44100 48000 88200 96000 176400 192000 aes2 aes3 aes4 adat wc arx1
  clock source names: Unused\AES\TOSLINK\SPDIF\Unused\ADAT\Unused\Stereo192DAC\Unused\Unused\Unused\Unused\Unused\\
tx 0:
  iso channel: 0
  audio channels: 8
  midi ports: 0
  speed: S400
  names: AES L\AES R\TOSLINK L\TOSLINK R\SPDIF L\SPDIF R\ADAT0\ADAT1\\
  ac3 caps: 00000000
  ac3 enable: 00000000
rx 0:
  iso channel: 1
  sequence start: 0
  audio channels: 4
  midi ports: 0
  names: ANALOG L\ANALOG R\DSD1281\DSD1282\\
  ac3 caps: 00000000
  ac3 enable: 00000000
ext status:
  clock source: internal
  locked: 1
  rate: 44100
  adat user data: -

--nextPart2177518.l4YsraJrz4
Content-Disposition: attachment; filename="old_nostream.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="old_nostream.txt"

sections:
  global: offset 10, size 95
  tx: offset 105, size 142
  rx: offset 247, size 282
  ext_sync: offset 529, size 4
  unused2: offset 0, size 0
global:
  owner: ffc0:000100000000
  notification: 00000040
  nick name: Stereo192-DSD DAC
  clock select: internal 96000
  enable: 0
  status: locked 96000
  ext status: 00000000
  sample rate: 96000
  version: 1.0.12.0
  clock caps: 44100 48000 88200 96000 176400 192000 aes2 aes3 aes4 adat wc arx1
  clock source names: Unused\AES\TOSLINK\SPDIF\Unused\ADAT\Unused\Stereo192DAC\Unused\Unused\Unused\Unused\Unused\\
tx 0:
  iso channel: -1
  audio channels: 8
  midi ports: 0
  speed: S400
  names: AES L\AES R\TOSLINK L\TOSLINK R\SPDIF L\SPDIF R\ADAT0\ADAT1\\
  ac3 caps: 00000000
  ac3 enable: 00000000
rx 0:
  iso channel: -1
  sequence start: 0
  audio channels: 4
  midi ports: 0
  names: ANALOG L\ANALOG R\DSD1281\DSD1282\\
  ac3 caps: 00000000
  ac3 enable: 00000000
ext status:
  clock source: internal
  locked: 1
  rate: 96000
  adat user data: -

--nextPart2177518.l4YsraJrz4
Content-Disposition: attachment; filename="old_96000.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="old_96000.txt"

sections:
  global: offset 10, size 95
  tx: offset 105, size 142
  rx: offset 247, size 282
  ext_sync: offset 529, size 4
  unused2: offset 0, size 0
global:
  owner: ffc0:000100000000
  notification: 00000040
  nick name: Stereo192-DSD DAC
  clock select: internal 96000
  enable: 1
  status: locked 96000
  ext status: 00000040
  sample rate: 96000
  version: 1.0.12.0
  clock caps: 44100 48000 88200 96000 176400 192000 aes2 aes3 aes4 adat wc arx1
  clock source names: Unused\AES\TOSLINK\SPDIF\Unused\ADAT\Unused\Stereo192DAC\Unused\Unused\Unused\Unused\Unused\\
tx 0:
  iso channel: 0
  audio channels: 8
  midi ports: 0
  speed: S400
  names: AES L\AES R\TOSLINK L\TOSLINK R\SPDIF L\SPDIF R\ADAT0\ADAT1\\
  ac3 caps: 00000000
  ac3 enable: 00000000
rx 0:
  iso channel: 1
  sequence start: 0
  audio channels: 4
  midi ports: 0
  names: ANALOG L\ANALOG R\DSD1281\DSD1282\\
  ac3 caps: 00000000
  ac3 enable: 00000000
ext status:
  clock source: internal
  locked: 1
  rate: 96000
  adat user data: -

--nextPart2177518.l4YsraJrz4--

--nextPart2206105.UFIvYMkTZA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEETnzUjuV5O+rCrz6nRiwQnTrHuFkFAlm9mSsACgkQRiwQnTrH
uFkfDQ/+K/NCKsUW0qhBnPUOdBqmMLP18p8U8/MuqCCHZ/t4To/jypYmeU5b+hXG
4zH9QSbdaI+7GwI3iyhHDg5KKXdMK6roKOu6eT5Zq8UmbHcOavWRz6saAW7YS4ye
3ws6BDZuoGzDVYF8GIpV27mAD1DQXACk9kWJCD/8A1paZjBZ/z8Kw93/i430c8pO
g2PfwaNB3bVvEHkfT9OAyFN63luX8JOkSUCe+8hfCKanromC3gR9QsGEHxaoXqcm
XzwoLdmsf40KYrB51QqkJRbC7hOsOabngEd0Imshl6t0YTmBgtl6pd9lMvcnnh5W
1HfPDnrUOZQXXrXwFMHbWElykFnGwg8xzTQypHG6jTGrdMEg9XRhq7L14BfRxXR1
UJJzHMcXLkFEkDnDINfVIvwnAIwMF/iOqaNQVMi5C4wqWAKl91bu6ULl9zzLHHYf
9nIMnhp7Z92wP8sNVmoKh0W4NoPebXtFLCnBEpBvATJIvDhmmtLYiM2/oQ5NmV2i
Kisw6Puptole9lpCsOAo4g0LuVZJfMeIHjed5XrYww6lK1oDceAcpTr/B5Km64La
/bzDBQlASff30DxA6gZixNQovV46LcGALPG4+K5O0zP7NI1eEV1h8Qx4yi2n8qxQ
7CKBNs8c6Uau+UWp8rMfuR7N/Q6yanX6HrnqNeffdx2XfgmJt80=
=h1D3
-----END PGP SIGNATURE-----

--nextPart2206105.UFIvYMkTZA--


--===============3333570698531110957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3333570698531110957==--
