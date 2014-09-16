From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH/alsa-lib trivial] hwdep: add missing
	declaration for snd_hwdep_poll_descriptors_count()
Date: Wed, 17 Sep 2014 07:07:03 +0900
Message-ID: <1410905223-7541-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id BB21E264F22
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 00:07:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The alsa-lib has 'snd_hwdep_poll_descriptors_count()' but hwdep.h has no
declaration for the function. No applications can call the function just
by including the header.

This commit adds a line to the file for this function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/hwdep.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hwdep.h b/include/hwdep.h
index 6496fa2..ad8bb49 100644
--- a/include/hwdep.h
+++ b/include/hwdep.h
@@ -102,6 +102,7 @@ typedef struct _snd_hwdep snd_hwdep_t;
 int snd_hwdep_open(snd_hwdep_t **hwdep, const char *name, int mode);
 int snd_hwdep_close(snd_hwdep_t *hwdep);
 int snd_hwdep_poll_descriptors(snd_hwdep_t *hwdep, struct pollfd *pfds, unsigned int space);
+int snd_hwdep_poll_descriptors_count(snd_hwdep_t *hwdep);
 int snd_hwdep_poll_descriptors_revents(snd_hwdep_t *hwdep, struct pollfd *pfds, unsigned int nfds, unsigned short *revents);
 int snd_hwdep_nonblock(snd_hwdep_t *hwdep, int nonblock);
 int snd_hwdep_info(snd_hwdep_t *hwdep, snd_hwdep_info_t * info);
-- 
1.9.1
