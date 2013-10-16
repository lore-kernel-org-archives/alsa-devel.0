From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 2/3] ALSA: hda - add HDA_FIXUP_ACT_FREE action
Date: Wed, 16 Oct 2013 23:10:32 +0200
Message-ID: <1381957833-13788-3-git-send-email-david.henningsson@canonical.com>
References: <1381957833-13788-1-git-send-email-david.henningsson@canonical.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1381957833-13788-1-git-send-email-david.henningsson@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, platform-driver-x86@vger.kernel.org, ibm-acpi@hmh.eng.br, alex.hung@canonical.com, hui.wang@canonical.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

A fixup which should be called before codec being freed will come
to use in the next patch.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_local.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 2e7493e..a71bf34 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -428,6 +428,7 @@ enum {
 	HDA_FIXUP_ACT_PROBE,
 	HDA_FIXUP_ACT_INIT,
 	HDA_FIXUP_ACT_BUILD,
+	HDA_FIXUP_ACT_FREE,
 };
 
 int snd_hda_add_verbs(struct hda_codec *codec, const struct hda_verb *list);
-- 
1.7.9.5
