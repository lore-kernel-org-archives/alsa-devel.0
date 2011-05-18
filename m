From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/8] ALSA: usb-audio: include format.h in
	format.c
Date: Wed, 18 May 2011 11:28:40 +0200
Message-ID: <1305710925-3857-4-git-send-email-zonque@gmail.com>
References: <1305710925-3857-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 27E4E10383E
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 11:29:01 +0200 (CEST)
In-Reply-To: <1305710925-3857-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Just in case a prototype changes, we'll be warned. This also fixes a
sparse warning.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/format.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index f079b5e..8d042dc 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -30,6 +30,7 @@
 #include "helper.h"
 #include "debug.h"
 #include "clock.h"
+#include "format.h"
 
 /*
  * parse the audio format type I descriptor
-- 
1.7.5.1
