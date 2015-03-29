From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC v2][PATCH 00/11] digi00x: new driver for
	Digidesign 002/003 family
Date: Mon, 30 Mar 2015 00:05:20 +0900
Message-ID: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FC232604BC
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 17:05:43 +0200 (CEST)
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
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This patchset is revised version of my previous set.

[alsa-devel] [RFC][PATCH 00/11] digi00x: new driver for Digidesign 002/003 family
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-March/089141.html

Improvements from the previous set:
 * improve double-oh-three (DOT) application
 * extend hwdep interface for asynchronous messaging
 * limit sampling rate for PCM substream when clock source is external or
   any PCM substreams are running
 * support s16 samples for PCM playback

In this time, I test PCM functionality with my test programs. As a result,
I can confirm that S/PDIF and ADAT output from my Digi 002 Rack includes
expected PCM samples as my programs generates. I think we can judge the
implementation of DOT is proper for Digi 002 rack.

Currently, several issues remains:
 * The port for MIDI machine control message is not tested yet, because
   002/003 console model are required.
 * When allocates 2 or more channel numbers for the device, after 15 to 20
   seconds from playbacking, any PCM samples causes noisy sound. Then, all
   of LED on the front panel light. The streaming still continues correctly.
 * The actual effects of external clock source is not clear. When set the
   clock source is somewhat external, even if stopping the clock source,
   the device continues to sound PCM samples against my expectation.
 * The meaning of asynchronous messages is unknown. This patchset adds
   a functionality to receive it in userspace. You can test it with
   updated libhinawa sample script.
   https://github.com/takaswie/libhinawa

Well, I'll stop my work for this driver in this developing period
(for Linux 4.0), because this work is not in my original plan. I hope any
users test this driver and report the result till Linux 4.2 merge window.
If not, this driver will not be merged into upstream, naturally.

I prepare for DKMS package to test this patchset. Please use it if needed.
https://github.com/takaswie/snd-firewire-improve

Takashi Sakamoto (11):
  ALSA: digi00x: add skeleton for Digi 002/003 device driver
  ALSA: digi00x: add streaming functionality
  ALSA: digi00x: add proc node for clock status
  ALSA: digi00x: add PCM functionality
  ALSA: digi00x: add MIDI functionality
  ALSA: digi00x: add hwdep interface
  ALSA: digi00x: support unknown asynchronous message
  ALSA: digi00x: support MIDI ports for device control
  ALSA: firewire-lib: allows to implement external MIDI callback function
  ALSA: digi00x: improve MIDI capture/playback
  ALSA: digi00x: apply double-oh-three algorithm to multiplex PCM samples

 include/uapi/sound/asound.h               |   3 +-
 include/uapi/sound/firewire.h             |   8 +
 sound/firewire/Kconfig                    |  10 +
 sound/firewire/Makefile                   |   1 +
 sound/firewire/amdtp.c                    |  30 ++-
 sound/firewire/amdtp.h                    |   5 +
 sound/firewire/digi00x/Makefile           |   3 +
 sound/firewire/digi00x/digi00x-hwdep.c    | 200 +++++++++++++++
 sound/firewire/digi00x/digi00x-midi.c     | 199 +++++++++++++++
 sound/firewire/digi00x/digi00x-pcm.c      | 344 +++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-proc.c     |  86 +++++++
 sound/firewire/digi00x/digi00x-protocol.c | 406 ++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-stream.c   | 393 +++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c          | 179 +++++++++++++
 sound/firewire/digi00x/digi00x.h          | 167 ++++++++++++
 15 files changed, 2026 insertions(+), 8 deletions(-)
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
