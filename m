From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] ALSA: wss_lib: missing closing brace in
 (ifdeffed out) debug function.
Date: Fri, 08 Aug 2008 16:41:46 +0200
Message-ID: <489C5B2A.7010405@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 31A6624850
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Aug 2008 16:41:36 +0200 (CEST)
Content-Disposition: inline;
	filename*0="0001-ALSA-wss_lib-missing-closing-brace-in-ifdeffed-ou.patch"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>From c5c7bb20460d9cb20fa85fcd6b0121c9cc8bc13c Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Fri, 8 Aug 2008 16:39:21 +0200
Subject: [PATCH] ALSA: wss_lib: missing closing brace in (ifdeffed out) debug function.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 sound/isa/wss/wss_lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 011da7a..6b7a0fc 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -282,7 +282,7 @@ static void snd_wss_debug(struct snd_wss *chip)
 	printk(KERN_DEBUG
 		"CS4231 REGS:      INDEX = 0x%02x  "
 		"                 STATUS = 0x%02x\n",
-					wss_inb(chip, CS4231P(REGSEL),
+					wss_inb(chip, CS4231P(REGSEL)),
 					wss_inb(chip, CS4231P(STATUS)));
 	printk(KERN_DEBUG
 		"  0x00: left input      = 0x%02x  "
-- 
1.5.5
