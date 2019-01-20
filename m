From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/9] ALSA: fireface: rename protocol layer for
	former models
Date: Sun, 20 Jan 2019 17:25:45 +0900
Message-ID: <20190120082553.17347-2-o-takashi@sakamocchi.jp>
References: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19780267333
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 09:26:10 +0100 (CET)
Received: by mail-pg1-f193.google.com with SMTP id j10so8086906pga.1
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2019 00:26:10 -0800 (PST)
In-Reply-To: <20190120082553.17347-1-o-takashi@sakamocchi.jp>
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

In a series of Fireface, later model supports different protocol
from former models.

This commit is a preparation to support both of protocols.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/Makefile                    |  2 +-
 .../{ff-protocol-ff800.c => ff-protocol-former.c}   | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)
 rename sound/firewire/fireface/{ff-protocol-ff800.c => ff-protocol-former.c} (94%)

diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index 79a7d6d99d72..3fb586d32584 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,4 +1,4 @@
 snd-fireface-objs := ff.o ff-transaction.o ff-midi.o ff-proc.o amdtp-ff.o \
 		     ff-stream.o ff-pcm.o ff-hwdep.o ff-protocol-ff400.o \
-		     ff-protocol-ff800.o
+		     ff-protocol-former.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/ff-protocol-ff800.c b/sound/firewire/fireface/ff-protocol-former.c
similarity index 94%
rename from sound/firewire/fireface/ff-protocol-ff800.c
rename to sound/firewire/fireface/ff-protocol-former.c
index 2acbf6039770..a383fd5fc879 100644
--- a/sound/firewire/fireface/ff-protocol-ff800.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -1,10 +1,9 @@
-/*
- * ff-protocol-ff800.c - a part of driver for RME Fireface series
- *
- * Copyright (c) 2018 Takashi Sakamoto
- *
- * Licensed under the terms of the GNU General Public License, version 2.
- */
+// SPDX-License-Identifier: GPL-2.0
+// ff-protocol-former.c - a part of driver for RME Fireface series
+//
+// Copyright (c) 2019 Takashi Sakamoto
+//
+// Licensed under the terms of the GNU General Public License, version 2.
 
 #include <linux/delay.h>
 
-- 
2.19.1
