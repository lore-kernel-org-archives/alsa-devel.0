From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 2/2] ALSA: hda - Enable "Headset Mic" name
	for some Dell Latitude devices
Date: Thu, 21 Mar 2013 12:16:30 +0100
Message-ID: <1363864590-8751-2-git-send-email-david.henningsson@canonical.com>
References: <1363864590-8751-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B37D7265E60
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 12:16:36 +0100 (CET)
In-Reply-To: <1363864590-8751-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Now that we have a "Headset Mic" name, let's use it for some devices
we know for sure has a headset mic jack.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 3be877b..1d9d642 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3528,8 +3528,12 @@ static int stac_parse_auto_config(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
 	int err;
+	int flags = 0;
 
-	err = snd_hda_parse_pin_defcfg(codec, &spec->gen.autocfg, NULL, 0);
+	if (spec->headset_jack)
+		flags |= HDA_PINCFG_HEADSET_MIC;
+
+	err = snd_hda_parse_pin_defcfg(codec, &spec->gen.autocfg, NULL, flags);
 	if (err < 0)
 		return err;
 
-- 
1.7.9.5
