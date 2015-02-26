From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/10] ALSA: hda - Set parent of input beep
	devices
Date: Thu, 26 Feb 2015 18:00:23 +0100
Message-ID: <1424970025-8082-9-git-send-email-tiwai@suse.de>
References: <1424970025-8082-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DC131264EFA
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 18:00:31 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7E6F0ADD5
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 17:00:31 +0000 (UTC)
In-Reply-To: <1424970025-8082-1-git-send-email-tiwai@suse.de>
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

Set the card device as the parent like other sound devices instead of
leaving it empty.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index d6be4e852c4d..e98438e95e79 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -160,6 +160,7 @@ static int snd_hda_do_attach(struct hda_beep *beep)
 	input_dev->name = "HDA Digital PCBeep";
 	input_dev->phys = beep->phys;
 	input_dev->id.bustype = BUS_PCI;
+	input_dev->dev.parent = &codec->bus->card->card_dev;
 
 	input_dev->id.vendor = codec->vendor_id >> 16;
 	input_dev->id.product = codec->vendor_id & 0xffff;
-- 
2.3.0
