From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/8] ALSA: usb-audio: make hwc_debug a noop in
	case HW_CONST_DEBUG is not set
Date: Wed, 18 May 2011 11:28:39 +0200
Message-ID: <1305710925-3857-3-git-send-email-zonque@gmail.com>
References: <1305710925-3857-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 1646510382F
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

Just defining it to nothing is dangerous as it can alter the code
execution flow, for example when used in as only function in a
conditional code block.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/debug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/debug.h b/sound/usb/debug.h
index 343ec2d..5803017 100644
--- a/sound/usb/debug.h
+++ b/sound/usb/debug.h
@@ -8,7 +8,7 @@
 #ifdef HW_CONST_DEBUG
 #define hwc_debug(fmt, args...) printk(KERN_DEBUG fmt, ##args)
 #else
-#define hwc_debug(fmt, args...) /**/
+#define hwc_debug(fmt, args...) do { } while(0)
 #endif
 
 #endif /* __USBAUDIO_DEBUG_H */
-- 
1.7.5.1
