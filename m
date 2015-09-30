From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/7 v3] firewire-digi00x: new driver for
	Digidesign 002/003 family
Date: Wed, 30 Sep 2015 09:39:15 +0900
Message-ID: <1443573562-24088-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id BDF2B2659FF
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 02:39:31 +0200 (CEST)
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

This patchset updates a part of my previous post:

[alsa-devel] [PATCH 00/25 v2] ALSA: support AMDTP variants
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/096739.html

This patchset adds support for Digidesign Digi 002/003 family without MIDI
functionality. Although most part of AMDTP stream functionality is clear,
a mechanism of clock synchronization with internal clock source is not
clear (see the last patch).

Takashi Sakamoto (7):
  ALSA: firewire-digi00x: add skeleton for Digi 002/003 family
  ALSA: firewire-digi00x: add data block processing layer
  ALSA: firewire-digi00x: add stream functionality
  ALSA: firewire-digi00x: add proc node to show clock status
  ALSA: firewire-digi00x: add PCM functionality
  ALSA: firewire-digi00x: add hwdep interface
  ALSA: firewire-digi00x: add support for asynchronous messaging

 include/uapi/sound/asound.h                  |   3 +-
 include/uapi/sound/firewire.h                |   8 +
 sound/firewire/Kconfig                       |  15 +
 sound/firewire/Makefile                      |   1 +
 sound/firewire/digi00x/Makefile              |   4 +
 sound/firewire/digi00x/amdtp-dot.c           | 330 +++++++++++++++++++++
 sound/firewire/digi00x/digi00x-hwdep.c       | 200 +++++++++++++
 sound/firewire/digi00x/digi00x-pcm.c         | 373 ++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-proc.c        |  99 +++++++
 sound/firewire/digi00x/digi00x-stream.c      | 420 +++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-transaction.c |  81 ++++++
 sound/firewire/digi00x/digi00x.c             | 169 +++++++++++
 sound/firewire/digi00x/digi00x.h             | 146 ++++++++++
 13 files changed, 1848 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/digi00x/Makefile
 create mode 100644 sound/firewire/digi00x/amdtp-dot.c
 create mode 100644 sound/firewire/digi00x/digi00x-hwdep.c
 create mode 100644 sound/firewire/digi00x/digi00x-pcm.c
 create mode 100644 sound/firewire/digi00x/digi00x-proc.c
 create mode 100644 sound/firewire/digi00x/digi00x-stream.c
 create mode 100644 sound/firewire/digi00x/digi00x-transaction.c
 create mode 100644 sound/firewire/digi00x/digi00x.c
 create mode 100644 sound/firewire/digi00x/digi00x.h

-- 
2.1.4
