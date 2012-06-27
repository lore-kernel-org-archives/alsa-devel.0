From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - give 3-pin jack the name
	"Headphone Mic Jack"
Date: Wed, 27 Jun 2012 18:45:45 +0200
Message-ID: <1340815545-7731-2-git-send-email-david.henningsson@canonical.com>
References: <1340815545-7731-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id D1CE410402B
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 18:45:57 +0200 (CEST)
In-Reply-To: <1340815545-7731-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1018262@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This 3-pin jack was labeled "Headphone Jack", but it could also be
used as a mic jack just by switching "Input Source". Therefore we need
to call the jack something else, to make sure PulseAudio can use the
speaker together with the external mic. (PulseAudio might mute the
speaker if it detects a headphone being plugged in.)

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6174d4a..7189e07 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2001,13 +2001,31 @@ static int __alc_build_controls(struct hda_codec *codec)
 	return 0;
 }
 
-static int alc_build_controls(struct hda_codec *codec)
+static int alc_build_jacks(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
+
+	if (spec->shared_mic_hp) {
+		int err;
+		int nid = spec->autocfg.inputs[1].pin;
+		err = snd_hda_jack_add_kctl(codec, nid, "Headphone Mic", 0);
+		if (err < 0)
+			return err;
+		err = snd_hda_jack_detect_enable(codec, nid, 0);
+		if (err < 0)
+			return err;
+	}
+
+	return snd_hda_jack_add_kctls(codec, &spec->autocfg);
+}
+
+static int alc_build_controls(struct hda_codec *codec)
+{
 	int err = __alc_build_controls(codec);
 	if (err < 0)
 		return err;
-	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
+
+	err = alc_build_jacks(codec);
 	if (err < 0)
 		return err;
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_BUILD);
-- 
1.7.9.5
