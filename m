From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH (sound-unstable)] ALSA: hda - fix OOPS in
	hda_mark_cmd_cache_dirty
Date: Tue, 15 Jan 2013 15:27:19 +0100
Message-ID: <1358260039-25827-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 77D022615EE
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 15:27:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Obvious copy-paste error.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_codec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b28e403..e6cdad7 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3794,7 +3794,7 @@ static void hda_mark_cmd_cache_dirty(struct hda_codec *codec)
 	}
 	for (i = 0; i < codec->amp_cache.buf.used; i++) {
 		struct hda_amp_info *amp;
-		amp = snd_array_elem(&codec->cmd_cache.buf, i);
+		amp = snd_array_elem(&codec->amp_cache.buf, i);
 		amp->head.dirty = 1;
 	}
 }
-- 
1.7.9.5
