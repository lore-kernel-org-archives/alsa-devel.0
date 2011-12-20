From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda/jack - Also add jack kctls for
	Conexant codecs
Date: Tue, 20 Dec 2011 15:23:05 +0100
Message-ID: <1324390985-3496-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 04F23103832
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 15:23:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---

Hi Takashi,

A patch for your jack branch - it seems you forgot to add kctls for conexant?
Also it would be nice to see this merged, soon it might be too late for 3.3?

 sound/pci/hda/patch_conexant.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index ae9c028..99942e6 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -4325,6 +4325,7 @@ static int cx_auto_build_input_controls(struct hda_codec *codec)
 
 static int cx_auto_build_controls(struct hda_codec *codec)
 {
+	struct conexant_spec *spec = codec->spec;
 	int err;
 
 	err = cx_auto_build_output_controls(codec);
@@ -4333,6 +4334,9 @@ static int cx_auto_build_controls(struct hda_codec *codec)
 	err = cx_auto_build_input_controls(codec);
 	if (err < 0)
 		return err;
+	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
+	if (err < 0)
+		return err;
 	return conexant_build_controls(codec);
 }
 
-- 
1.7.5.4
