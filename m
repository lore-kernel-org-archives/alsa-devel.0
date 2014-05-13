From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 00/15 v4] OXFW driver,
	a succesor to firewire-speakers
Date: Tue, 13 May 2014 23:27:37 +0900
Message-ID: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BF1426550E
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 16:28:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This patchset updates a part of my previous series:

[alsa-devel] [RFC v3] [PATCH 00/52] Enhancement for support of firewire devices
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071820.html

This patchset is based on this series. (This series is under reviewing.)
[alsa-devel] [PATCH 00/49 v4] Enhancement for support of Firewire devices
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-April/075841.html

If you try this patchset, please apply the series in advance and apply this patchset.

Or just use backport codes in my github repository:
https://github.com/takaswie/snd-firewire-improve

Or if you use Ubuntu 14.04, DKMS package is available from David's PPA.
(Special thanks to David Henningsson.)
https://launchpad.net/~diwic/+archive/snd-firewire-improve

If you have Griffin FireWave, I would strongly request to test. Please see 'An issue for FireWave' in this message.

== Background
Currently, in ALSA, 'firewire-speakers' driver supports OXFW970/971 chipset which Oxford Semiconductor produced. But this driver has some restrictions:
 - Don't support MIDI substreams
 - Don't support substreams for PCM/MIDI capturing
There are several devices which are based on OXFW970/971. Especially, devices which Behringer and Mackie produced support playback/capture PCM samples/MIDI messages. So firewire-speakers needs re-work to support these devices.

This patchset renames 'firewire-speakers' to 'oxfw'. Maintainers already agreed to rename firewire-speakers to suitable name, in my first RFC in Jan 2014.


== Supported devices
Currently these devices are supported:
 * Griffin Firewave
 * LaCie Firewire Speakers
 * Behringer F-Control Audio 202
 * Mackie(Loud) Onyx-i series (former models)
 * Mackie(Loud) Onyx Satellite
 * Mackie(Loud) Tapco Link.Firewire

These devices can be supported but its IDs are unknown:
 * Mackie(Loud), d.2 pro
 * Mackie(Loud), d.4 pro 
 * Mackie(Loud), U.420 
 * Mackie(Loud), U.420d 

When you have unknown devices, please inform me output of this command:
$ hexdump -C /sys/bus/firewire/devices/fwX/config_rom
(X is node id for your device. Tipically '1'.)

I tested this driver with Behringer F-Control Audio 202.


== Features
 - Capturing/Playbacking PCM samples/MIDI messages at supported sampling rates via ALSA PCM/MIDI interfaces
 - Retrieving firewire node information via ALSA hwdep interface
 - Locking/Unlocking kernel streaming via ALSA hwdep interface
 - Receiving notification at starting/stopping kernel streaming via ALSA hwdep interface


== Solutions for reported regressions
Two regressions were reported for my previous series:
1.Some names in card structure is trimmed.
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073128.html
2.The number of PCM channels are not detected correctly.
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073145.html

The cause of issue 1 is that the device has too long names in its config rom. To solve this issue, for the driver, this patchset uses the same way which firewire-speakers uses, propper alias in device-specific structure.

The cause of issue 2 is that the device has several format entries for the same sampling rate:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073561.html
To solve this issue, this patchset includes improved mechanism to detect stream formation.

Additionally, this patchset adds new device entry for Mackie(Loud) Tapco Link.Firewire, refering to FFADO bug ticket 236:
http://subversion.ffado.org/ticket/236


== An issue for FireWave

I have an issue for Griffin Firewave.

This device can handle AV/C Stream Format Information command and driver can get to know stream formations via the command. With Stefan's help, responses from FireWave against this command are clear.
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073561.html

According to these responses, supported formations are:
Input Stream to device:
	Rate	PCM	MIDI
	32000	6	0
	44100	6	0
	48000	6	0
	96000	6	0
	32000	2	0
	44100	2	0
	48000	2	0
	0	0	0
	0	0	0
	0	0	0
(I also expect to get this output from /proc/asound/FireWave/firewire/formation. I note it's order is not important.)

But current 'firewire-speakers' has PCM constraints below:
 - 6ch at 32/44.1/48/96 kHz
 - 2ch at 48/96 kHz
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073562.html

So this OXFW driver may lost a support for 2ch/96.0kHz for FireWave and gain 2ch/32.0kHz and 2ch/44.1kHz.

I don't know exactly the reason of these gaps. So I strongly hope testers to check these two items:
 - FireWave really can handle 2ch/96kHz with firewire-speakers driver.
 - FireWave really can handle 2ch/32.0kHz and 2ch/44.1kHz with oxfw driver.

I think a test with aplay is easy to execute:
$ aplay -D hw:FireWave -f S32_LE -c 2 -r 96000 /dev/urandom
$ aplay -D hw:FireWave -f S32_LE -c 2 -r 48000 /dev/urandom
$ aplay -D hw:FireWave -f S32_LE -c 2 -r 44100 /dev/urandom
$ aplay -D hw:FireWave -f S32_LE -c 2 -r 32000 /dev/urandom

If 2ch/96kHz is apparently available, I'll change codes as a quirk.

FYI, when I tested unavailable number of PCM channels with a hack, FCA202 playback PCM substreams but becomes freezed after stopping streaming.
$ cat /var/log/syslog
...
kernel: [10098.670390] snd_oxfw fw1.0: transaction failed: timeout
...

I believe the other OXFW970/971 based devices have a similar behaviour.

================
Takashi Sakamoto (15):
  speakers: Rename to oxfw and rename some members
  oxfw: Move to its own directory
  oxfw: Split stream functionality to a new file and add a header file
  oxfw: Split PCM functionality to a new file
  oxfw: Split control functionality to a new file
  oxfw: Change the way to name card
  oxfw: Change the way to make PCM rules/constraints
  oxfw: Add proc interface for debugging purpose
  oxfw: Change the way to start stream
  oxfw: Add support for AV/C stream format command to get supported
    stream formation
  oxfw: Add a quirk for Griffin FireWave
  oxfw: Add support for Behringer/Mackie devices
  oxfw: Add support AMDTP in-stream and PCM capture
  oxfw: Add support for capture/playback MIDI messages
  oxfw: Add hwdep interface

 include/uapi/sound/asound.h        |   3 +-
 include/uapi/sound/firewire.h      |   3 +-
 sound/firewire/Kconfig             |  18 +-
 sound/firewire/Makefile            |   3 +-
 sound/firewire/oxfw/Makefile       |   3 +
 sound/firewire/oxfw/oxfw.c         | 284 +++++++++++++
 sound/firewire/oxfw/oxfw.h         | 141 +++++++
 sound/firewire/oxfw/oxfw_command.c | 113 ++++++
 sound/firewire/oxfw/oxfw_control.c | 283 +++++++++++++
 sound/firewire/oxfw/oxfw_hwdep.c   | 190 +++++++++
 sound/firewire/oxfw/oxfw_midi.c    | 168 ++++++++
 sound/firewire/oxfw/oxfw_pcm.c     | 367 +++++++++++++++++
 sound/firewire/oxfw/oxfw_proc.c    |  83 ++++
 sound/firewire/oxfw/oxfw_stream.c  | 658 ++++++++++++++++++++++++++++++
 sound/firewire/speakers.c          | 792 -------------------------------------
 15 files changed, 2308 insertions(+), 801 deletions(-)
 create mode 100644 sound/firewire/oxfw/Makefile
 create mode 100644 sound/firewire/oxfw/oxfw.c
 create mode 100644 sound/firewire/oxfw/oxfw.h
 create mode 100644 sound/firewire/oxfw/oxfw_command.c
 create mode 100644 sound/firewire/oxfw/oxfw_control.c
 create mode 100644 sound/firewire/oxfw/oxfw_hwdep.c
 create mode 100644 sound/firewire/oxfw/oxfw_midi.c
 create mode 100644 sound/firewire/oxfw/oxfw_pcm.c
 create mode 100644 sound/firewire/oxfw/oxfw_proc.c
 create mode 100644 sound/firewire/oxfw/oxfw_stream.c
 delete mode 100644 sound/firewire/speakers.c

-- 
1.8.3.2
