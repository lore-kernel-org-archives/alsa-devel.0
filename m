From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - Make a SND_HDA_PIN_QUIRK macro
Date: Tue, 24 Jun 2014 14:46:53 +0200
Message-ID: <1403614014-15417-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 779382652AD
 for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2014 14:46:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, hui.wang@canonical.com, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is cosmetical - it makes the new pin quirk table look better.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_local.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

Hi Takashi,

If I were you, I'd take these patches for 3.16 even though it's not strictly a
regression - as it would make maintenance easier not to have any release with
the quirk table in non-macro style.

Sorry for not making this macro earlier.

diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index ebd1fa6..4e2d486 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -417,6 +417,27 @@ struct snd_hda_pin_quirk {
 	int value;			/* quirk value */
 };
 
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+
+#define SND_HDA_PIN_QUIRK(_codec, _subvendor, _name, _value, _pins...) \
+	{ .codec = _codec,\
+	  .subvendor = _subvendor,\
+	  .name = _name,\
+	  .value = _value,\
+	  .pins = (const struct hda_pintbl[]) { _pins } \
+	}
+#else
+
+#define SND_HDA_PIN_QUIRK(_codec, _subvendor, _name, _value, _pins...) \
+	{ .codec = _codec,\
+	  .subvendor = _subvendor,\
+	  .value = _value,\
+	  .pins = (const struct hda_pintbl[]) { _pins } \
+	}
+
+#endif
+
+
 /* fixup types */
 enum {
 	HDA_FIXUP_INVALID,
-- 
1.9.1
