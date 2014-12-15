From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Create capture source ctls
	when stereo mix input is added
Date: Mon, 15 Dec 2014 13:56:41 +0100
Message-ID: <1418648202-2509-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DC5FE26048B
 for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2014 13:56:49 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B0D31AD08
 for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2014 12:56:49 +0000 (UTC)
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

When the stereo mix input is explicitly enabled via a user hint, the
driver should create always a capture source enum ctl and disable the
auto-mic switch.  Otherwise the behavior gets confused.  For doing it,
this patch just sets spec->suppress_auto_mic flag appropriately.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 63b69f750d8e..293af6b5ba3d 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3224,6 +3224,8 @@ static int create_input_ctls(struct hda_codec *codec)
 					   "Stereo Mix", 0);
 		if (err < 0)
 			return err;
+		else
+			spec->suppress_auto_mic = 1;
 	}
 
 	return 0;
-- 
2.2.0
