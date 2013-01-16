From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: hda - force different capture
	controls if amp caps differ
Date: Wed, 16 Jan 2013 15:58:44 +0100
Message-ID: <1358348325-308-3-git-send-email-david.henningsson@canonical.com>
References: <1358348325-308-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 020742625FB
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 15:58:44 +0100 (CET)
In-Reply-To: <1358348325-308-1-git-send-email-david.henningsson@canonical.com>
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

Otherwise setting the capture volume for amps will be weird and
inconsistent (it will try to set values outside the range of the
second amp based on capabilities of the first amp).

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_generic.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 72325a9..a05cbab 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -484,6 +484,15 @@ static bool check_amp_caps(struct hda_codec *codec, hda_nid_t nid,
 	return false;
 }
 
+static bool same_amp_caps(struct hda_codec *codec, hda_nid_t nid1,
+			  hda_nid_t nid2, int dir)
+{
+	if (!(get_wcaps(codec, nid1) & (1 << (dir + 1))))
+		return !(get_wcaps(codec, nid2) & (1 << (dir + 1)));
+	return (query_amp_caps(codec, nid1, dir) ==
+		query_amp_caps(codec, nid2, dir));
+}
+
 #define nid_has_mute(codec, nid, dir) \
 	check_amp_caps(codec, nid, dir, AC_AMPCAP_MUTE)
 #define nid_has_volume(codec, nid, dir) \
@@ -2762,6 +2771,7 @@ static int create_capture_mixers(struct hda_codec *codec)
 
 	for (n = 0; n < nums; n++) {
 		bool multi = false;
+		bool multi_cap_vol = spec->multi_cap_vol;
 		bool inv_dmic = false;
 		int vol, sw;
 
@@ -2774,12 +2784,20 @@ static int create_capture_mixers(struct hda_codec *codec)
 			parse_capvol_in_path(codec, path);
 			if (!vol)
 				vol = path->ctls[NID_PATH_VOL_CTL];
-			else if (vol != path->ctls[NID_PATH_VOL_CTL])
+			else if (vol != path->ctls[NID_PATH_VOL_CTL]) {
 				multi = true;
+				if (!same_amp_caps(codec, vol,
+				    path->ctls[NID_PATH_VOL_CTL], HDA_INPUT))
+					multi_cap_vol = true;
+			}
 			if (!sw)
 				sw = path->ctls[NID_PATH_MUTE_CTL];
-			else if (sw != path->ctls[NID_PATH_MUTE_CTL])
+			else if (sw != path->ctls[NID_PATH_MUTE_CTL]) {
 				multi = true;
+				if (!same_amp_caps(codec, sw,
+				    path->ctls[NID_PATH_MUTE_CTL], HDA_INPUT))
+					multi_cap_vol = true;
+			}
 			if (is_inv_dmic_pin(codec, spec->imux_pins[i]))
 				inv_dmic = true;
 		}
@@ -2787,7 +2805,7 @@ static int create_capture_mixers(struct hda_codec *codec)
 		if (!multi)
 			err = create_single_cap_vol_ctl(codec, n, vol, sw,
 							inv_dmic);
-		else if (!spec->multi_cap_vol)
+		else if (!multi_cap_vol)
 			err = create_bind_cap_vol_ctl(codec, n, vol, sw);
 		else
 			err = create_multi_cap_vol_ctl(codec);
-- 
1.7.9.5
