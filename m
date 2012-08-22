From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - fix broken HDMI jack detection
	after S3
Date: Wed, 22 Aug 2012 14:01:41 +0200
Message-ID: <1345636901-9386-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A74AC2663D8
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 14:01:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, 1040030@bugs.launchpad.net
Cc: "3.3+" <stable@kernel.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The HDMI codec (an NVIDIA one in this case) forgot that its pins
were unsol enabled, while it was suspended. Therefore jack detection
was broken after S3.
With this patch, we reenable the unsol events on resume,
and also do an extra check afterwards, to see if the HDMI monitor was
plugged/unplugged while in S3.

Cc: stable@kernel.org (3.3+)
BugLink: https://bugs.launchpad.net/bugs/1040030
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8f23374..6a3ac05 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1315,6 +1315,16 @@ static int generic_hdmi_init(struct hda_codec *codec)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int generic_hdmi_resume(struct hda_codec *codec)
+{
+	snd_hda_codec_resume_cache(codec);
+	snd_hda_jack_set_dirty_all(codec);
+	snd_hda_jack_report_sync(codec);
+	return 0;
+}
+#endif
+
 static void generic_hdmi_free(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
@@ -1338,6 +1348,9 @@ static const struct hda_codec_ops generic_hdmi_patch_ops = {
 	.build_pcms		= generic_hdmi_build_pcms,
 	.build_controls		= generic_hdmi_build_controls,
 	.unsol_event		= hdmi_unsol_event,
+#ifdef CONFIG_PM
+	.resume			= generic_hdmi_resume,
+#endif
 };
 
 static int patch_generic_hdmi(struct hda_codec *codec)
-- 
1.7.9.5
