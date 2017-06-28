From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: hda - Fix endless loop of codec
	configure
Date: Wed, 28 Jun 2017 14:58:51 +0200
Message-ID: <20170628125854.13022-2-tiwai@suse.de>
References: <20170628125854.13022-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F12BE2670C0
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 14:58:55 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 95E0BAEE9
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 12:58:55 +0000 (UTC)
In-Reply-To: <20170628125854.13022-1-tiwai@suse.de>
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

azx_codec_configure() loops over the codecs found on the given
controller via a linked list.  The code used to work in the past, but
in the current version, this may lead to an endless loop when a codec
binding returns an error.

The culprit is that the snd_hda_codec_configure() unregisters the
device upon error, and this eventually deletes the given codec object
from the bus.  Since the list is initialized via list_del_init(), the
next object points to the same device itself.  This behavior change
was introduced at splitting the HD-audio code code, and forgotten to
adapt it here.

For fixing this bug, just use a *_safe() version of list iteration.

Fixes: d068ebc25e6e ("ALSA: hda - Move some codes up to hdac_bus struct")
Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.h      | 2 ++
 sound/pci/hda/hda_controller.c | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index d6fb2d5d01a7..60ce1cfc300f 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -295,6 +295,8 @@ struct hda_codec {
 
 #define list_for_each_codec(c, bus) \
 	list_for_each_entry(c, &(bus)->core.codec_list, core.list)
+#define list_for_each_codec_safe(c, n, bus)				\
+	list_for_each_entry_safe(c, n, &(bus)->core.codec_list, core.list)
 
 /* snd_hda_codec_read/write optional flags */
 #define HDA_RW_NO_RESPONSE_FALLBACK	(1 << 0)
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 3715a5725613..1c60beb5b70a 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1337,8 +1337,12 @@ EXPORT_SYMBOL_GPL(azx_probe_codecs);
 /* configure each codec instance */
 int azx_codec_configure(struct azx *chip)
 {
-	struct hda_codec *codec;
-	list_for_each_codec(codec, &chip->bus) {
+	struct hda_codec *codec, *next;
+
+	/* use _safe version here since snd_hda_codec_configure() deregisters
+	 * the device upon error and deletes itself from the bus list.
+	 */
+	list_for_each_codec_safe(codec, next, &chip->bus) {
 		snd_hda_codec_configure(codec);
 	}
 	return 0;
-- 
2.13.2
