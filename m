From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/10] ALSA: ak4xxx-adda: Drop unnecessary
	ifdef CONFIG_PROC_FS
Date: Fri, 29 May 2015 08:06:05 +0200
Message-ID: <1432879571-3359-5-git-send-email-tiwai@suse.de>
References: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 877AE2666D6
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:06:14 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 200B7AD31
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:06:14 +0000 (UTC)
In-Reply-To: <1432879571-3359-1-git-send-email-tiwai@suse.de>
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

The compiler can optimize it away if not needed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/i2c/other/ak4xxx-adda.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
index c65731088aa2..bf377dc192aa 100644
--- a/sound/i2c/other/ak4xxx-adda.c
+++ b/sound/i2c/other/ak4xxx-adda.c
@@ -859,7 +859,6 @@ static int build_deemphasis(struct snd_akm4xxx *ak, int num_emphs)
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
 static void proc_regs_read(struct snd_info_entry *entry,
 		struct snd_info_buffer *buffer)
 {
@@ -884,9 +883,6 @@ static int proc_init(struct snd_akm4xxx *ak)
 	snd_info_set_text_ops(entry, ak, proc_regs_read);
 	return 0;
 }
-#else /* !CONFIG_PROC_FS */
-static int proc_init(struct snd_akm4xxx *ak) { return 0; }
-#endif
 
 int snd_akm4xxx_build_controls(struct snd_akm4xxx *ak)
 {
-- 
2.4.2
