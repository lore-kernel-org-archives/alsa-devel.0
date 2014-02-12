From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/24] ALSA: firewire: Convert to
	snd_card_new() with a device pointer
Date: Wed, 12 Feb 2014 11:35:23 +0100
Message-ID: <1392201340-27113-8-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DE66F265004
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 80943AC03
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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

Also remove superfluous snd_card_set_dev() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/firewire/dice.c     | 4 ++--
 sound/firewire/isight.c   | 4 ++--
 sound/firewire/scs1x.c    | 4 ++--
 sound/firewire/speakers.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index c0aa64941cee..0c3948630cf7 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -1326,10 +1326,10 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	if (err < 0)
 		return err;
 
-	err = snd_card_create(-1, NULL, THIS_MODULE, sizeof(*dice), &card);
+	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
+			   sizeof(*dice), &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, &unit->device);
 
 	dice = card->private_data;
 	dice->card = card;
diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index fd42e6b315e6..7ac94439e758 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -631,10 +631,10 @@ static int isight_probe(struct fw_unit *unit,
 	struct isight *isight;
 	int err;
 
-	err = snd_card_create(-1, NULL, THIS_MODULE, sizeof(*isight), &card);
+	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
+			   sizeof(*isight), &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, &unit->device);
 
 	isight = card->private_data;
 	isight->card = card;
diff --git a/sound/firewire/scs1x.c b/sound/firewire/scs1x.c
index 858023cf4298..2dba848a781f 100644
--- a/sound/firewire/scs1x.c
+++ b/sound/firewire/scs1x.c
@@ -391,10 +391,10 @@ static int scs_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	struct scs *scs;
 	int err;
 
-	err = snd_card_create(-16, NULL, THIS_MODULE, sizeof(*scs), &card);
+	err = snd_card_new(&unit->device, -16, NULL, THIS_MODULE,
+			   sizeof(*scs), &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, &unit->device);
 
 	scs = card->private_data;
 	scs->card = card;
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index cc8bc3a51bc1..9f7ef219b109 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -668,10 +668,10 @@ static int fwspk_probe(struct fw_unit *unit,
 	u32 firmware;
 	int err;
 
-	err = snd_card_create(-1, NULL, THIS_MODULE, sizeof(*fwspk), &card);
+	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
+			   sizeof(*fwspk), &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, &unit->device);
 
 	fwspk = card->private_data;
 	fwspk->card = card;
-- 
1.8.5.2
