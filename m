From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/24] HID: prodikeys: Convert to
	snd_card_new() with a device pointer
Date: Wed, 12 Feb 2014 11:35:35 +0100
Message-ID: <1392201340-27113-20-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 06614265041
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:51 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 940A4AC93
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
 drivers/hid/hid-prodikeys.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 7ed828056414..91fab975063c 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -624,7 +624,8 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 
 	/* Setup sound card */
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pm->pk->hdev->dev, index[dev], id[dev],
+			   THIS_MODULE, 0, &card);
 	if (err < 0) {
 		pk_error("failed to create pc-midi sound card\n");
 		err = -ENOMEM;
@@ -660,8 +661,6 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 	snd_rawmidi_set_ops(rwmidi, SNDRV_RAWMIDI_STREAM_INPUT,
 		&pcmidi_in_ops);
 
-	snd_card_set_dev(card, &pm->pk->hdev->dev);
-
 	/* create sysfs variables */
 	err = device_create_file(&pm->pk->hdev->dev,
 				 sysfs_device_attr_channel);
-- 
1.8.5.2
