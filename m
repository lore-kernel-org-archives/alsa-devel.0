From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Don't enable unsol for jacks we're
	polling
Date: Wed, 17 Oct 2012 14:45:05 +0200
Message-ID: <1350477905-23402-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C89FF26524C
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 14:45:05 +0200 (CEST)
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

This will greatly reduce the frequency for detection errors in
those cases where the hardware is "flaky", i e, rapidly changing
between plugged and unplugged states even without user interaction.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_jack.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 07d5288..5bdbada 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -206,6 +206,8 @@ int snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 		jack->action = action;
 	if (cb)
 		jack->callback = cb;
+	if (codec->jackpoll_interval > 0)
+		return 0; /* No unsol if we're polling instead */
 	return snd_hda_codec_write_cache(codec, nid, 0,
 					 AC_VERB_SET_UNSOLICITED_ENABLE,
 					 AC_USRSP_EN | jack->tag);
-- 
1.7.9.5
