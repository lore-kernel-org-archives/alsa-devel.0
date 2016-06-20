From: Helen Koike <helen.koike@collabora.co.uk>
Subject: [PATCH] ALSA: hda - Remove compilation warning
Date: Mon, 20 Jun 2016 16:42:31 -0300
Message-ID: <1466451751-8013-1-git-send-email-helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org, trivial@kernel.org
Cc: Helen Koike <helen.koike@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

Remove the warning:
warning: =E2=80=98err=E2=80=99 may be used uninitialized in this functi=
on [-Wmaybe-uninitialized]

Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
---
 sound/hda/hdac_regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 87041dd..7be6ca1 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -279,7 +279,7 @@ static int hda_reg_write(void *context, unsigned in=
t reg, unsigned int val)
 {
 	struct hdac_device *codec =3D context;
 	unsigned int verb;
-	int i, bytes, err;
+	int i, bytes, err =3D 0;
 	int pm_lock =3D 0;
=20
 	if (codec->caps_overwriting)
--=20
1.9.1
