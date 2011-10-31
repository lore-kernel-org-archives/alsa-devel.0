From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 4/5] ALSA: snd-usb: set MAX_URBS to 16
Date: Mon, 31 Oct 2011 13:10:29 +0100
Message-ID: <1320063030-3502-5-git-send-email-zonque@gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id EA0AA246AA
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2011 13:10:43 +0100 (CET)
In-Reply-To: <1320063030-3502-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

This is needed for implicity feedback data streams.
---
 sound/usb/card.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 7fb8778..0a5515a 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -3,7 +3,7 @@
 
 #define MAX_PACKS	20
 #define MAX_PACKS_HS	(MAX_PACKS * 8)	/* in high speed mode */
-#define MAX_URBS	8
+#define MAX_URBS	16
 #define SYNC_URBS	4	/* always four urbs for sync */
 #define MAX_QUEUE	24	/* try not to exceed this queue length, in ms */
 
-- 
1.7.5.4
