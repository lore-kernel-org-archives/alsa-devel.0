From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/10] ALSA: hda: Fix implicit PCM format type
	conversion
Date: Wed, 25 Jul 2018 23:19:36 +0200
Message-ID: <20180725211945.19222-2-tiwai@suse.de>
References: <20180725211945.19222-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DC8D267762
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:19:54 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A6ED9B078
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:19:53 +0000 (UTC)
In-Reply-To: <20180725211945.19222-1-tiwai@suse.de>
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

The PCM format type is defined with __bitwise, hence it can't be
passed as integer but needs an explicit cast.  In this patch, instead
of the messy cast flood, define the format argument of
snd_hdac_calc_stream_format() to be the proper snd_pcm_format_t type.

This fixes sparse warnings like:
  sound/hda/hdac_device.c:760:38: warning: incorrect type in argument 1 (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h | 3 ++-
 sound/hda/hdac_device.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 8305e7971035..6f1e1f3b3063 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -11,6 +11,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/timecounter.h>
 #include <sound/core.h>
+#include <sound/pcm.h>
 #include <sound/memalloc.h>
 #include <sound/hda_verbs.h>
 #include <drm/i915_component.h>
@@ -133,7 +134,7 @@ int snd_hdac_get_sub_nodes(struct hdac_device *codec, hda_nid_t nid,
 			   hda_nid_t *start_id);
 unsigned int snd_hdac_calc_stream_format(unsigned int rate,
 					 unsigned int channels,
-					 unsigned int format,
+					 snd_pcm_format_t format,
 					 unsigned int maxbps,
 					 unsigned short spdif_ctls);
 int snd_hdac_query_supported_pcm(struct hdac_device *codec, hda_nid_t nid,
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 7ba100bb1c3f..dbf02a3a8d2f 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -738,7 +738,7 @@ static struct hda_rate_tbl rate_bits[] = {
  */
 unsigned int snd_hdac_calc_stream_format(unsigned int rate,
 					 unsigned int channels,
-					 unsigned int format,
+					 snd_pcm_format_t format,
 					 unsigned int maxbps,
 					 unsigned short spdif_ctls)
 {
-- 
2.18.0
