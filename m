From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 0/8][RFC] a driver for Fireworks based
	devices
Date: Wed, 11 Dec 2013 18:15:51 +0900
Message-ID: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 093F82615F3
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 10:16:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This series of patch is update of my previous one:
 [PATCH 0/8] [RFC] new driver for Echo Audio's Fireworks based devices
 http://mailman.alsa-project.org/pipermail/alsa-devel/2013-June/062614.html

This series of patch is based on this series:
 [RFC][PATCH 00/17] Enhancement for firewire-lib
 http://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/069163.html

I hope to get comments, especially for hwdep interface for Fireworks
command/response which was discussed below:
 include/uapi/firewire.h for other firewire drivers
 http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/067743.html

Takashi Sakamoto (8):
  fireworks: Add skelton for Fireworks based devices
  fireworks: Add transaction and some commands
  fireworks: Add connection and stream management
  fireworks: Add proc interface for debugging purpose
  fireworks: Add MIDI interface
  fireworks: Add PCM interface
  fireworks: Add hwdep interface
  fireworks: Add command/response functionality into hwdep interface

 include/uapi/sound/asound.h                      |   3 +-
 include/uapi/sound/firewire.h                    |  19 +
 sound/firewire/Kconfig                           |  15 +
 sound/firewire/Makefile                          |   1 +
 sound/firewire/fireworks/Makefile                |   5 +
 sound/firewire/fireworks/fireworks.c             | 344 +++++++++++++++++
 sound/firewire/fireworks/fireworks.h             | 239 ++++++++++++
 sound/firewire/fireworks/fireworks_command.c     | 401 ++++++++++++++++++++
 sound/firewire/fireworks/fireworks_hwdep.c       | 310 +++++++++++++++
 sound/firewire/fireworks/fireworks_midi.c        | 176 +++++++++
 sound/firewire/fireworks/fireworks_pcm.c         | 459 +++++++++++++++++++++++
 sound/firewire/fireworks/fireworks_proc.c        | 216 +++++++++++
 sound/firewire/fireworks/fireworks_stream.c      | 364 ++++++++++++++++++
 sound/firewire/fireworks/fireworks_transaction.c | 340 +++++++++++++++++
 14 files changed, 2891 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireworks/Makefile
 create mode 100644 sound/firewire/fireworks/fireworks.c
 create mode 100644 sound/firewire/fireworks/fireworks.h
 create mode 100644 sound/firewire/fireworks/fireworks_command.c
 create mode 100644 sound/firewire/fireworks/fireworks_hwdep.c
 create mode 100644 sound/firewire/fireworks/fireworks_midi.c
 create mode 100644 sound/firewire/fireworks/fireworks_pcm.c
 create mode 100644 sound/firewire/fireworks/fireworks_proc.c
 create mode 100644 sound/firewire/fireworks/fireworks_stream.c
 create mode 100644 sound/firewire/fireworks/fireworks_transaction.c

-- 
1.8.3.2
