From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Mon, 12 Oct 2015 19:10:20 +0900
Message-ID: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 7162E261294
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 12:10:30 +0200 (CEST)
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

TASCAM FireWire series driver may be newly available in Linux 4.4. For
the driver, this patchset adds ALSA MIDI ports to communicate to physical
MIDI ports.

This patchset includes some fixes, and updates my former post:

[alsa-devel] [PATCH 00/25 v2] ALSA: support AMDTP variants
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/096739.html

Changes:
 * support system exclusive messages
 * drop virtual MIDI ports
 * drop MMAP support via hwdep interface for status and control message

Although TASCAM FireWire series has physical controls, this patchset
doesn't support them. I think some facilities are required to enable this
functionality:
 * handling MIDI messages on virtual MIDI ports by this driver
 * handling status and control messages in isochronous packet by this
   driver
 * parsing the status and control messages by userspace application
 * supporting assignment of physical controls to MIDI ports by userspace
   application
 * turn on/off LEDs on device by userspace application

These work are apparently beyond my current effort.

Takashi Sakamoto (5):
  ALSA: firewire-tascam: add support for incoming MIDI messages by
    asynchronous transaction
  ALSA: firewire-tascam: add support for outgoing MIDI messages by
    asynchronous transaction
  ALSA: firewire-tascam: add support for MIDI functionality
  ALSA: firewire-tascam: Turn on/off FireWire LED
  ALSA: firewire-tascam: change device probing processing

 sound/firewire/tascam/Makefile             |   3 +-
 sound/firewire/tascam/tascam-midi.c        | 135 +++++++++++++
 sound/firewire/tascam/tascam-transaction.c | 293 +++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.c             |  89 +++++----
 sound/firewire/tascam/tascam.h             |  30 +++
 5 files changed, 503 insertions(+), 47 deletions(-)
 create mode 100644 sound/firewire/tascam/tascam-midi.c
 create mode 100644 sound/firewire/tascam/tascam-transaction.c

-- 
2.1.4
