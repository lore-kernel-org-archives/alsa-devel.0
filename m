From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add a sanity check of pin / port
	mapping on i915 HDMI/DP
Date: Thu, 10 Mar 2016 15:55:01 +0100
Message-ID: <1457621701-13885-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CCD62260831
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 15:55:02 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2238DAB5D
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 14:55:02 +0000 (UTC)
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

There is an implicit rule to map between pin NID and port number on
Intel HDMI/DP codec: the mapping is fixed only for NID 0x05, 0x06 and
0x07.  For avoiding the possible memory corruption, add a sanity check
for the NID value and splat WARN_ON() for invalid accesses.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_i915.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index f6854dbd7d8d..fb96aead8257 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -126,6 +126,8 @@ EXPORT_SYMBOL_GPL(snd_hdac_get_display_clk);
  */
 static int pin2port(hda_nid_t pin_nid)
 {
+	if (WARN_ON(pin_nid < 5 || pin_nid > 7))
+		return -1;
 	return pin_nid - 4;
 }
 
@@ -144,10 +146,14 @@ static int pin2port(hda_nid_t pin_nid)
 int snd_hdac_sync_audio_rate(struct hdac_bus *bus, hda_nid_t nid, int rate)
 {
 	struct i915_audio_component *acomp = bus->audio_component;
+	int port;
 
 	if (!acomp || !acomp->ops || !acomp->ops->sync_audio_rate)
 		return -ENODEV;
-	return acomp->ops->sync_audio_rate(acomp->dev, pin2port(nid), rate);
+	port = pin2port(nid);
+	if (port < 0)
+		return -EINVAL;
+	return acomp->ops->sync_audio_rate(acomp->dev, port, rate);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_sync_audio_rate);
 
@@ -175,11 +181,15 @@ int snd_hdac_acomp_get_eld(struct hdac_bus *bus, hda_nid_t nid,
 			   bool *audio_enabled, char *buffer, int max_bytes)
 {
 	struct i915_audio_component *acomp = bus->audio_component;
+	int port;
 
 	if (!acomp || !acomp->ops || !acomp->ops->get_eld)
 		return -ENODEV;
 
-	return acomp->ops->get_eld(acomp->dev, pin2port(nid), audio_enabled,
+	port = pin2port(nid);
+	if (port < 0)
+		return -EINVAL;
+	return acomp->ops->get_eld(acomp->dev, port, audio_enabled,
 				   buffer, max_bytes);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_acomp_get_eld);
-- 
2.7.2
