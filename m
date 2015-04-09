From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: hda/generic - Check power state cap
	at updating the widget power
Date: Thu,  9 Apr 2015 10:40:34 +0200
Message-ID: <1428568838-21550-2-git-send-email-tiwai@suse.de>
References: <1428568838-21550-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 01AAA265238
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 10:40:40 +0200 (CEST)
In-Reply-To: <1428568838-21550-1-git-send-email-tiwai@suse.de>
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
Cc: Hui Wang <hui.wang@canonical.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The new widget power-saving tries to apply the power change no matter
whether the node has a power cap or not.  It's bad (although most of
codecs chip just ignore it).  Check the capability properly
beforehand.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 1f2ca7be1468..afc6b1b0898c 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -832,6 +832,8 @@ static hda_nid_t path_power_update(struct hda_codec *codec,
 
 	for (i = 0; i < path->depth; i++) {
 		nid = path->path[i];
+		if (!(get_wcaps(codec, nid) & AC_WCAP_POWER))
+			continue;
 		if (nid == codec->core.afg)
 			continue;
 		if (!allow_powerdown || is_active_nid_for_any(codec, nid))
-- 
2.3.5
