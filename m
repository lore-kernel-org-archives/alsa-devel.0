From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/8] ALSA: opl3: Hardening for potential
	Spectre v1
Date: Tue, 24 Apr 2018 09:56:16 +0200
Message-ID: <20180424075619.29602-6-tiwai@suse.de>
References: <20180424075619.29602-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E1CC526722C
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 09:56:42 +0200 (CEST)
In-Reply-To: <20180424075619.29602-1-tiwai@suse.de>
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
Cc: Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

As the recent Smatch warned, one place in OPL3 driver may expand the
array directly from the user-space value with speculation:
  sound/drivers/opl3/opl3_synth.c:476 snd_opl3_set_voice() warn: potential spectre issue 'snd_opl3_regmap'

This patch puts array_index_nospec() for hardening against it.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/opl3/opl3_synth.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/opl3/opl3_synth.c b/sound/drivers/opl3/opl3_synth.c
index ddcc1a325a61..42920a243328 100644
--- a/sound/drivers/opl3/opl3_synth.c
+++ b/sound/drivers/opl3/opl3_synth.c
@@ -21,6 +21,7 @@
 
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 #include <sound/opl3.h>
 #include <sound/asound_fm.h>
 
@@ -448,7 +449,7 @@ static int snd_opl3_set_voice(struct snd_opl3 * opl3, struct snd_dm_fm_voice * v
 {
 	unsigned short reg_side;
 	unsigned char op_offset;
-	unsigned char voice_offset;
+	unsigned char voice_offset, voice_op;
 
 	unsigned short opl3_reg;
 	unsigned char reg_val;
@@ -473,7 +474,9 @@ static int snd_opl3_set_voice(struct snd_opl3 * opl3, struct snd_dm_fm_voice * v
 		voice_offset = voice->voice - MAX_OPL2_VOICES;
 	}
 	/* Get register offset of operator */
-	op_offset = snd_opl3_regmap[voice_offset][voice->op];
+	voice_offset = array_index_nospec(voice_offset, MAX_OPL2_VOICES);
+	voice_op = array_index_nospec(voice->op, 4);
+	op_offset = snd_opl3_regmap[voice_offset][voice_op];
 
 	reg_val = 0x00;
 	/* Set amplitude modulation (tremolo) effect */
-- 
2.16.3
