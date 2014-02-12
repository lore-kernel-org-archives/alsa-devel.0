From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 21/24] thinkpad_acpi: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:37 +0100
Message-ID: <1392201340-27113-22-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FD97265066
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:51 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 99B98AC97
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
 drivers/platform/x86/thinkpad_acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index defb6afc1409..94bb6157c957 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6776,8 +6776,9 @@ static int __init volume_create_alsa_mixer(void)
 	struct snd_kcontrol *ctl_mute;
 	int rc;
 
-	rc = snd_card_create(alsa_index, alsa_id, THIS_MODULE,
-			    sizeof(struct tpacpi_alsa_data), &card);
+	rc = snd_card_new(&tpacpi_pdev->dev,
+			  alsa_index, alsa_id, THIS_MODULE,
+			  sizeof(struct tpacpi_alsa_data), &card);
 	if (rc < 0 || !card) {
 		pr_err("Failed to create ALSA card structures: %d\n", rc);
 		return 1;
@@ -6828,7 +6829,6 @@ static int __init volume_create_alsa_mixer(void)
 	}
 	data->ctl_mute_id = &ctl_mute->id;
 
-	snd_card_set_dev(card, &tpacpi_pdev->dev);
 	rc = snd_card_register(card);
 	if (rc < 0) {
 		pr_err("Failed to register ALSA card: %d\n", rc);
-- 
1.8.5.2
