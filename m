From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Improve loopback path lookups for
	AD1983
Date: Wed,  5 Feb 2014 08:54:50 +0100
Message-ID: <1391586890-9141-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B7AE2625E0
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 08:54:51 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CC64BAB5F
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 07:54:50 +0000 (UTC)
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

AD1983 has flexible loopback routes and the generic parser would take
wrong path confusingly instead of taking individual paths via NID 0x0c
and 0x0d.  For avoiding it, limit the connections at these widgets so
that the parser can think more straightforwardly.  This fixes the
regression of the missing line-in loopback on Dell machine.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=70011
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 195cd62cdce5..df3652ad15ef 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -491,6 +491,8 @@ static int ad1983_add_spdif_mux_ctl(struct hda_codec *codec)
 static int patch_ad1983(struct hda_codec *codec)
 {
 	struct ad198x_spec *spec;
+	static hda_nid_t conn_0c[] = { 0x08 };
+	static hda_nid_t conn_0d[] = { 0x09 };
 	int err;
 
 	err = alloc_ad_spec(codec);
@@ -501,6 +503,11 @@ static int patch_ad1983(struct hda_codec *codec)
 	spec->gen.mixer_nid = 0x0e;
 	spec->gen.beep_nid = 0x10;
 	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
+
+	/* limit the loopback routes not to confuse the parser */
+	snd_hda_override_conn_list(codec, 0x0c, ARRAY_SIZE(conn_0c), conn_0c);
+	snd_hda_override_conn_list(codec, 0x0d, ARRAY_SIZE(conn_0d), conn_0d);
+
 	err = ad198x_parse_auto_config(codec, false);
 	if (err < 0)
 		goto error;
-- 
1.8.5.2
