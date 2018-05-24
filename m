From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: echoaudio: Drop superfluous macro
Date: Thu, 24 May 2018 11:25:46 +0200
Message-ID: <20180524092546.16910-4-tiwai@suse.de>
References: <20180524092546.16910-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CB1F8267380
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 11:25:56 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2EBD3ACDD
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 09:25:56 +0000 (UTC)
In-Reply-To: <20180524092546.16910-1-tiwai@suse.de>
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

Drop pci_device() macro that just leads to chip->pci->dev, and pass it
directly to request_firmware().  It was introduced for allowing the
external alsa-driver kernel module builds.  Since it was discontinued
years ago, we should clean it up now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/echoaudio/echoaudio.c | 2 +-
 sound/pci/echoaudio/echoaudio.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 0935a5c8741f..358ef7dcf410 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -59,7 +59,7 @@ static int get_firmware(const struct firmware **fw_entry,
 	dev_dbg(chip->card->dev,
 		"firmware requested: %s\n", card_fw[fw_index].data);
 	snprintf(name, sizeof(name), "ea/%s", card_fw[fw_index].data);
-	err = request_firmware(fw_entry, name, pci_device(chip));
+	err = request_firmware(fw_entry, name, &chip->pci->dev);
 	if (err < 0)
 		dev_err(chip->card->dev,
 			"get_firmware(): Firmware not available (%d)\n", err);
diff --git a/sound/pci/echoaudio/echoaudio.h b/sound/pci/echoaudio/echoaudio.h
index 152ce158583c..44b390a667d5 100644
--- a/sound/pci/echoaudio/echoaudio.h
+++ b/sound/pci/echoaudio/echoaudio.h
@@ -559,10 +559,4 @@ static inline int monitor_index(const struct echoaudio *chip, int out, int in)
 	return out * num_busses_in(chip) + in;
 }
 
-
-#ifndef pci_device
-#define pci_device(chip) (&chip->pci->dev)
-#endif
-
-
 #endif /* _ECHOAUDIO_H_ */
-- 
2.16.3
