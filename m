From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] ALSA: firewire-digi00x/firewire-tascam:
	remove wrong conversion for Config ROM
Date: Sun, 18 Oct 2015 22:39:53 +0900
Message-ID: <1445175593-11293-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1445175593-11293-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id D564E2650C0
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:59 +0200 (CEST)
In-Reply-To: <1445175593-11293-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The contents of Config ROM in firewire device structure are already
aligned to CPU-endianness. Thus, no need to convert it again.

This commit removes needless conversions

Fixes: 9edf723fd858('ALSA: firewire-digi00x: add skeleton for Digi 002/003 family')
Fixes: c0949b278515('ALSA: firewire-tascam: add skeleton for TASCAM FireWire series')
Reported-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x.c | 3 +--
 sound/firewire/tascam/tascam.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index bbe3be7..1f33b7a 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -34,8 +34,7 @@ static int name_card(struct snd_dg00x *dg00x)
 	strcpy(dg00x->card->mixername, model);
 	snprintf(dg00x->card->longname, sizeof(dg00x->card->longname),
 		 "Digidesign %s, GUID %08x%08x at %s, S%d", model,
-		 cpu_to_be32(fw_dev->config_rom[3]),
-		 cpu_to_be32(fw_dev->config_rom[4]),
+		 fw_dev->config_rom[3], fw_dev->config_rom[4],
 		 dev_name(&dg00x->unit->device), 100 << fw_dev->max_speed);
 
 	return 0;
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index c6747a4..c2f42cd 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -73,8 +73,7 @@ static int identify_model(struct snd_tscm *tscm)
 	strcpy(tscm->card->mixername, model);
 	snprintf(tscm->card->longname, sizeof(tscm->card->longname),
 		 "TASCAM %s, GUID %08x%08x at %s, S%d", model,
-		 cpu_to_be32(fw_dev->config_rom[3]),
-		 cpu_to_be32(fw_dev->config_rom[4]),
+		 fw_dev->config_rom[3], fw_dev->config_rom[4],
 		 dev_name(&tscm->unit->device), 100 << fw_dev->max_speed);
 
 	return 0;
-- 
2.1.4
