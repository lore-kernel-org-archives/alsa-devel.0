From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: jack: Fix the id uniqueness check
Date: Fri, 29 May 2015 14:09:04 +0200
Message-ID: <1432901344-27034-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EE0A2606B2
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 14:09:06 +0200 (CEST)
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

snd_kctl_jack_new() tries to assign a unique index number when a name
string that has been already registered is passed.  However, it checks
with the base string without "Jack" suffix, so it never hits.
Fix the call with the properly processed name string instead.

Fixes: b8dd086674cf 'ALSA: Jack: handle jack embedded kcontrol creating within ctljack')
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/ctljack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/ctljack.c b/sound/core/ctljack.c
index 8f8d1033425c..9149a4aefa95 100644
--- a/sound/core/ctljack.c
+++ b/sound/core/ctljack.c
@@ -70,7 +70,7 @@ snd_kctl_jack_new(const char *name, struct snd_card *card)
 		return NULL;
 
 	jack_kctl_name_gen(kctl->id.name, name, sizeof(kctl->id.name));
-	kctl->id.index = get_available_index(card, name);
+	kctl->id.index = get_available_index(card, kctl->id.name);
 	kctl->private_value = 0;
 	return kctl;
 }
-- 
2.4.2
