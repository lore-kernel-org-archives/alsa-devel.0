From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/15 v5] ALSA: Enhancement for existed
	FireWire drivers
Date: Tue,  9 Dec 2014 00:10:34 +0900
Message-ID: <1418051449-18371-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 59F2B26045C
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 16:10:58 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This patchset is the rest of patches to enable ALSA Dice and OXFW driver
to handle more models. This patchset is for linux-next branch.


== Updates from my previous post:

[alsa-devel] [PATCH 00/30 v4] ALSA: Enhancement for existed FireWire drivers
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-December/085092.html

 - use the same functions for each of MIDI .open/.close callback (dice)
 - fix a comment for AV/C stream format information command (oxfw)
 - revert shortname template, just use model name (oxfw)

I note that OXFW driver uses the shortname for MIDI substream name, which
has 32 bytes, thus the string in shortname should not be so long.


== Supplemental patch for userspace library

This patchset adds Hwdep functionality for OXFW driver, thus userspace
library needs a patch for entries of snd_hwdep_iface_t. Please apply
below patch.

[alsa-devel] [PATCH alsa-lib] hwdep: add OXFW driver support
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/084824.html


Takashi Sakamoto (15):
  ALSA: dice: Change the way to start stream
  ALSA: dice: Add support for duplex streams with synchronization
  ALSA: dice: Support for non SYT-Match sampling clock source mode
  ALSA: dice: Add support for capturing PCM samples
  ALSA: dice: Add support for MIDI capture/playback
  ALSA: oxfw: Change the way to name card
  ALSA: oxfw: Add support for AV/C stream format command to get/set
    supported stream formation
  ALSA: oxfw: Change the way to make PCM rules/constraints
  ALSA: oxfw: Add proc interface for debugging purpose
  ALSA: oxfw: Change the way to start stream
  ALSA: oxfw: Add support for Behringer/Mackie devices
  ALSA: oxfw: Add support AMDTP in-stream
  ALSA: oxfw: add support for capturing PCM samples
  ALSA: oxfw: Add support for capture/playback MIDI messages
  ALSA: oxfw: Add hwdep interface

 include/uapi/sound/asound.h            |   3 +-
 include/uapi/sound/firewire.h          |   3 +-
 sound/firewire/Kconfig                 |  10 +-
 sound/firewire/dice/Makefile           |   4 +-
 sound/firewire/dice/dice-midi.c        | 157 ++++++++
 sound/firewire/dice/dice-pcm.c         | 251 +++++++++----
 sound/firewire/dice/dice-stream.c      | 332 ++++++++++++----
 sound/firewire/dice/dice-transaction.c |   5 -
 sound/firewire/dice/dice.c             |  37 +-
 sound/firewire/dice/dice.h             |  33 +-
 sound/firewire/oxfw/Makefile           |   3 +-
 sound/firewire/oxfw/oxfw-command.c     | 153 ++++++++
 sound/firewire/oxfw/oxfw-hwdep.c       | 190 ++++++++++
 sound/firewire/oxfw/oxfw-midi.c        | 207 ++++++++++
 sound/firewire/oxfw/oxfw-pcm.c         | 425 +++++++++++++++------
 sound/firewire/oxfw/oxfw-proc.c        | 113 ++++++
 sound/firewire/oxfw/oxfw-stream.c      | 667 +++++++++++++++++++++++++++++++--
 sound/firewire/oxfw/oxfw.c             | 179 +++++++--
 sound/firewire/oxfw/oxfw.h             | 104 ++++-
 19 files changed, 2499 insertions(+), 377 deletions(-)
 create mode 100644 sound/firewire/dice/dice-midi.c
 create mode 100644 sound/firewire/oxfw/oxfw-command.c
 create mode 100644 sound/firewire/oxfw/oxfw-hwdep.c
 create mode 100644 sound/firewire/oxfw/oxfw-midi.c
 create mode 100644 sound/firewire/oxfw/oxfw-proc.c

-- 
2.1.0
