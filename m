From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/7] ALSA: hda - Reduce verbs during generic
	parser initialization
Date: Fri, 27 Feb 2015 22:28:22 +0100
Message-ID: <1425072502-3204-8-git-send-email-tiwai@suse.de>
References: <1425072502-3204-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C4FA2651A3
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:28:28 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 71790AC9B
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 21:28:27 +0000 (UTC)
In-Reply-To: <1425072502-3204-1-git-send-email-tiwai@suse.de>
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

For reducing the number of verbs performed during the initialization
and the resume of the generic parser, this patch (re-)introduces the
mechanism to cache everything in init and sync later.

However, it became a bit tricky in the end: we can't use regcache's
cache_only flag straightforwardly here because we do want the actual
hardware access for reads if needed, but forbids only the writes.
So, instead, the regmap reg_write callback checks the own flag
(reusing the existing codec->cached_write) and skips the actual
access.  This works by assumption of regmap dumping the whole
registers via regcache_sync() at a later point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 4 ++++
 sound/pci/hda/hda_regmap.c  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 33de31c83d6e..bcaed93f8795 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5411,6 +5411,8 @@ int snd_hda_gen_init(struct hda_codec *codec)
 
 	snd_hda_apply_verbs(codec);
 
+	codec->cached_write = 1;
+
 	init_multi_out(codec);
 	init_extra_out(codec);
 	init_multi_io(codec);
@@ -5424,6 +5426,8 @@ int snd_hda_gen_init(struct hda_codec *codec)
 	/* call init functions of standard auto-mute helpers */
 	update_automute_all(codec);
 
+	codec->cached_write = 0;
+
 	regcache_sync(codec->regmap);
 
 	if (spec->vmaster_mute.sw_kctl && spec->vmaster_mute.hook)
diff --git a/sound/pci/hda/hda_regmap.c b/sound/pci/hda/hda_regmap.c
index 38934c06a813..79da06da286d 100644
--- a/sound/pci/hda/hda_regmap.c
+++ b/sound/pci/hda/hda_regmap.c
@@ -116,6 +116,12 @@ static int hda_reg_write(void *context, unsigned int reg, unsigned int val)
 	unsigned int verb;
 	int i, bytes;
 
+	/* skip h/w write when cached_write flag is set, assuming that
+	 * regcache_sync() will dump the all registers at a later point
+	 */
+	if (codec->cached_write)
+		return 0;
+
 	if (!codec_is_running(codec))
 		return 0; /* skip the h/w write, it'll be synced later */
 
-- 
2.3.0
