From: Joe Perches <joe@perches.com>
Subject: [RFC PATCH] MAINTAINERS: Remove Jaroslav Kysela
Date: Thu, 07 Nov 2013 12:04:56 -0800
Message-ID: <1383854696.9263.25.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav hasn't acked or signed a patch in quite awhile.

Mark ISAPnp and HP VG/AnyLAN driver as orphan.

Add sound to his CREDITS entry.

Signed-off-by: Joe Perches <joe@perches.com>
---
 CREDITS     | 1 +
 MAINTAINERS | 7 ++-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/CREDITS b/CREDITS
index 0640e16..01a1b34 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2021,6 +2021,7 @@ E: perex@perex.cz
 W: http://www.perex.cz
 D: Original Author and Maintainer for HP 10/100 Mbit Network Adapters
 D: ISA PnP
+D: ALSA/Sound
 S: Sindlovy Dvory 117
 S: 370 01  Ceske Budejovice
 S: Czech Republic
diff --git a/MAINTAINERS b/MAINTAINERS
index 831b869..8706839 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3983,8 +3983,7 @@ S:	Orphan
 F:	drivers/platform/x86/tc1100-wmi.c
 
 HP100:	Driver for HP 10/100 Mbit/s Voice Grade Network Adapter Series
-M:	Jaroslav Kysela <perex@perex.cz>
-S:	Maintained
+S:	Orphan
 F:	drivers/net/ethernet/hp/hp100.*
 
 HPET:	High Precision Event Timers driver
@@ -4600,8 +4599,7 @@ F:	include/linux/irqdomain.h
 F:	kernel/irq/irqdomain.c
 
 ISAPNP
-M:	Jaroslav Kysela <perex@perex.cz>
-S:	Maintained
+S:	Orphan
 F:	Documentation/isapnp.txt
 F:	drivers/pnp/isapnp/
 F:	include/linux/isapnp.h
@@ -7818,7 +7816,6 @@ S:	Maintained
 F:	drivers/memstick/core/ms_block.*
 
 SOUND
-M:	Jaroslav Kysela <perex@perex.cz>
 M:	Takashi Iwai <tiwai@suse.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 W:	http://www.alsa-project.org/
