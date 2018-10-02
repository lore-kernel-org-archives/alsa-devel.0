From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: oxfw: use managed-resource to
	maintain model-specific data
Date: Wed,  3 Oct 2018 08:21:53 +0900
Message-ID: <20181002232154.29225-5-o-takashi@sakamocchi.jp>
References: <20181002232154.29225-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A4CEC2678B0
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 01:22:16 +0200 (CEST)
Received: by mail-pf1-f193.google.com with SMTP id f26-v6so554462pfn.9
 for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2018 16:22:16 -0700 (PDT)
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

ALSA oxfw driver allocates memory objects for data specific to some
models. These objects are used to maintain functionalities specific
to the models for ALSA rawMIDI/control interfaces. They can be
released as managed-resource of 'struct snd_card.card_dev'.

This commit uses managed-resource of the sound card device for this
purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-scs1x.c | 5 +++--
 sound/firewire/oxfw/oxfw-spkr.c  | 5 +++--
 sound/firewire/oxfw/oxfw.c       | 3 ---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index f33497cdc706..9d9545880a28 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -372,8 +372,9 @@ int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
 	struct fw_scs1x *scs;
 	int err;
 
-	scs = kzalloc(sizeof(struct fw_scs1x), GFP_KERNEL);
-	if (scs == NULL)
+	scs = devm_kzalloc(&oxfw->card->card_dev, sizeof(struct fw_scs1x),
+			   GFP_KERNEL);
+	if (!scs)
 		return -ENOMEM;
 	scs->fw_dev = fw_parent_device(oxfw->unit);
 	oxfw->spec = scs;
diff --git a/sound/firewire/oxfw/oxfw-spkr.c b/sound/firewire/oxfw/oxfw-spkr.c
index cb905af0660d..66d4b1f73f0f 100644
--- a/sound/firewire/oxfw/oxfw-spkr.c
+++ b/sound/firewire/oxfw/oxfw-spkr.c
@@ -270,8 +270,9 @@ int snd_oxfw_add_spkr(struct snd_oxfw *oxfw, bool is_lacie)
 	unsigned int i, first_ch;
 	int err;
 
-	spkr = kzalloc(sizeof(struct fw_spkr), GFP_KERNEL);
-	if (spkr == NULL)
+	spkr = devm_kzalloc(&oxfw->card->card_dev, sizeof(struct fw_spkr),
+			    GFP_KERNEL);
+	if (!spkr)
 		return -ENOMEM;
 	oxfw->spec = spkr;
 
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index b892a8642204..06d791acfdc5 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -126,7 +126,6 @@ static void oxfw_free(struct snd_oxfw *oxfw)
 		kfree(oxfw->rx_stream_formats[i]);
 	}
 
-	kfree(oxfw->spec);
 	mutex_destroy(&oxfw->mutex);
 	fw_unit_put(oxfw->unit);
 }
@@ -276,8 +275,6 @@ static void do_registration(struct work_struct *work)
 		oxfw->rx_stream_formats[i] = NULL;
 	}
 	snd_card_free(oxfw->card);
-	kfree(oxfw->spec);
-	oxfw->spec = NULL;
 	dev_info(&oxfw->unit->device,
 		 "Sound card registration failed: %d\n", err);
 }
-- 
2.17.1
