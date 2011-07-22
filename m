From: Borislav Petkov <bp@amd64.org>
Subject: [PATCH] sound, hda_codec: Fix compilation warnings
Date: Fri, 22 Jul 2011 19:40:37 +0200
Message-ID: <1311356437-28816-1-git-send-email-bp@amd64.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <borislav.petkov@amd.com>
List-Id: alsa-devel@alsa-project.org

=46rom: Borislav Petkov <borislav.petkov@amd.com>

Convert macro to an inline function to shut up gcc:

sound/pci/hda/patch_sigmatel.c: In function `stac92xx_init=C2=B4:
sound/pci/hda/patch_sigmatel.c:4385:3: warning: statement with no effec=
t
sound/pci/hda/patch_sigmatel.c: In function `stac92xx_resume=C2=B4:
sound/pci/hda/patch_sigmatel.c:4925:3: warning: statement with no effec=
t
sound/pci/hda/hda_codec.c: In function `snd_hda_mixer_amp_switch_put=C2=
=B4:
sound/pci/hda/patch_realtek.c:4176:2: warning: statement with no effect
sound/pci/hda/hda_codec.c:2320:2: warning: statement with no effect
sound/pci/hda/patch_realtek.c: In function `alc_resume=C2=B4:
sound/pci/hda/patch_realtek.c:4558:2: warning: statement with no effect
sound/pci/hda/patch_realtek.c: In function `alc269_resume=C2=B4:
sound/pci/hda/patch_realtek.c:14878:2: warning: statement with no effec=
t

Signed-off-by: Borislav Petkov <borislav.petkov@amd.com>
---
 sound/pci/hda/hda_codec.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 59c9730..79ede92 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -1005,8 +1005,12 @@ int hda_call_check_power_status(struct hda_codec=
 *codec, hda_nid_t nid)
 		return codec->patch_ops.check_power_status(codec, nid);
 	return 0;
 }
-#else=09
-#define hda_call_check_power_status(codec, nid)		0
+#else
+static inline
+int hda_call_check_power_status(struct hda_codec *codec, hda_nid_t nid=
)
+{
+	return 0;
+}
 #endif
=20
 /*
--=20
1.7.4.rc2
