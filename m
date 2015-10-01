From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/7 v3] firewire-tascam: new driver for TASCAM
	FireWire series
Date: Thu,  1 Oct 2015 22:02:10 +0900
Message-ID: <1443704537-3345-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 8422C2666F2
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 15:02:22 +0200 (CEST)
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

This patchset updates a part of my former post:

[alsa-devel] [PATCH 00/25 v2] ALSA: support AMDTP variants
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/096739.html

This patchset adds support for a part of TASCAM FireWire series. This
patchset supports their streaming and PCM functionalities, while their
MIDI functionalities are not supported yet. In future work, the
functionalities will be supported.

Takashi Sakamoto (7):
  ALSA: firewire-tascam: add skeleton for TASCAM FireWire series
  ALSA: firewire-tascam: add a structure for model-dependent parameters.
  ALSA: firewire-tascam: add proc node to show firmware information
  ALSA: firewire-tascam: add data block processing layer
  ALSA: firewire-tascam: add streaming functionality
  ALSA: firewire-tascam: add PCM functionality
  ALSA: firewire-tascam: add hwdep interface

 include/uapi/sound/asound.h           |   3 +-
 include/uapi/sound/firewire.h         |   1 +
 sound/firewire/Kconfig                |  12 +
 sound/firewire/Makefile               |   1 +
 sound/firewire/tascam/Makefile        |   3 +
 sound/firewire/tascam/amdtp-tascam.c  | 243 +++++++++++++++++
 sound/firewire/tascam/tascam-hwdep.c  | 201 ++++++++++++++
 sound/firewire/tascam/tascam-pcm.c    | 312 +++++++++++++++++++++
 sound/firewire/tascam/tascam-proc.c   |  88 ++++++
 sound/firewire/tascam/tascam-stream.c | 496 ++++++++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.c        | 213 +++++++++++++++
 sound/firewire/tascam/tascam.h        | 117 ++++++++
 12 files changed, 1689 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/tascam/Makefile
 create mode 100644 sound/firewire/tascam/amdtp-tascam.c
 create mode 100644 sound/firewire/tascam/tascam-hwdep.c
 create mode 100644 sound/firewire/tascam/tascam-pcm.c
 create mode 100644 sound/firewire/tascam/tascam-proc.c
 create mode 100644 sound/firewire/tascam/tascam-stream.c
 create mode 100644 sound/firewire/tascam/tascam.c
 create mode 100644 sound/firewire/tascam/tascam.h

-- 
2.1.4
