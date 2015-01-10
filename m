From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] fm801: remove FSF address
Date: Sat, 10 Jan 2015 16:57:45 +0200
Message-ID: <1420901865-8408-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw02.mail.saunalahti.fi (gw02.mail.saunalahti.fi
 [195.197.172.116])
 by alsa0.perex.cz (Postfix) with ESMTP id EE9A2260570
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 15:57:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: alsa-devel@alsa-project.org

The FSF address is subject to change. So, we remove it from the header.

While here, remove a line with my old and non-functional email from the
header. Moreover, nowadays we have a Git VCS that contains a history of
changes.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 sound/pci/fm801.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 52555bda..1fdd92b6 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -2,8 +2,6 @@
  *  The driver for the ForteMedia FM801 based soundcards
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
  *
- *  Support FM only card by Andy Shevchenko <andy@smile.org.ua>
- *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -14,10 +12,6 @@
  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *   GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
  */
 
 #include <linux/delay.h>
-- 
1.8.3.101.g727a46b
