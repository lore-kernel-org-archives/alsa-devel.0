From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: [PATCH] ALSA: hda - Make slave strings more
	user-friendly
Date: Fri, 27 Feb 2015 20:03:50 +0100
Message-ID: <54f0bf96.2c66145e.bm001@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout8.wup.tal.de (mout8.wup.tal.de [195.8.233.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FDEE260A5B
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 20:06:03 +0100 (CET)
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
Cc: tiwai@suse.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

"Line Out" has been used throughout, so don't abbreviate.

Signed-off-by: Ingo Br=FCckl <ib@wupperonline.de>

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b680b4e..834730f 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1103,9 +1103,9 @@ static const char *get_line_out_pfx(struct hda_codec =
*codec, int ch,
 			if (hp_lo_shared && spk_lo_shared)
 				return spec->vmaster_mute.hook ? "PCM" : "Master";
 			if (hp_lo_shared)
-				return "Headphone+LO";
+				return "Headphone+Line Out";
 			if (spk_lo_shared)
-				return "Speaker+LO";
+				return "Speaker+Line Out";
 		}
 	}

@@ -4619,7 +4619,7 @@ static const char * const slave_pfxs[] =3D {
 	"CLFE", "Bass Speaker", "PCM",
 	"Speaker Front", "Speaker Surround", "Speaker CLFE", "Speaker Side",
 	"Headphone Front", "Headphone Surround", "Headphone CLFE",
-	"Headphone Side", "Headphone+LO", "Speaker+LO",
+	"Headphone Side", "Headphone+Line Out", "Speaker+Line Out",
 	NULL,
 };

--
1.7.10
