From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH alsa-lib 1/2] pcm_hw: Remove unused fields in
	struct
Date: Thu, 30 May 2013 12:26:33 +0200
Message-ID: <1369909594-15047-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C9C1C2650F0
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 12:26:36 +0200 (CEST)
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
Cc: tiwai@suse.de, arun.raghavan@collabora.co.uk, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

These fields are not used, and their name similarity to other
fields are quite confusing when trying to debug alsa-lib.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/pcm/pcm_hw.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 0f3226d..196393d 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -95,8 +95,6 @@ typedef struct {
 	volatile struct snd_pcm_mmap_status * mmap_status;
 	struct snd_pcm_mmap_control *mmap_control;
 	struct snd_pcm_sync_ptr *sync_ptr;
-	snd_pcm_uframes_t hw_ptr;
-	snd_pcm_uframes_t appl_ptr;
 	int period_event;
 	snd_timer_t *period_timer;
 	struct pollfd period_timer_pfd;
-- 
1.7.9.5
