From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 056/112] ALSA: hda - Clear cached_write flag in
	snd_hda_codec_resume_*()
Date: Tue,  8 Jan 2013 12:38:49 +0100
Message-ID: <1357645185-7645-57-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 03CBD2651D7
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 262AEA52D4
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

These functions are supposed to be called at finishing the cached
sequential writes, so clear the flag properly for lazy developers who
often forget details.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 44b525f..df4abbe 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1955,6 +1955,7 @@ void snd_hda_codec_resume_amp(struct hda_codec *codec)
 	int i;
 
 	mutex_lock(&codec->hash_mutex);
+	codec->cached_write = 0;
 	for (i = 0; i < codec->amp_cache.buf.used; i++) {
 		struct hda_amp_info *buffer;
 		u32 key;
@@ -3519,6 +3520,7 @@ void snd_hda_codec_resume_cache(struct hda_codec *codec)
 	int i;
 
 	mutex_lock(&codec->hash_mutex);
+	codec->cached_write = 0;
 	for (i = 0; i < codec->cmd_cache.buf.used; i++) {
 		struct hda_cache_head *buffer;
 		u32 key;
-- 
1.8.0.1
