From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 0/3] ALSA: fireface: new driver for RME
	Fireface series (MIDI only)
Date: Sun,  6 Dec 2015 22:23:41 +0900
Message-ID: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id F0DFD265341
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 14:23:49 +0100 (CET)
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

This patchset is to add a new driver for RME Fireface series. This is still
working in progress but currently the new driver support MIDI functionality.

Unfortunately, ffado library can disturb this functionality.
In RME::Device::init_hardware() function, the library sends a write transaction
to 0x0000801003f4 with invalid value as higher part of address in IEEE 1212 or
ISO/IEC 13213. This is a worst case I describe in patch 03.

A workaround is to load this module after running ffado library. This module
sends write transactions with valid values and regain MIDI functionality.

I think it better that FFADO developers fixes the bug as long as they doesn't
support MIDI functionality.

Takashi Sakamoto (3):
  fireface: add skeleton for RME Fireface series
  fireface: add transaction support
  fireface: add support for MIDI functionality

 sound/firewire/Kconfig                         |   7 +
 sound/firewire/Makefile                        |   1 +
 sound/firewire/fireface/Makefile               |   2 +
 sound/firewire/fireface/fireface-midi.c        | 129 ++++++++
 sound/firewire/fireface/fireface-transaction.c | 388 +++++++++++++++++++++++++
 sound/firewire/fireface/fireface.c             | 151 ++++++++++
 sound/firewire/fireface/fireface.h             |  73 +++++
 7 files changed, 751 insertions(+)
 create mode 100644 sound/firewire/fireface/Makefile
 create mode 100644 sound/firewire/fireface/fireface-midi.c
 create mode 100644 sound/firewire/fireface/fireface-transaction.c
 create mode 100644 sound/firewire/fireface/fireface.c
 create mode 100644 sound/firewire/fireface/fireface.h

-- 
2.5.0
