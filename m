From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: [PATCH] ALSA: hda - Fix wrong detection of
	"Headphone+LO" or "Speaker+LO"
Date: Tue, 03 Mar 2015 12:22:03 +0100
Message-ID: <54f5995b.7e5343ac.bm001@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F55C260851
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 12:25:02 +0100 (CET)
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
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Add the constraint mentioned in the comment.

It does not apply to a scenario with three DACs and multi-IO where we
would normally get a "Master Playback Volume" and a "Front Playback
Volume" (prevented without checking for num_dacs).

Signed-off-by: Ingo Br=FCckl <ib@wupperonline.de>

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index ecee349..4c8910c 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1097,7 +1097,7 @@ static const char *get_line_out_pfx(struct hda_codec =
*codec, int ch,
 	case AUTO_PIN_LINE_OUT:
 		/* This deals with the case where we have two DACs and
 		 * one LO, one HP and one Speaker */
-		if (!ch && cfg->speaker_outs && cfg->hp_outs) {
+		if (!ch && spec->multiout.num_dacs =3D=3D 2 && cfg->speaker_outs && cfg-=
>hp_outs) {
 			bool hp_lo_shared =3D !path_has_mixer(codec, spec->hp_paths[0], ctl_typ=
e);
 			bool spk_lo_shared =3D !path_has_mixer(codec, spec->speaker_paths[0], c=
tl_type);
 			if (hp_lo_shared && spk_lo_shared)
--
1.7.10
