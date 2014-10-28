From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: jack: Fix kerneldoc comments
Date: Tue, 28 Oct 2014 15:45:45 +0100
Message-ID: <1414507545-13362-2-git-send-email-tiwai@suse.de>
References: <1414507545-13362-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DA2C3260320
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 15:45:46 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9C978AC0F
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 14:45:46 +0000 (UTC)
In-Reply-To: <1414507545-13362-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/jack.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 58916573db58..37e612e77410 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -28,8 +28,9 @@
 struct input_dev;
 
 /**
- * Jack types which can be reported.  These values are used as a
- * bitmask.
+ * enum snd_jack_types: Jack types which can be reported
+ *
+ * These values are used as a bitmask.
  *
  * Note that this must be kept in sync with the lookup table in
  * sound/core/jack.c.
-- 
2.1.2
