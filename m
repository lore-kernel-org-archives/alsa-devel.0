From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/15] ALSA: hda - Fix possible access to
	uninitialized work struct
Date: Mon, 14 May 2012 17:31:53 +0200
Message-ID: <1337009526-26256-3-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 7937F24A28
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E5D158FB75
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:17 +0200 (CEST)
In-Reply-To: <1337009526-26256-1-git-send-email-tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The work struct must be initialized before the possible call in the
destructor.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 393a304..98976c8 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1264,13 +1264,6 @@ int /*__devinit*/ snd_hda_codec_new(struct hda_bus *bus,
 	snd_array_init(&codec->cvt_setups, sizeof(struct hda_cvt_setup), 8);
 	snd_array_init(&codec->conn_lists, sizeof(hda_nid_t), 64);
 	snd_array_init(&codec->spdif_out, sizeof(struct hda_spdif_out), 16);
-	if (codec->bus->modelname) {
-		codec->modelname = kstrdup(codec->bus->modelname, GFP_KERNEL);
-		if (!codec->modelname) {
-			snd_hda_codec_free(codec);
-			return -ENODEV;
-		}
-	}
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	INIT_DELAYED_WORK(&codec->power_work, hda_power_work);
@@ -1281,6 +1274,14 @@ int /*__devinit*/ snd_hda_codec_new(struct hda_bus *bus,
 	hda_keep_power_on(codec);
 #endif
 
+	if (codec->bus->modelname) {
+		codec->modelname = kstrdup(codec->bus->modelname, GFP_KERNEL);
+		if (!codec->modelname) {
+			snd_hda_codec_free(codec);
+			return -ENODEV;
+		}
+	}
+
 	list_add_tail(&codec->list, &bus->codec_list);
 	bus->caddr_tbl[codec_addr] = codec;
 
-- 
1.7.9.2
