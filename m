From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix a wrong busy check in alt PCM
	open
Date: Wed,  8 Jul 2015 09:29:34 +0200
Message-ID: <1436340574-28256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D90F264F39
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 09:29:36 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C02A5AAD1
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 07:29:35 +0000 (UTC)
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

Currently, the alt PCM open callback returns -EBUSY when an
independent HP is turned off, supposing that it conflicts with the
main PCM.  However, obviously, this check is wrong when the
independent HP itself isn't enabled but the alt PCM was explicitly
created via alc_dac_nid by a codec driver.

Reported-and-tested-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index ac0db1679f09..b077bb644434 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5175,7 +5175,7 @@ static int alt_playback_pcm_open(struct hda_pcm_stream *hinfo,
 	int err = 0;
 
 	mutex_lock(&spec->pcm_mutex);
-	if (!spec->indep_hp_enabled)
+	if (spec->indep_hp && !spec->indep_hp_enabled)
 		err = -EBUSY;
 	else
 		spec->active_streams |= 1 << STREAM_INDEP_HP;
-- 
2.4.5
