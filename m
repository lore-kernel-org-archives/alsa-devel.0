From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/10] ALSA: sb: Fix sparse warning wrt PCM
	format type
Date: Wed, 25 Jul 2018 23:19:44 +0200
Message-ID: <20180725211945.19222-10-tiwai@suse.de>
References: <20180725211945.19222-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B3A3267795
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:19:55 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0B2F8B381
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:19:54 +0000 (UTC)
In-Reply-To: <20180725211945.19222-1-tiwai@suse.de>
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

The PCM format type is with __bitwise, and it can't be converted from
integer implicitly.  Instead of an ugly cast, declare the function
argument of snd_sb_csp_autoload() with the proper snd_pcm_format_t
type.

This fixes the sparse warnings like:
  sound/isa/sb/sb16_csp.c:743:22: warning: restricted snd_pcm_format_t degrades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/sb16_csp.h | 2 +-
 sound/isa/sb/sb16_csp.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sound/sb16_csp.h b/include/sound/sb16_csp.h
index c7c7788005e4..7817e88bd08d 100644
--- a/include/sound/sb16_csp.h
+++ b/include/sound/sb16_csp.h
@@ -46,7 +46,7 @@ enum {
 struct snd_sb_csp_ops {
 	int (*csp_use) (struct snd_sb_csp * p);
 	int (*csp_unuse) (struct snd_sb_csp * p);
-	int (*csp_autoload) (struct snd_sb_csp * p, int pcm_sfmt, int play_rec_mode);
+	int (*csp_autoload) (struct snd_sb_csp * p, snd_pcm_format_t pcm_sfmt, int play_rec_mode);
 	int (*csp_start) (struct snd_sb_csp * p, int sample_width, int channels);
 	int (*csp_stop) (struct snd_sb_csp * p);
 	int (*csp_qsound_transfer) (struct snd_sb_csp * p);
diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index fa5780bb0c68..2210e7c72787 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -93,7 +93,7 @@ static int snd_sb_csp_riff_load(struct snd_sb_csp * p,
 				struct snd_sb_csp_microcode __user * code);
 static int snd_sb_csp_unload(struct snd_sb_csp * p);
 static int snd_sb_csp_load_user(struct snd_sb_csp * p, const unsigned char __user *buf, int size, int load_flags);
-static int snd_sb_csp_autoload(struct snd_sb_csp * p, int pcm_sfmt, int play_rec_mode);
+static int snd_sb_csp_autoload(struct snd_sb_csp * p, snd_pcm_format_t pcm_sfmt, int play_rec_mode);
 static int snd_sb_csp_check_version(struct snd_sb_csp * p);
 
 static int snd_sb_csp_use(struct snd_sb_csp * p);
@@ -726,7 +726,7 @@ static int snd_sb_csp_firmware_load(struct snd_sb_csp *p, int index, int flags)
  * autoload hardware codec if necessary
  * return 0 if CSP is loaded and ready to run (p->running != 0)
  */
-static int snd_sb_csp_autoload(struct snd_sb_csp * p, int pcm_sfmt, int play_rec_mode)
+static int snd_sb_csp_autoload(struct snd_sb_csp * p, snd_pcm_format_t pcm_sfmt, int play_rec_mode)
 {
 	unsigned long flags;
 	int err = 0;
@@ -736,7 +736,7 @@ static int snd_sb_csp_autoload(struct snd_sb_csp * p, int pcm_sfmt, int play_rec
 		return -EBUSY;
 
 	/* autoload microcode only if requested hardware codec is not already loaded */
-	if (((1 << pcm_sfmt) & p->acc_format) && (play_rec_mode & p->mode)) {
+	if (((1U << (__force int)pcm_sfmt) & p->acc_format) && (play_rec_mode & p->mode)) {
 		p->running = SNDRV_SB_CSP_ST_AUTO;
 	} else {
 		switch (pcm_sfmt) {
-- 
2.18.0
