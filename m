From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: [PATCH] ALSA: hda - Make path_has_mixer() tristate
Date: Tue, 03 Mar 2015 12:20:02 +0100
Message-ID: <54f5995b.6dd0d757.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CA8B2606F4
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

... in order to distinguish whether there is no ctl or no path at all.

It is used as !path_has_mixer() which means that it is true even if
there is no path at all. For headphone or speaker outs without path,
because they don't have a DAC assign to them, this would give a false
positive result.

Signed-off-by: Ingo Br=FCckl <ib@wupperonline.de>

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b680b4e..ecee349 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1035,11 +1035,11 @@ static int hda_gen_bind_mute_put(struct snd_kcontro=
l *kcontrol,
 	return snd_hda_mixer_bind_switch_put(kcontrol, ucontrol);
 }

-/* any ctl assigned to the path with the given index? */
-static bool path_has_mixer(struct hda_codec *codec, int path_idx, int ctl_=
type)
+/* any ctl assigned to the path (if one at all) with the given index? */
+static int path_has_mixer(struct hda_codec *codec, int path_idx, int ctl_t=
ype)
 {
 	struct nid_path *path =3D snd_hda_get_path_from_idx(codec, path_idx);
-	return path && path->ctls[ctl_type];
+	return path ? path->ctls[ctl_type] : -1;
 }

 static const char * const channel_name[4] =3D {
--
1.7.10
