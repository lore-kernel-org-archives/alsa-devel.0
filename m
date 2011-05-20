From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: core: Don't set "(null)" as a driver name
Date: Fri, 20 May 2011 15:21:26 +0300
Message-ID: <1305894086-9851-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id A314A2436D
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 14:20:08 +0200 (CEST)
Received: by ewy6 with SMTP id 6so1267118ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2011 05:20:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Commit 22de71b ("ASoC: core - allow ASoC more flexible machine name")
writes "(null)" to driver name string in struct snd_card if card->driver_name
is NULL. This causes segmentation faults with some user space ALSA utilities
like aplay and arecord.

Fix this by using null terminated string instead as this was the case before.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5968745..ab05f42 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1930,7 +1930,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
 		 "%s", card->long_name ? card->long_name : card->name);
 	snprintf(card->snd_card->driver, sizeof(card->snd_card->driver),
-		 "%s", card->driver_name);
+		 "%s", card->driver_name ? card->driver_name : "");
 
 	if (card->late_probe) {
 		ret = card->late_probe(card);
-- 
1.7.4.4
