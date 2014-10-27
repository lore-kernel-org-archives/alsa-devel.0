From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Pass printf argument directly to
	request_module()
Date: Mon, 27 Oct 2014 15:38:58 +0100
Message-ID: <1414420738-14142-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A6C22608D3
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 15:45:29 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D3410AC0F
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 14:45:28 +0000 (UTC)
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

request_module() handles the printf style arguments, so we don't have
to render strings in the caller side.  Not only it reduces the
unnecessary temporary string buffer, it's even safer from the security
POV.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 259fbeaa37bd..0025bf4c2f44 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -966,14 +966,12 @@ find_codec_preset(struct hda_codec *codec)
 	mutex_unlock(&preset_mutex);
 
 	if (mod_requested < HDA_MODREQ_MAX_COUNT) {
-		char name[32];
 		if (!mod_requested)
-			snprintf(name, sizeof(name), "snd-hda-codec-id:%08x",
-				 codec->vendor_id);
+			request_module("snd-hda-codec-id:%08x",
+				       codec->vendor_id);
 		else
-			snprintf(name, sizeof(name), "snd-hda-codec-id:%04x*",
-				 (codec->vendor_id >> 16) & 0xffff);
-		request_module(name);
+			request_module("snd-hda-codec-id:%04x*",
+				       (codec->vendor_id >> 16) & 0xffff);
 		mod_requested++;
 		goto again;
 	}
-- 
2.1.2
