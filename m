From: tiwai@suse.de
Subject: [PATCH 2/3] ALSA: hda - Fix invalid connections in
	VT1802 codec
Date: Wed,  7 Nov 2012 12:52:19 +0100
Message-ID: <1352289140-30731-3-git-send-email-tiwai@suse.de>
References: <1352289140-30731-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9056D264FF3
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 12:52:28 +0100 (CET)
In-Reply-To: <1352289140-30731-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Massimo Del Fedele <max@veneto.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai <tiwai@suse.de>

VT1802 codec provides the invalid connection lists of NID 0x24 and
0x33 containing the routes to a non-exist widget 0x3e.  This confuses
the auto-parser.  Fix it up in the driver by overriding these
connections.

Reported-by: Massimo Del Fedele <max@veneto.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_via.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 1c1367b..34b7f2a 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -3649,6 +3649,18 @@ static const struct snd_pci_quirk vt2002p_fixups[] = {
 	{}
 };
 
+/* NIDs 0x24 and 0x33 on VT1802 have connections to non-existing NID 0x3e
+ * Replace this with mixer NID 0x1c
+ */
+static void fix_vt1802_connections(struct hda_codec *codec)
+{
+	static hda_nid_t conn_24[] = { 0x14, 0x1c };
+	static hda_nid_t conn_33[] = { 0x1c };
+
+	snd_hda_override_conn_list(codec, 0x24, ARRAY_SIZE(conn_24), conn_24);
+	snd_hda_override_conn_list(codec, 0x33, ARRAY_SIZE(conn_33), conn_33);
+}
+
 /* patch for vt2002P */
 static int patch_vt2002P(struct hda_codec *codec)
 {
@@ -3663,6 +3675,8 @@ static int patch_vt2002P(struct hda_codec *codec)
 	spec->aa_mix_nid = 0x21;
 	override_mic_boost(codec, 0x2b, 0, 3, 40);
 	override_mic_boost(codec, 0x29, 0, 3, 40);
+	if (spec->codec_type == VT1802)
+		fix_vt1802_connections(codec);
 	add_secret_dac_path(codec);
 
 	snd_hda_pick_fixup(codec, NULL, vt2002p_fixups, via_fixups);
-- 
1.8.0
