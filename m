From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] pcm: Fix secondary retry in dsnoop and dshare
Date: Sat, 28 May 2016 10:43:07 +0200
Message-ID: <20160528084307.12668-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 23E952604A9
 for <alsa-devel@alsa-project.org>; Sat, 28 May 2016 10:43:12 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A2D24AB1A
 for <alsa-devel@alsa-project.org>; Sat, 28 May 2016 08:43:10 +0000 (UTC)
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

The commit [fdba9e1bad8f: pcm: Fallback open as the first instance for
dmix & co] introduced a mechanism to retry the open of slave PCM for
the secondary streams, but this also introduced a regression in dsnoop
and dshare plugins: since the retry goto-tag was placed at a wrong
position, it retries to re-fetch the shm unnecessarily and eventually
leads to the fatal error.

The bug can be easily reproduced by starting arecord and killing it
via SIGKILL, then starting arecord again.  The second arecord fails.

The fix is obviously to move the wrong retry goto-tags to the right
positions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_dshare.c | 2 +-
 src/pcm/pcm_dsnoop.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index adb3587a2869..05854dedf259 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -690,7 +690,6 @@ int snd_pcm_dshare_open(snd_pcm_t **pcmp, const char *name,
 		break;
 	}
 
- retry:
 	first_instance = ret = snd_pcm_direct_shm_create_or_connect(dshare);
 	if (ret < 0) {
 		SNDERR("unable to create IPC shm instance");
@@ -705,6 +704,7 @@ int snd_pcm_dshare_open(snd_pcm_t **pcmp, const char *name,
 	dshare->max_periods = opts->max_periods;
 	dshare->sync_ptr = snd_pcm_dshare_sync_ptr;
 
+ retry:
 	if (first_instance) {
 		/* recursion is already checked in
 		   snd_pcm_direct_get_slave_ipc_offset() */
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 8ff0ba57cb14..2d45171dda01 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -583,7 +583,6 @@ int snd_pcm_dsnoop_open(snd_pcm_t **pcmp, const char *name,
 		break;
 	}
 		
- retry:
 	first_instance = ret = snd_pcm_direct_shm_create_or_connect(dsnoop);
 	if (ret < 0) {
 		SNDERR("unable to create IPC shm instance");
@@ -598,6 +597,7 @@ int snd_pcm_dsnoop_open(snd_pcm_t **pcmp, const char *name,
 	dsnoop->max_periods = opts->max_periods;
 	dsnoop->sync_ptr = snd_pcm_dsnoop_sync_ptr;
 
+ retry:
 	if (first_instance) {
 		/* recursion is already checked in
 		   snd_pcm_direct_get_slave_ipc_offset() */
-- 
2.8.3
