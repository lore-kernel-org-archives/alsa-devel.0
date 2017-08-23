From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/6] ALSA: pcm: Adjust nine function calls
 together with a variable assignment
Date: Wed, 23 Aug 2017 10:24:34 +0200
Message-ID: <9fcdbe5a-b17a-dfb8-f4af-a1261da93a38@users.sourceforge.net>
References: <b8c9e41b-a47e-1d99-3d1a-5d39772e4b54@users.sourceforge.net>
 <s5h378isw2d.wl-tiwai@suse.de>
 <800d7aa6-d8f2-cbf5-caaa-7e4006976e68@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id D2BE62665D5
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 10:24:43 +0200 (CEST)
In-Reply-To: <800d7aa6-d8f2-cbf5-caaa-7e4006976e68@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ingo Molnar <mingo@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 23 Aug 2017 09:20:29 +0200

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/pcm.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 048df9658f50..c790f79e45ae 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -523,7 +523,9 @@ static int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr)
 
 	sprintf(name, "pcm%i%c", pcm->device, 
 		pstr->stream == SNDRV_PCM_STREAM_PLAYBACK ? 'p' : 'c');
-	if ((entry = snd_info_create_card_entry(pcm->card, name, pcm->card->proc_root)) == NULL)
+	entry = snd_info_create_card_entry(pcm->card, name,
+					   pcm->card->proc_root);
+	if (!entry)
 		return -ENOMEM;
 	entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
 	if (snd_info_register(entry) < 0) {
@@ -531,8 +533,8 @@ static int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr)
 		return -ENOMEM;
 	}
 	pstr->proc_root = entry;
-
-	if ((entry = snd_info_create_card_entry(pcm->card, "info", pstr->proc_root)) != NULL) {
+	entry = snd_info_create_card_entry(pcm->card, "info", pstr->proc_root);
+	if (entry) {
 		snd_info_set_text_ops(entry, pstr, snd_pcm_stream_proc_info_read);
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
@@ -542,8 +544,9 @@ static int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr)
 	pstr->proc_info_entry = entry;
 
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
-	if ((entry = snd_info_create_card_entry(pcm->card, "xrun_debug",
-						pstr->proc_root)) != NULL) {
+	entry = snd_info_create_card_entry(pcm->card, "xrun_debug",
+					   pstr->proc_root);
+	if (entry) {
 		entry->c.text.read = snd_pcm_xrun_debug_read;
 		entry->c.text.write = snd_pcm_xrun_debug_write;
 		entry->mode |= S_IWUSR;
@@ -580,7 +583,9 @@ static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 	card = substream->pcm->card;
 
 	sprintf(name, "sub%i", substream->number);
-	if ((entry = snd_info_create_card_entry(card, name, substream->pstr->proc_root)) == NULL)
+	entry = snd_info_create_card_entry(card, name,
+					   substream->pstr->proc_root);
+	if (!entry)
 		return -ENOMEM;
 	entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
 	if (snd_info_register(entry) < 0) {
@@ -588,8 +593,8 @@ static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 		return -ENOMEM;
 	}
 	substream->proc_root = entry;
-
-	if ((entry = snd_info_create_card_entry(card, "info", substream->proc_root)) != NULL) {
+	entry = snd_info_create_card_entry(card, "info", substream->proc_root);
+	if (entry) {
 		snd_info_set_text_ops(entry, substream,
 				      snd_pcm_substream_proc_info_read);
 		if (snd_info_register(entry) < 0) {
@@ -598,8 +603,9 @@ static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 		}
 	}
 	substream->proc_info_entry = entry;
-
-	if ((entry = snd_info_create_card_entry(card, "hw_params", substream->proc_root)) != NULL) {
+	entry = snd_info_create_card_entry(card, "hw_params",
+					   substream->proc_root);
+	if (entry) {
 		snd_info_set_text_ops(entry, substream,
 				      snd_pcm_substream_proc_hw_params_read);
 		if (snd_info_register(entry) < 0) {
@@ -608,8 +614,9 @@ static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 		}
 	}
 	substream->proc_hw_params_entry = entry;
-
-	if ((entry = snd_info_create_card_entry(card, "sw_params", substream->proc_root)) != NULL) {
+	entry = snd_info_create_card_entry(card, "sw_params",
+					   substream->proc_root);
+	if (entry) {
 		snd_info_set_text_ops(entry, substream,
 				      snd_pcm_substream_proc_sw_params_read);
 		if (snd_info_register(entry) < 0) {
@@ -618,8 +625,8 @@ static int snd_pcm_substream_proc_init(struct snd_pcm_substream *substream)
 		}
 	}
 	substream->proc_sw_params_entry = entry;
-
-	if ((entry = snd_info_create_card_entry(card, "status", substream->proc_root)) != NULL) {
+	entry = snd_info_create_module_entry(THIS_MODULE, "pcm", NULL);
+	if (entry) {
 		snd_info_set_text_ops(entry, substream,
 				      snd_pcm_substream_proc_status_read);
 		if (snd_info_register(entry) < 0) {
@@ -1230,7 +1237,8 @@ static void snd_pcm_proc_init(void)
 {
 	struct snd_info_entry *entry;
 
-	if ((entry = snd_info_create_module_entry(THIS_MODULE, "pcm", NULL)) != NULL) {
+	entry = snd_info_create_module_entry(THIS_MODULE, "pcm", NULL);
+	if (entry) {
 		snd_info_set_text_ops(entry, NULL, snd_pcm_proc_read);
 		if (snd_info_register(entry) < 0) {
 			snd_info_free_entry(entry);
-- 
2.14.0
