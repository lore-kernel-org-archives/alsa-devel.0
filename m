From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 00/11] digi00x: new driver for Digidesign
	002/003 family
Date: Mon, 16 Mar 2015 01:00:58 +0900
Message-ID: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC0D2607C8
 for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2015 17:01:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, robin@gareus.org, damien@zamaudio.com
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This patchset adds an experimental driver for Digidesign 002/003 family.
If you have any models, please test with this driver and report the result.

Currently, this driver correctly supports these major functionalities:
(as long as I tested)
 * PCM sample capture
 * MIDI messages capture
 * MIDI messages playback

And functionalities which need to be tested:
 * streaming with S/PDIF, ADAT and work clock source
 * MIDI device control

And includes a bug which should be fixed:
 * PCM sample playback

For a driver for these models, there was a preceding implementation by
Robin Gareus and Damien Zammit.
[alsa-devel] draft -- ALSA firewire + digi003
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-January/058177.html

This patchset includes their implementation, called-as double-oh-three,
to multiplex PCM samples into CIP packet. As long as I test, their
implementation may includes any bugs and this driver still causes noisy
sound in several cases, while I confirm to get the same data block pattern
which Robin explains.
http://gareus.org/wiki/digi003

If you interested in this bug and tries to fix it, my packet dump may be
helpfull. Please see:
http://subversion.ffado.org/wiki/digi003rack
 * 96khz-24bit-1ch.log (27.5 kB)
 * 44khz-24bit-1ch.log (49.8 kB)
 * 44khz-24bit-2ch.log (49.8 kB)

And DKMS package is available on my github repository.
https://github.com/takaswie/snd-firewire-improve

Takashi Sakamoto (11):
  ALSA: digi00x: add skelton for Digi 002/003 device driver
  ALSA: digi00x: add streaming functionality
  ALSA: digi00x: add proc node for clock status
  ALSA: digi00x: add PCM functionality
  ALSA: digi00x: add MIDI functionality
  ALSA: digi00x: add hwdep interface
  ALSA: digi00x: support unknown asynchronous message
  ALSA: digi00x: support MIDI ports for device control
  ALSA: firewire-lib: allows to implement external MIDI callback
    function
  digi00x: improve MIDI capture/playback
  ALSA: digi00x: apply double-oh-three algorism to multiplex PCM samples

 include/uapi/sound/asound.h               |   3 +-
 include/uapi/sound/firewire.h             |   1 +
 sound/firewire/Kconfig                    |  10 +
 sound/firewire/Makefile                   |   1 +
 sound/firewire/amdtp.c                    |  30 ++-
 sound/firewire/amdtp.h                    |   5 +
 sound/firewire/digi00x/Makefile           |   3 +
 sound/firewire/digi00x/digi00x-hwdep.c    | 192 ++++++++++++++
 sound/firewire/digi00x/digi00x-midi.c     | 199 +++++++++++++++
 sound/firewire/digi00x/digi00x-pcm.c      | 336 +++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-proc.c     |  71 ++++++
 sound/firewire/digi00x/digi00x-protocol.c | 361 +++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-stream.c   | 398 ++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c          | 179 ++++++++++++++
 sound/firewire/digi00x/digi00x.h          | 126 ++++++++++
 15 files changed, 1907 insertions(+), 8 deletions(-)
 create mode 100644 sound/firewire/digi00x/Makefile
 create mode 100644 sound/firewire/digi00x/digi00x-hwdep.c
 create mode 100644 sound/firewire/digi00x/digi00x-midi.c
 create mode 100644 sound/firewire/digi00x/digi00x-pcm.c
 create mode 100644 sound/firewire/digi00x/digi00x-proc.c
 create mode 100644 sound/firewire/digi00x/digi00x-protocol.c
 create mode 100644 sound/firewire/digi00x/digi00x-stream.c
 create mode 100644 sound/firewire/digi00x/digi00x.c
 create mode 100644 sound/firewire/digi00x/digi00x.h

-- 
2.1.0
