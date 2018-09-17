From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: bebob: fix memory leak for M-Audio
	FW1814 and ProjectMix I/O at error path
Date: Mon, 17 Sep 2018 17:25:24 +0900
Message-ID: <20180917082524.11308-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id C2C5826761D
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 10:25:43 +0200 (CEST)
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so7060826plr.8
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 01:25:43 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

After allocating model-dependent data for M-Audio FW1814 and ProjectMix
I/O, ALSA bebob driver has memory leak at error path.

This commit releases the allocated data at the error path.

Fixes: 04a2c73c97eb('ALSA: bebob: delayed registration of sound card')
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c        | 2 ++
 sound/firewire/bebob/bebob_maudio.c | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 730ea91d9be8..93676354f87f 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -263,6 +263,8 @@ do_registration(struct work_struct *work)
 error:
 	mutex_unlock(&devices_mutex);
 	snd_bebob_stream_destroy_duplex(bebob);
+	kfree(bebob->maudio_special_quirk);
+	bebob->maudio_special_quirk = NULL;
 	snd_card_free(bebob->card);
 	dev_info(&bebob->unit->device,
 		 "Sound card registration failed: %d\n", err);
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index bd55620c6a47..164f2126a676 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -290,10 +290,6 @@ snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814)
 		bebob->midi_output_ports = 2;
 	}
 end:
-	if (err < 0) {
-		kfree(params);
-		bebob->maudio_special_quirk = NULL;
-	}
 	mutex_unlock(&bebob->mutex);
 	return err;
 }
-- 
2.17.1
