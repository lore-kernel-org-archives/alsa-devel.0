From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] OSS/DMASOUND: add __init to dmasound_init
Date: Mon,  9 Jun 2014 16:53:59 +0200
Message-ID: <1402325639-2376-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay008.isp.belgacom.be (mailrelay008.isp.belgacom.be
 [195.238.6.174])
 by alsa0.perex.cz (Postfix) with ESMTP id EBFE6264F28
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 16:55:22 +0200 (CEST)
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
Cc: Fabian Frederick <fabf@skynet.be>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

dmasound_init is only called by __init functions:

__init dmasound_q40_init
__init amiga_audio_probe
__init dmasound_atari_init

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/oss/dmasound/dmasound.h      | 2 +-
 sound/oss/dmasound/dmasound_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/oss/dmasound/dmasound.h b/sound/oss/dmasound/dmasound.h
index 01019f0..a181ed2 100644
--- a/sound/oss/dmasound/dmasound.h
+++ b/sound/oss/dmasound/dmasound.h
@@ -86,7 +86,7 @@ static inline int ioctl_return(int __user *addr, int value)
      *  Initialization
      */
 
-extern int dmasound_init(void);
+extern int __init dmasound_init(void);
 #ifdef MODULE
 extern void dmasound_deinit(void);
 #else
diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index f4ee85a..1f0a42c 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -1394,7 +1394,7 @@ static int state_init(void)
      *  This function is called by _one_ chipset-specific driver
      */
 
-int dmasound_init(void)
+int __init dmasound_init(void)
 {
 	int res ;
 #ifdef MODULE
-- 
1.8.4.5
