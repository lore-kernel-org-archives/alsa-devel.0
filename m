From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/15] ALSA: hda - Protect the power-saving
	count with spinlock
Date: Mon, 14 May 2012 17:31:56 +0200
Message-ID: <1337009526-26256-6-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FA1B24A24
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E673E90072
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

To avoid some races.  Still not perfect, but now a bit safer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c |   23 +++++++++++++++++++++--
 sound/pci/hda/hda_codec.h |    1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 8bd3432..30a3d8f 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1266,6 +1266,7 @@ int /*__devinit*/ snd_hda_codec_new(struct hda_bus *bus,
 	snd_array_init(&codec->spdif_out, sizeof(struct hda_spdif_out), 16);
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
+	spin_lock_init(&codec->power_lock);
 	INIT_DELAYED_WORK(&codec->power_work, hda_power_work);
 	/* snd_hda_codec_new() marks the codec as power-up, and leave it as is.
 	 * the caller has to power down appropriatley after initialization
@@ -4292,12 +4293,16 @@ static void hda_power_work(struct work_struct *work)
 		container_of(work, struct hda_codec, power_work.work);
 	struct hda_bus *bus = codec->bus;
 
+	spin_lock(&codec->power_lock);
 	if (!codec->power_on || codec->power_count) {
 		codec->power_transition = 0;
+		spin_unlock(&codec->power_lock);
 		return;
 	}
 
 	trace_hda_power_down(codec);
+	spin_unlock(&codec->power_lock);
+
 	hda_call_codec_suspend(codec);
 	if (bus->ops.pm_notify)
 		bus->ops.pm_notify(bus);
@@ -4305,9 +4310,11 @@ static void hda_power_work(struct work_struct *work)
 
 static void hda_keep_power_on(struct hda_codec *codec)
 {
+	spin_lock(&codec->power_lock);
 	codec->power_count++;
 	codec->power_on = 1;
 	codec->power_jiffies = jiffies;
+	spin_unlock(&codec->power_lock);
 }
 
 /* update the power on/off account with the current jiffies */
@@ -4332,20 +4339,28 @@ void snd_hda_power_up(struct hda_codec *codec)
 {
 	struct hda_bus *bus = codec->bus;
 
+	spin_lock(&codec->power_lock);
 	codec->power_count++;
-	if (codec->power_on || codec->power_transition)
+	if (codec->power_on || codec->power_transition) {
+		spin_unlock(&codec->power_lock);
 		return;
+	}
 
 	trace_hda_power_up(codec);
 	snd_hda_update_power_acct(codec);
 	codec->power_on = 1;
 	codec->power_jiffies = jiffies;
 	codec->power_transition = 1; /* avoid reentrance */
+	spin_unlock(&codec->power_lock);
+
 	if (bus->ops.pm_notify)
 		bus->ops.pm_notify(bus);
 	hda_call_codec_resume(codec);
+
+	spin_lock(&codec->power_lock);
 	cancel_delayed_work(&codec->power_work);
 	codec->power_transition = 0;
+	spin_unlock(&codec->power_lock);
 }
 EXPORT_SYMBOL_HDA(snd_hda_power_up);
 
@@ -4361,14 +4376,18 @@ EXPORT_SYMBOL_HDA(snd_hda_power_up);
  */
 void snd_hda_power_down(struct hda_codec *codec)
 {
+	spin_lock(&codec->power_lock);
 	--codec->power_count;
-	if (!codec->power_on || codec->power_count || codec->power_transition)
+	if (!codec->power_on || codec->power_count || codec->power_transition) {
+		spin_unlock(&codec->power_lock);
 		return;
+	}
 	if (power_save(codec)) {
 		codec->power_transition = 1; /* avoid reentrance */
 		queue_delayed_work(codec->bus->workq, &codec->power_work,
 				msecs_to_jiffies(power_save(codec) * 1000));
 	}
+	spin_unlock(&codec->power_lock);
 }
 EXPORT_SYMBOL_HDA(snd_hda_power_down);
 
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 0fe6491..77cd995 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -867,6 +867,7 @@ struct hda_codec {
 	unsigned long power_on_acct;
 	unsigned long power_off_acct;
 	unsigned long power_jiffies;
+	spinlock_t power_lock;
 #endif
 
 	/* codec-specific additional proc output */
-- 
1.7.9.2
