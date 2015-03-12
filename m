From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] rate: Allow LGPL for libsamplerate commercial
	licensee
Date: Thu, 12 Mar 2015 09:19:00 +0100
Message-ID: <1426148340-3685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A0397261498
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 09:19:01 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5F457AC76
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 08:19:01 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

alsa-plugins-rate is tagged with GPL just for following the license of
libsamplerate.  However, libsamplerate provides a commercial license
to allow it used with less restrictions.  In that case, we also don't
have to stick with GPL.  Instead, the code follows LGPL like other
plugin codes in this package.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

If anyone sees a legal problem with this, please let me know.
I find it OK, but IANAL.

 rate/rate_samplerate.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/rate/rate_samplerate.c b/rate/rate_samplerate.c
index 53a0627b21dc..0b14a59000bf 100644
--- a/rate/rate_samplerate.c
+++ b/rate/rate_samplerate.c
@@ -3,6 +3,14 @@
  *
  * Copyright (c) 2006 by Takashi Iwai <tiwai@suse.de>
  *
+ * This plugin code is supposed to be used and distributed primarily
+ * under GPL v2 or later, in order to follow the license of libsamplerate.
+ * However, if you already own a commercial license to use libsamplerate
+ * for dynamic linking, this plugin code can be used and distributed also
+ * under LGPL v2.1 or later.
+ *
+ * For GPL-2.0+:
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -13,9 +21,17 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
+ * For LGPL-2.1+:
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
  */
 
 #include <stdio.h>
-- 
2.3.2
