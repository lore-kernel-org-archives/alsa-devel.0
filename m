From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: hda - Remove leftover snd_hda_bus()
	prototype
Date: Sat, 17 Oct 2015 18:36:29 +0200
Message-ID: <1445099790-17688-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A1FCE260483
 for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2015 18:36:33 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5B4A7AAD1
 for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2015 16:36:32 +0000 (UTC)
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

It was forgotten to be removed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 5bcfe7407d83..373fcad840ea 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -301,10 +301,6 @@ struct hda_codec {
 /*
  * constructors
  */
-int snd_hda_bus_new(struct snd_card *card,
-		    const struct hdac_bus_ops *ops,
-		    const struct hdac_io_ops *io_ops,
-		    struct hda_bus **busp);
 int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 		      unsigned int codec_addr, struct hda_codec **codecp);
 int snd_hda_codec_configure(struct hda_codec *codec);
-- 
2.6.0
