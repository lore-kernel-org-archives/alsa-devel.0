From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC v2][PATCH 00/11] ALSA: fireface: new driver for
	RME Fireface series
Date: Sun, 20 Dec 2015 21:28:32 +0900
Message-ID: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 887822606D2
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 13:28:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is to update my previous one with mostly full features as an
driver in ALSA firewire stack:

[alsa-devel] [RFC][PATCH 0/3] ALSA: fireface: new driver for RME Fireface series (MIDI only)
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/101576.html

Changes from RFCv1:
 * Support own quirk of packet streaming
 * Add own data block processing layer
 * Support PCM functionality
 * Add proc node to help debugging
 * Add hwdep interface

I note that just powering on, the device is muted. Thus, the device generates no
sound even if packet streaming is successful. You can de-mute it by write
transaction. For example, by using 'firewire-request' command in
linux-firewire-utils(https://github.com/cladisch/linux-firewire-utils):

$ ./firewire-request /dev/fw1 write 0x0000801c0000 0x000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010000000100000001000000

Currently, libffado gives no way to do it via its mixer interface. Instead, done
in methods to start streaming. I think it better to move de-mute codes to mixer
initialization.

There's an issue of periodical hissing noise. I observed this with Fireface 400.
Interval of the noise differs depending on the situation (10-20 minutes) and
continues around 20 seconds. The cause is not clear but I've experienced similar
issue with TASCAM FireOne. A common point between these two models is
non-blocking transmission. I guess that the cause may be on data block
calculation in AMDTP packet streaming layer (calculate_data_blocks() function
in sound/firewire/amdtp-stream.c). Further investigation is required.

In my previous RFC, I described that zero bits have no effect in write
transactions to 0x00008010051c. But this is wrong. The transaction has
side effect to set the other options. In this patchset, the state of clock
is changed on the way to initialize transaction. This is a bit rude but
unavoidable. Fortunately, it's software's responsibility to read from flash
memory and set initial configuration, thus I think this change is approval
because just powering on the state of device is against user's configuration.
The loading and configuring are still userspace responsibility.

MIDI functionality can be disabled when any userspace applications run with
libffado, as I described. This is a bug of libffado due to node ID handling.
In line 199 of libffado/src/rme/fireface_hw.cpp, node id is handled as
uint16_t value. This is a fashion of libffado to represent Node ID by lower 6
bits of actual Node ID of IEEE 1394 bus. In the other lines, actual Node Id is
constructed with 0xffc0. Just using the raw value returned by
ConfigRom::getNodeId() is invalid.


For this work, I can borrow test device (Fireface 400) from Syntax Japan Inc.
It's my fortune to have an opportunity to contact to the company. I'm graceful
to Takeshi Mitsuhashi, Tahiro Hashizume and their kindness. Thank you.


Takashi Sakamoto (11):
  fireface: add skeleton for RME Fireface series
  fireface: postpone sound card registration
  fireface: add model specific structure
  fireface: add transaction support
  fireface: add support for MIDI functionality
  fireface: add proc node to help debugging
  firewire-lib: add no-header packet processing
  fireface: add data processing layer
  fireface: add stream management functionality
  fireface: add PCM functionality
  fireface: add hwdep interface

 include/uapi/sound/asound.h                    |   3 +-
 include/uapi/sound/firewire.h                  |   1 +
 sound/firewire/Kconfig                         |   7 +
 sound/firewire/Makefile                        |   1 +
 sound/firewire/amdtp-stream.c                  | 104 +++++--
 sound/firewire/amdtp-stream.h                  |   2 +
 sound/firewire/fireface/Makefile               |   4 +
 sound/firewire/fireface/amdtp-ff.c             | 221 ++++++++++++++
 sound/firewire/fireface/fireface-hwdep.c       | 191 ++++++++++++
 sound/firewire/fireface/fireface-midi.c        | 131 ++++++++
 sound/firewire/fireface/fireface-pcm.c         | 390 ++++++++++++++++++++++++
 sound/firewire/fireface/fireface-proc.c        | 237 +++++++++++++++
 sound/firewire/fireface/fireface-stream.c      | 397 +++++++++++++++++++++++++
 sound/firewire/fireface/fireface-transaction.c | 301 +++++++++++++++++++
 sound/firewire/fireface/fireface.c             | 210 +++++++++++++
 sound/firewire/fireface/fireface.h             | 131 ++++++++
 16 files changed, 2313 insertions(+), 18 deletions(-)
 create mode 100644 sound/firewire/fireface/Makefile
 create mode 100644 sound/firewire/fireface/amdtp-ff.c
 create mode 100644 sound/firewire/fireface/fireface-hwdep.c
 create mode 100644 sound/firewire/fireface/fireface-midi.c
 create mode 100644 sound/firewire/fireface/fireface-pcm.c
 create mode 100644 sound/firewire/fireface/fireface-proc.c
 create mode 100644 sound/firewire/fireface/fireface-stream.c
 create mode 100644 sound/firewire/fireface/fireface-transaction.c
 create mode 100644 sound/firewire/fireface/fireface.c
 create mode 100644 sound/firewire/fireface/fireface.h

-- 
2.5.0
