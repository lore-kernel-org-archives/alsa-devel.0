From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Subject: [PATCH] sound: Conversions from kmalloc+memset to
	k(z|c)alloc
Date: Thu, 20 Jul 2006 20:46:31 +0200
Message-ID: <20060720184630.GA7643@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from student.uhasselt.be (student.uhasselt.be [193.190.2.1])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 314CD127
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 20:46:34 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Panagiotis Issaris <takis@issaris.org>

sound: Conversions from kmalloc+memset to k(c|z)alloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
 sound/core/oss/mixer_oss.c      |    3 +--
 sound/core/seq/seq_device.c     |    3 +--
 sound/core/sgbuf.c              |    9 +++------
 sound/drivers/vx/vx_pcm.c       |    7 ++-----
 sound/pci/echoaudio/echoaudio.c |    4 ++--
 sound/ppc/awacs.c               |    3 +--
 sound/ppc/daca.c                |    3 +--
 sound/ppc/keywest.c             |    3 +--
 sound/ppc/tumbler.c             |    3 +--
 sound/usb/usbaudio.c            |    6 ++----
 10 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 71b5080..75a9505 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -988,13 +988,12 @@ static int snd_mixer_oss_build_input(str
 	if (ptr->index == 0 && (kctl = snd_mixer_oss_test_id(mixer, "Capture Source", 0)) != NULL) {
 		struct snd_ctl_elem_info *uinfo;
 
-		uinfo = kmalloc(sizeof(*uinfo), GFP_KERNEL);
+		uinfo = kzalloc(sizeof(*uinfo), GFP_KERNEL);
 		if (! uinfo) {
 			up_read(&mixer->card->controls_rwsem);
 			return -ENOMEM;
 		}
 			
-		memset(uinfo, 0, sizeof(*uinfo));
 		if (kctl->info(kctl, uinfo)) {
 			up_read(&mixer->card->controls_rwsem);
 			return 0;
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index 4260de9..102ff54 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -372,10 +372,9 @@ static struct ops_list * create_driver(c
 {
 	struct ops_list *ops;
 
-	ops = kmalloc(sizeof(*ops), GFP_KERNEL);
+	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
 	if (ops == NULL)
 		return ops;
-	memset(ops, 0, sizeof(*ops));
 
 	/* set up driver entry */
 	strlcpy(ops->id, id, sizeof(ops->id));
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index 6e4d4ab..c30669f 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -68,21 +68,18 @@ void *snd_malloc_sgbuf_pages(struct devi
 
 	dmab->area = NULL;
 	dmab->addr = 0;
-	dmab->private_data = sgbuf = kmalloc(sizeof(*sgbuf), GFP_KERNEL);
+	dmab->private_data = sgbuf = kzalloc(sizeof(*sgbuf), GFP_KERNEL);
 	if (! sgbuf)
 		return NULL;
-	memset(sgbuf, 0, sizeof(*sgbuf));
 	sgbuf->dev = device;
 	pages = snd_sgbuf_aligned_pages(size);
 	sgbuf->tblsize = sgbuf_align_table(pages);
-	sgbuf->table = kmalloc(sizeof(*sgbuf->table) * sgbuf->tblsize, GFP_KERNEL);
+	sgbuf->table = kcalloc(sgbuf->tblsize, sizeof(*sgbuf->table), GFP_KERNEL);
 	if (! sgbuf->table)
 		goto _failed;
-	memset(sgbuf->table, 0, sizeof(*sgbuf->table) * sgbuf->tblsize);
-	sgbuf->page_table = kmalloc(sizeof(*sgbuf->page_table) * sgbuf->tblsize, GFP_KERNEL);
+	sgbuf->page_table = kcalloc(sgbuf->tblsize, sizeof(*sgbuf->page_table), GFP_KERNEL);
 	if (! sgbuf->page_table)
 		goto _failed;
-	memset(sgbuf->page_table, 0, sizeof(*sgbuf->page_table) * sgbuf->tblsize);
 
 	/* allocate each page */
 	for (i = 0; i < pages; i++) {
diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index c4af849..7e65a10 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -1252,18 +1252,15 @@ static int vx_init_audio_io(struct vx_co
 	chip->audio_info = rmh.Stat[1];
 
 	/* allocate pipes */
-	chip->playback_pipes = kmalloc(sizeof(struct vx_pipe *) * chip->audio_outs, GFP_KERNEL);
+	chip->playback_pipes = kcalloc(chip->audio_outs, sizeof(struct vx_pipe *), GFP_KERNEL);
 	if (!chip->playback_pipes)
 		return -ENOMEM;
-	chip->capture_pipes = kmalloc(sizeof(struct vx_pipe *) * chip->audio_ins, GFP_KERNEL);
+	chip->capture_pipes = kcalloc(chip->audio_ins, sizeof(struct vx_pipe *), GFP_KERNEL);
 	if (!chip->capture_pipes) {
 		kfree(chip->playback_pipes);
 		return -ENOMEM;
 	}
 
-	memset(chip->playback_pipes, 0, sizeof(struct vx_pipe *) * chip->audio_outs);
-	memset(chip->capture_pipes, 0, sizeof(struct vx_pipe *) * chip->audio_ins);
-
 	preferred = chip->ibl.size;
 	chip->ibl.size = 0;
 	vx_set_ibl(chip, &chip->ibl); /* query the info */
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 27a8dbe..c3dafa2 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -236,9 +236,9 @@ static int pcm_open(struct snd_pcm_subst
 	chip = snd_pcm_substream_chip(substream);
 	runtime = substream->runtime;
 
-	if (!(pipe = kmalloc(sizeof(struct audiopipe), GFP_KERNEL)))
+	pipe = kzalloc(sizeof(struct audiopipe), GFP_KERNEL);
+	if (!pipe)
 		return -ENOMEM;
-	memset(pipe, 0, sizeof(struct audiopipe));
 	pipe->index = -1;		/* Not configured yet */
 
 	/* Set up hw capabilities and contraints */
diff --git a/sound/ppc/awacs.c b/sound/ppc/awacs.c
index 82d791b..05dabe4 100644
--- a/sound/ppc/awacs.c
+++ b/sound/ppc/awacs.c
@@ -801,11 +801,10 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 	chip->revision = (in_le32(&chip->awacs->codec_stat) >> 12) & 0xf;
 #ifdef PMAC_AMP_AVAIL
 	if (chip->revision == 3 && chip->has_iic && CHECK_CUDA_AMP()) {
-		struct awacs_amp *amp = kmalloc(sizeof(*amp), GFP_KERNEL);
+		struct awacs_amp *amp = kzalloc(sizeof(*amp), GFP_KERNEL);
 		if (! amp)
 			return -ENOMEM;
 		chip->mixer_data = amp;
-		memset(amp, 0, sizeof(*amp));
 		chip->mixer_free = awacs_amp_free;
 		awacs_amp_set_vol(amp, 0, 63, 63, 0); /* mute and zero vol */
 		awacs_amp_set_vol(amp, 1, 63, 63, 0);
diff --git a/sound/ppc/daca.c b/sound/ppc/daca.c
index 46eebf5..57202b0 100644
--- a/sound/ppc/daca.c
+++ b/sound/ppc/daca.c
@@ -258,10 +258,9 @@ #ifdef CONFIG_KMOD
 		request_module("i2c-powermac");
 #endif /* CONFIG_KMOD */	
 
-	mix = kmalloc(sizeof(*mix), GFP_KERNEL);
+	mix = kzalloc(sizeof(*mix), GFP_KERNEL);
 	if (! mix)
 		return -ENOMEM;
-	memset(mix, 0, sizeof(*mix));
 	chip->mixer_data = mix;
 	chip->mixer_free = daca_cleanup;
 	mix->amp_on = 1; /* default on */
diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index fb05938..59482a4 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -64,11 +64,10 @@ static int keywest_attach_adapter(struct
 	if (strncmp(i2c_device_name(adapter), "mac-io", 6))
 		return 0; /* ignored */
 
-	new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	new_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (! new_client)
 		return -ENOMEM;
 
-	memset(new_client, 0, sizeof(*new_client));
 	new_client->addr = keywest_ctx->addr;
 	i2c_set_clientdata(new_client, keywest_ctx);
 	new_client->adapter = adapter;
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 692c611..84f6b19 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1316,10 +1316,9 @@ #ifdef CONFIG_KMOD
 		request_module("i2c-powermac");
 #endif /* CONFIG_KMOD */	
 
-	mix = kmalloc(sizeof(*mix), GFP_KERNEL);
+	mix = kzalloc(sizeof(*mix), GFP_KERNEL);
 	if (! mix)
 		return -ENOMEM;
-	memset(mix, 0, sizeof(*mix));
 	mix->headphone_irq = -1;
 
 	chip->mixer_data = mix;
diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index d32d83d..1b7f499 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -2260,10 +2260,9 @@ static int add_audio_endpoint(struct snd
 	}
 
 	/* create a new pcm */
-	as = kmalloc(sizeof(*as), GFP_KERNEL);
+	as = kzalloc(sizeof(*as), GFP_KERNEL);
 	if (! as)
 		return -ENOMEM;
-	memset(as, 0, sizeof(*as));
 	as->pcm_index = chip->pcm_devs;
 	as->chip = chip;
 	as->fmt_type = fp->fmt_type;
@@ -2633,13 +2632,12 @@ static int parse_audio_endpoints(struct 
 			csep = NULL;
 		}
 
-		fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+		fp = kzalloc(sizeof(*fp), GFP_KERNEL);
 		if (! fp) {
 			snd_printk(KERN_ERR "cannot malloc\n");
 			return -ENOMEM;
 		}
 
-		memset(fp, 0, sizeof(*fp));
 		fp->iface = iface_no;
 		fp->altsetting = altno;
 		fp->altset_idx = i;
-- 
1.4.2.rc1.ge7a0-dirty

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
