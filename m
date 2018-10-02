From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: bebob: use managed-resource to
	maintain data specific to M-Audio FW-1814/ProjectMix I/O
Date: Wed,  3 Oct 2018 08:21:51 +0900
Message-ID: <20181002232154.29225-3-o-takashi@sakamocchi.jp>
References: <20181002232154.29225-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E02212678AC
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 01:22:10 +0200 (CEST)
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so710310pfh.5
 for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2018 16:22:10 -0700 (PDT)
In-Reply-To: <20181002232154.29225-1-o-takashi@sakamocchi.jp>
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

ALSA bebob driver allocates memory object for data specific to M-Audio
FW-1884/ProjectMix I/O. The object is to maintain format of isochronous
packet payload for packet streaming by components for ALSA rawMIDI/PCM
interfaces. The object can be released as managed-resource of
'struct snd_card.card_dev'.

This commit uses managed-resource of the sound card device for this
purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c        | 4 ----
 sound/firewire/bebob/bebob_maudio.c | 5 +++--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index fb05f2c1b60b..72b04214a3b5 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -130,8 +130,6 @@ static void bebob_free(struct snd_bebob *bebob)
 {
 	snd_bebob_stream_destroy_duplex(bebob);
 
-	kfree(bebob->maudio_special_quirk);
-
 	mutex_destroy(&bebob->mutex);
 	fw_unit_put(bebob->unit);
 }
@@ -262,8 +260,6 @@ do_registration(struct work_struct *work)
 error:
 	mutex_unlock(&devices_mutex);
 	snd_bebob_stream_destroy_duplex(bebob);
-	kfree(bebob->maudio_special_quirk);
-	bebob->maudio_special_quirk = NULL;
 	snd_card_free(bebob->card);
 	dev_info(&bebob->unit->device,
 		 "Sound card registration failed: %d\n", err);
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index c266997ad299..51152ca4af57 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -261,8 +261,9 @@ snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814)
 	struct special_params *params;
 	int err;
 
-	params = kzalloc(sizeof(struct special_params), GFP_KERNEL);
-	if (params == NULL)
+	params = devm_kzalloc(&bebob->card->card_dev,
+			      sizeof(struct special_params), GFP_KERNEL);
+	if (!params)
 		return -ENOMEM;
 
 	mutex_lock(&bebob->mutex);
-- 
2.17.1
