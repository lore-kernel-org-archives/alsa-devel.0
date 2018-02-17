From: Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] ALSA: hda-beep: add SPDX identifiers
Date: Fri, 16 Feb 2018 21:53:15 -0800
Message-ID: <20180217055315.2407-1-matt.ranostay@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CB1A3266F6A
 for <alsa-devel@alsa-project.org>; Sat, 17 Feb 2018 06:53:19 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id g2so3934695pgn.7
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 21:53:19 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
List-Id: alsa-devel@alsa-project.org

Add SPDX GPLv2.0+ identifiers and update authors email

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 sound/pci/hda/hda_beep.c | 17 ++---------------
 sound/pci/hda/hda_beep.h | 17 ++---------------
 2 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index c397e7da0eac..066b5b59c4d7 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Digital Beep Input Interface for HD-audio codec
  *
- * Author: Matt Ranostay <mranostay@gmail.com>
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  * Copyright (c) 2008 Embedded Alley Solutions Inc
- *
- *  This driver is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This driver is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
 #include <linux/input.h>
diff --git a/sound/pci/hda/hda_beep.h b/sound/pci/hda/hda_beep.h
index 1052ad380e97..d1a6a9c1329a 100644
--- a/sound/pci/hda/hda_beep.h
+++ b/sound/pci/hda/hda_beep.h
@@ -1,22 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Digital Beep Input Interface for HD-audio codec
  *
- * Author: Matt Ranostay <mranostay@gmail.com>
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  * Copyright (c) 2008 Embedded Alley Solutions Inc
- *
- *  This driver is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This driver is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
 #ifndef __SOUND_HDA_BEEP_H
-- 
2.14.1
