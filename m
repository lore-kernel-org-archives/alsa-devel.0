From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add static DAC/pin mapping for
	AD1986A codec
Date: Wed, 11 Dec 2013 07:26:17 +0100
Message-ID: <1386743177-14690-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 79C31261AE2
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 07:26:17 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4E287A7D78
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 07:26:17 +0100 (CET)
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

AD1986A codec is a pretty old codec and has really many hidden
restrictions.  One of such is that each DAC is dedicated to certain
pin although there are possible connections.  Currently, the generic
parser tries to assign individual DACs as much as possible, and this
lead to two bad situations: connections where the sound actually
doesn't work, and connections conflicting other channels.

We may fix this by trying to find the best connections more harder,
but as of now, it's easier to give some hints for paired DAC/pin
connections and honor them if available, since such a hint is needed
only for specific codecs (right now only AD1986A, and there will be
unlikely any others in future).

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=64971
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=66621
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c  | 23 ++++++++++++++++++++++-
 sound/pci/hda/hda_generic.h  |  3 +++
 sound/pci/hda/patch_analog.c | 10 ++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 249cd4615908..c7f6d1cab606 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -474,6 +474,20 @@ static void invalidate_nid_path(struct hda_codec *codec, int idx)
 	memset(path, 0, sizeof(*path));
 }
 
+/* return a DAC if paired to the given pin by codec driver */
+static hda_nid_t get_preferred_dac(struct hda_codec *codec, hda_nid_t pin)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	const hda_nid_t *list = spec->preferred_dacs;
+
+	if (!list)
+		return 0;
+	for (; *list; list += 2)
+		if (*list == pin)
+			return list[1];
+	return 0;
+}
+
 /* look for an empty DAC slot */
 static hda_nid_t look_for_dac(struct hda_codec *codec, hda_nid_t pin,
 			      bool is_digital)
@@ -1192,7 +1206,14 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 			continue;
 		}
 
-		dacs[i] = look_for_dac(codec, pin, false);
+		dacs[i] = get_preferred_dac(codec, pin);
+		if (dacs[i]) {
+			if (is_dac_already_used(codec, dacs[i]))
+				badness += bad->shared_primary;
+		}
+
+		if (!dacs[i])
+			dacs[i] = look_for_dac(codec, pin, false);
 		if (!dacs[i] && !i) {
 			/* try to steal the DAC of surrounds for the front */
 			for (j = 1; j < num_outs; j++) {
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 7e45cb44d151..0929a06df812 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -249,6 +249,9 @@ struct hda_gen_spec {
 	const struct badness_table *main_out_badness;
 	const struct badness_table *extra_out_badness;
 
+	/* preferred pin/DAC pairs; an array of paired NIDs */
+	const hda_nid_t *preferred_dacs;
+
 	/* loopback mixing mode */
 	bool aamix_mode;
 
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index cac015be3325..699262a3e07a 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -340,6 +340,14 @@ static int patch_ad1986a(struct hda_codec *codec)
 {
 	int err;
 	struct ad198x_spec *spec;
+	static hda_nid_t preferred_pairs[] = {
+		0x1a, 0x03,
+		0x1b, 0x03,
+		0x1c, 0x04,
+		0x1d, 0x05,
+		0x1e, 0x03,
+		0
+	};
 
 	err = alloc_ad_spec(codec);
 	if (err < 0)
@@ -360,6 +368,8 @@ static int patch_ad1986a(struct hda_codec *codec)
 	 * So, let's disable the shared stream.
 	 */
 	spec->gen.multiout.no_share_stream = 1;
+	/* give fixed DAC/pin pairs */
+	spec->gen.preferred_dacs = preferred_pairs;
 
 	/* AD1986A can't manage the dynamic pin on/off smoothly */
 	spec->gen.auto_mute_via_amp = 1;
-- 
1.8.5
