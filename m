From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/9] ALSA: fireface: add support for Fireface
	UCX
Date: Sun, 20 Jan 2019 17:25:44 +0900
Message-ID: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 86C96266A89
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 09:26:09 +0100 (CET)
Received: by mail-pg1-f194.google.com with SMTP id z10so8072787pgp.7
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 00:26:09 -0800 (PST)
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

Hi,

In 2012, RME GmbH shipped Fireface UFX. This model is one of latter
models of Fireface series and support both of IEEE 1394 bus and USB.
Furthermore, it supports two types of remote control unit (Basic
Remote and Advanced Remote Control) with by 9pin mini-din connector.

This patchset adds support for this model, as a part of devices
by ALSA firewire stack (therefore it's not a device of USB). At
present, maintain of isochronous communication and synchronization
status are cleared but asynchronous communication for MIDI messages
are not yet, therefore this commit adds support for isochronous
communication for PCM frames.

This work is based on my packet analysis from rent device for a short
term (2 weeks). I'm happy to get your responses till next weekend.
Driver code in a remote branch is available for backport till Linux
kernel v4.17 or later for your test.
https://github.com/takaswie/snd-firewire-improve/tree/topic/ff800-midi

Regards

Takashi Sakamoto (9):
  ALSA: fireface: rename protocol layer for former models
  ALSA: fireface: unify protocol layer for FF400/FF800
  ALSA: fireface: obsolete proc node to leave one node
  ALSA: fireface: add protocol-dependent operation to dump status
  ALSA: fireface: add protocol-dependent operation to switch mode to
    fetch PCM frame
  ALSA: fireface: add protocol-dependent operation to get clock status
  ALSA: fireface: code refactoring for dump of sync status
  ALSA: fireface: code refactoring to parse of clock configuration
  ALSA: fireface: add support for Fireface UCX

 sound/firewire/Kconfig                       |   1 +
 sound/firewire/fireface/Makefile             |   4 +-
 sound/firewire/fireface/ff-pcm.c             |   2 +-
 sound/firewire/fireface/ff-proc.c            | 217 +-------
 sound/firewire/fireface/ff-protocol-ff400.c  | 161 ------
 sound/firewire/fireface/ff-protocol-ff800.c  | 143 -----
 sound/firewire/fireface/ff-protocol-former.c | 549 +++++++++++++++++++
 sound/firewire/fireface/ff-protocol-latter.c | 273 +++++++++
 sound/firewire/fireface/ff-stream.c          |  40 +-
 sound/firewire/fireface/ff-transaction.c     |  63 ---
 sound/firewire/fireface/ff.c                 |  41 +-
 sound/firewire/fireface/ff.h                 |  13 +-
 12 files changed, 886 insertions(+), 621 deletions(-)
 delete mode 100644 sound/firewire/fireface/ff-protocol-ff400.c
 delete mode 100644 sound/firewire/fireface/ff-protocol-ff800.c
 create mode 100644 sound/firewire/fireface/ff-protocol-former.c
 create mode 100644 sound/firewire/fireface/ff-protocol-latter.c

-- 
2.19.1
