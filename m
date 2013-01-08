From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 060/112] ALSA: hda - Add missing amp cache
	flush for bound capture vol/sw ctls
Date: Tue,  8 Jan 2013 12:38:53 +0100
Message-ID: <1357645185-7645-61-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 24D172651ED
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 3D4BDA52DA
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

The bound capture volume and switch controls use the cached amp
updates, but it's missing the flushing at the end.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f8d1d03..3e818b6 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1919,6 +1919,7 @@ static int cap_put_caller(struct snd_kcontrol *kcontrol,
  error:
 	codec->cached_write = 0;
 	mutex_unlock(&codec->control_mutex);
+	snd_hda_codec_flush_amp_cache(codec);
 	if (err >= 0 && spec->cap_sync_hook)
 		spec->cap_sync_hook(codec);
 	return err;
-- 
1.8.0.1
