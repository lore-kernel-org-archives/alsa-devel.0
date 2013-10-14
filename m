From: Takashi Sakamoto <o-takashi-sodqOivclbsO3cATojSK5Q@public.gmane.org>
Subject: [LAD] Call for testing: ALSA driver for Fireworks/BeBoB based
	devices
Date: Mon, 14 Oct 2013 12:17:31 +0900
Message-ID: <525B624B.4060906@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
 <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
 <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "ffado-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org" <ffado-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org>, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi all,

This is a call for testing my ALSA driver for Fireworks/BeBoB based devices.

Please test 'snd-fireworks' for Fireworks and 'snd-bebob' for BeBoB if
you have some devices listed in the end of this mail.

Status:
- still under development
- Without snd-dice and Clemens' development (I must do this later)

Functionality:
- playback/capturing (full duplex) with PCM/MIDI interface
- hardware metering for some devices with CONTROL interface
- switching clock source/digital interface/digital mode with CONTROL
interface
- print hardware status with PROC interface

Note:
- Don't use simultaneously 'ALSA PCM/MIDI playback/capture' and 'jackd
with Firewire (FFADO) backend'. Both of them try connecting to the
device when another is running.
- I add much modification into snd-firewire-lib for full duplex
synchronization of receive/transmit AMDTP stream.

Requirement:
- Linux kernel 3.11 or later because of Juju (nickname of Firewire
stack) changing its API.
- Dynamic Kernel Module Support (DKMS) is reccomended for safely
installing/uninstalling
(I work with Ubuntu 13.10)

Bug report:
- report with /proc/asound/cardX/#XXX
- please send your experiences to me with the output

How to install (DKMS):
1. $ git clone https://github.com/takaswie/snd-firewire-improve.git
2. $ ln -s $(pwd)/snd-firewire-improve/ /usr/src/alsa-firewire-3.11
(superuser)
3. $ dkms install snd-firewire/3.11 (superuser)

How to uninstall (DKMS):
1. $ modprobe -r snd-bebob snd-fireworks snd-firewire-lib (superuser)
2. $ dkms remove ans-firewire/3.11 --all (superuser)
3. $ rm /usr/src/alsa-firewire-3.11 (superuser)
4. $ rm snd-firewire-improve

How to install (Manual):
1. $ git clone https://github.com/takaswie/snd-firewire-improve.git
2. $ cd snd-firewire-improve
3. $ make
4, backup system snd-firewire-lib/snd-firewire-speakers/snd-isight
(superuser)
5. install
snd-firewire-lib/snd-firewire-speakers/snd-isight/snd-fireworks/snd-bebob (superuser)
6. depmod -a (superuser)

How to uninstall (Manual)
1. modprobe -r snd-firewire-lib snd-firewire-speakers snd-isight
snd-fireworks snd-bebob (superuser)
2. remove
snd-firewire-lib/snd-firewire-speakers/snd-isight/snd-fireworks/snd-bebob (superuser)
3. recover snd-firewire-lib/snd-firewire-speakers/snd-isight (superuser)
4. depmod -a (superuser)

Confirmed to work:
- AudioFire4
- AudioFirePre8
- Ozonic
- Firewire Solo
- Firewire Audiophile
- Firewire 410

== Fireworks based devices
[Echo Audio]
AudioFire2
AudioFire4
AudioFirePre8
AudioFire8 (till 2009)
AudioFire8 (since 2009)
AudioFire12

[Gibson]
RIP

[Mackie]
Onyx 400F
Onyx 1200F

== BeBoB based devices
[Yamaha]
GO44
GO46

[M-Audio]
(to control mixer channels please use FFADO upstream)
Ozonic
Firewire 410
Firewire Audiophile
Firewire Solo
NRV10
ProFireLightbridge

[Focusrite]
SaffirePro 26 I/O
SaffirePro 10 I/O
Saffire(LE)

[Edirol]
FA-66
FA-101

[TerraTecElectronic GmbH]
Phase88FW
PhaseX24FW

[PreSonus]
FireBox
FirePod

[Mackie]
OnyxFirewire

[Tascam]
IF-FW/DM

[Behringer]
X32

[ApogeeElectronics]
Rosetta200

[ESI]
Quatafire610


Regards

Takashi Sakamoto
o-takashi-sodqOivclbsO3cATojSK5Q@public.gmane.org
