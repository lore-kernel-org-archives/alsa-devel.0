From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC v3][PATCH 00/13] ALSA: fireface: new driver for
	RME Fireface series
Date: Sat, 11 Feb 2017 23:24:56 +0900
Message-ID: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 27263266A02
 for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2017 15:25:14 +0100 (CET)
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

This patchset is a revised version of my former one:

[alsa-devel] [RFC v2][PATCH 00/11] ALSA: fireface: new driver for RME Fireface series
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/102261.html

Since the end of 2015, ALSA firewire stack got many changes. This revision
adapt the former one to current stack. Furthermore, I add an abstraction layer
of Fireface protocol to help developers to add support for the rest of models.
(I'm unwilling to work further for this direction, because of its cost.)

Changes:
 * Rebase to current ALSA firewire stack and add optimization.
 * Rename local structure with shorter words.
 * Delegate a task to configure settings on write-only registers to user space
   applications.
 * Switch mode to fetch PCM frames from data blocks to sampling data processing
   layer voluntarily.
 * Revise comments with technical information from my analysis to Fireface 400
   packets.

The rebasing is actually done on my proposal of ALSA MOTU driver. Please apply
this patchset to it to prevent conflicts.
[alsa-devel] [PATCH 00/19][RFC v2] ALSA: firewire-motu: new driver for MOTU FireWire series
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-January/117211.html

Currently, I have a plan to post this patchset to merge into Linux 4.12.
Corresponding merge window will be estimated to open this April. If you're
willing to test this module, please report the result till then.

Unfortunately, I did this work just with my notes and log dumps, thus without
any test device. I'm happy if you test this patchset with your Fireface 400.
For testers, I prepare for backport codes in my repository in github.com.
Please use 'topic/fireface' branch.
https://github.com/takaswie/snd-firewire-improve/tree/topic/fireface

If you have any question, please reply to me even if it's trivial; e.g. typo
in comments, as long as its' technical issue.


Regards

Takashi Sakamoto (13):
  ALSA: fireface: add skeleton for RME Fireface series
  ALSA: fireface: postpone sound card registration
  ALSA: fireface: add model specific structure
  ALSA: fireface: add an abstraction layer for model-specific protocols
  ALSA: fireface: add transaction support
  ALSA: fireface: add support for MIDI functionality
  ALSA: fireface: add proc node to help debugging
  ALSA: firewire-lib: add no-header packet processing
  ALSA: fireface: add unique data processing layer
  ALSA: fireface: add stream management functionality
  ALSA: fireface: add support for PCM functionality
  ALSA: fireface: add hwdep interface
  ALSA: fireface: add support for Fireface 400

 include/uapi/sound/asound.h                 |   3 +-
 include/uapi/sound/firewire.h               |   2 +-
 sound/firewire/Kconfig                      |   8 +
 sound/firewire/Makefile                     |   1 +
 sound/firewire/amdtp-stream.c               |  84 +++++-
 sound/firewire/amdtp-stream.h               |   2 +
 sound/firewire/fireface/Makefile            |   3 +
 sound/firewire/fireface/amdtp-ff.c          | 155 +++++++++++
 sound/firewire/fireface/ff-hwdep.c          | 191 +++++++++++++
 sound/firewire/fireface/ff-midi.c           | 131 +++++++++
 sound/firewire/fireface/ff-pcm.c            | 404 ++++++++++++++++++++++++++++
 sound/firewire/fireface/ff-proc.c           |  63 +++++
 sound/firewire/fireface/ff-protocol-ff400.c | 371 +++++++++++++++++++++++++
 sound/firewire/fireface/ff-stream.c         | 282 +++++++++++++++++++
 sound/firewire/fireface/ff-transaction.c    | 295 ++++++++++++++++++++
 sound/firewire/fireface/ff.c                | 209 ++++++++++++++
 sound/firewire/fireface/ff.h                | 145 ++++++++++
 17 files changed, 2342 insertions(+), 7 deletions(-)
 create mode 100644 sound/firewire/fireface/Makefile
 create mode 100644 sound/firewire/fireface/amdtp-ff.c
 create mode 100644 sound/firewire/fireface/ff-hwdep.c
 create mode 100644 sound/firewire/fireface/ff-midi.c
 create mode 100644 sound/firewire/fireface/ff-pcm.c
 create mode 100644 sound/firewire/fireface/ff-proc.c
 create mode 100644 sound/firewire/fireface/ff-protocol-ff400.c
 create mode 100644 sound/firewire/fireface/ff-stream.c
 create mode 100644 sound/firewire/fireface/ff-transaction.c
 create mode 100644 sound/firewire/fireface/ff.c
 create mode 100644 sound/firewire/fireface/ff.h

-- 
2.9.3
