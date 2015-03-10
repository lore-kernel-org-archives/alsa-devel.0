From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: core: Drop superfluous error/debug
	messages after malloc failures
Date: Tue, 10 Mar 2015 15:43:19 +0100
Message-ID: <1425998599-9481-3-git-send-email-tiwai@suse.de>
References: <1425998599-9481-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 882F32605A2
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 15:43:23 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3A7E1AD9D
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 14:43:23 +0000 (UTC)
In-Reply-To: <1425998599-9481-1-git-send-email-tiwai@suse.de>
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

The kernel memory allocators already report the errors when the
requested allocation fails, thus we don't need to warn it again in
each caller side.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c       |  4 +---
 sound/core/device.c        |  4 +---
 sound/core/hwdep.c         |  4 +---
 sound/core/oss/mixer_oss.c |  4 +---
 sound/core/oss/pcm_oss.c   |  1 -
 sound/core/pcm.c           | 13 +++----------
 sound/core/rawmidi.c       |  8 ++------
 sound/core/timer.c         |  4 +---
 8 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index e1d8e0c816f0..833b223a363a 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -217,10 +217,8 @@ static int snd_ctl_new(struct snd_kcontrol **kctl, unsigned int count,
 	size += sizeof(struct snd_kcontrol_volatile) * count;
 
 	*kctl = kzalloc(size, GFP_KERNEL);
-	if (*kctl == NULL) {
-		pr_err("ALSA: Cannot allocate control instance\n");
+	if (!*kctl)
 		return -ENOMEM;
-	}
 
 	for (idx = 0; idx < count; idx++) {
 		(*kctl)->vd[idx].access = access;
diff --git a/sound/core/device.c b/sound/core/device.c
index 41bec3075ae5..c1a845b42a8b 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -50,10 +50,8 @@ int snd_device_new(struct snd_card *card, enum snd_device_type type,
 	if (snd_BUG_ON(!card || !device_data || !ops))
 		return -ENXIO;
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (dev == NULL) {
-		dev_err(card->dev, "Cannot allocate device, type=%d\n", type);
+	if (!dev)
 		return -ENOMEM;
-	}
 	INIT_LIST_HEAD(&dev->list);
 	dev->card = card;
 	dev->type = type;
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 84244a5143cf..51692c8a39ea 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -378,10 +378,8 @@ int snd_hwdep_new(struct snd_card *card, char *id, int device,
 	if (rhwdep)
 		*rhwdep = NULL;
 	hwdep = kzalloc(sizeof(*hwdep), GFP_KERNEL);
-	if (hwdep == NULL) {
-		dev_err(card->dev, "hwdep: cannot allocate\n");
+	if (!hwdep)
 		return -ENOMEM;
-	}
 
 	init_waitqueue_head(&hwdep->open_wait);
 	mutex_init(&hwdep->open_mutex);
diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 5e6349f00ecd..056f8e274851 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -1212,10 +1212,8 @@ static void snd_mixer_oss_proc_write(struct snd_info_entry *entry,
 			/* not changed */
 			goto __unlock;
 		tbl = kmalloc(sizeof(*tbl), GFP_KERNEL);
-		if (! tbl) {
-			pr_err("ALSA: mixer_oss: no memory\n");
+		if (!tbl)
 			goto __unlock;
-		}
 		tbl->oss_id = ch;
 		tbl->name = kstrdup(str, GFP_KERNEL);
 		if (! tbl->name) {
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 80423a4ccab6..58550cc93f28 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -854,7 +854,6 @@ static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream)
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
 	if (!sw_params || !params || !sparams) {
-		pcm_dbg(substream->pcm, "No memory\n");
 		err = -ENOMEM;
 		goto failure;
 	}
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index e9b87465c73d..b25bcf5b8644 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -343,11 +343,8 @@ static void snd_pcm_proc_info_read(struct snd_pcm_substream *substream,
 		return;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (! info) {
-		pcm_dbg(substream->pcm,
-			"snd_pcm_proc_info_read: cannot malloc\n");
+	if (!info)
 		return;
-	}
 
 	err = snd_pcm_info(substream, info);
 	if (err < 0) {
@@ -717,10 +714,8 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 	prev = NULL;
 	for (idx = 0, prev = NULL; idx < substream_count; idx++) {
 		substream = kzalloc(sizeof(*substream), GFP_KERNEL);
-		if (substream == NULL) {
-			pcm_err(pcm, "Cannot allocate PCM substream\n");
+		if (!substream)
 			return -ENOMEM;
-		}
 		substream->pcm = pcm;
 		substream->pstr = pstr;
 		substream->number = idx;
@@ -774,10 +769,8 @@ static int _snd_pcm_new(struct snd_card *card, const char *id, int device,
 	if (rpcm)
 		*rpcm = NULL;
 	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
-	if (pcm == NULL) {
-		dev_err(card->dev, "Cannot allocate PCM\n");
+	if (!pcm)
 		return -ENOMEM;
-	}
 	pcm->card = card;
 	pcm->device = device;
 	pcm->internal = internal;
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index b5a748596fc4..a7759846fbaa 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1429,10 +1429,8 @@ static int snd_rawmidi_alloc_substreams(struct snd_rawmidi *rmidi,
 
 	for (idx = 0; idx < count; idx++) {
 		substream = kzalloc(sizeof(*substream), GFP_KERNEL);
-		if (substream == NULL) {
-			rmidi_err(rmidi, "rawmidi: cannot allocate substream\n");
+		if (!substream)
 			return -ENOMEM;
-		}
 		substream->stream = direction;
 		substream->number = idx;
 		substream->rmidi = rmidi;
@@ -1479,10 +1477,8 @@ int snd_rawmidi_new(struct snd_card *card, char *id, int device,
 	if (rrawmidi)
 		*rrawmidi = NULL;
 	rmidi = kzalloc(sizeof(*rmidi), GFP_KERNEL);
-	if (rmidi == NULL) {
-		dev_err(card->dev, "rawmidi: cannot allocate\n");
+	if (!rmidi)
 		return -ENOMEM;
-	}
 	rmidi->card = card;
 	rmidi->device = device;
 	mutex_init(&rmidi->open_mutex);
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 490b489d713d..a9a1a047c521 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -774,10 +774,8 @@ int snd_timer_new(struct snd_card *card, char *id, struct snd_timer_id *tid,
 	if (rtimer)
 		*rtimer = NULL;
 	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
-	if (timer == NULL) {
-		pr_err("ALSA: timer: cannot allocate\n");
+	if (!timer)
 		return -ENOMEM;
-	}
 	timer->tmr_class = tid->dev_class;
 	timer->card = card;
 	timer->tmr_device = tid->device;
-- 
2.3.2
