From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 3/3] sound: Move prototype declaration to header file
 oss/pas2.h from oss/pas2_card.c
Date: Fri, 7 Feb 2014 22:16:31 +0530
Message-ID: <3c35e9b980ccc0ca155214e8fad0dae24b20c5af.1391791103.git.rashika.kheria@gmail.com>
References: <512472c7d96cf1c239ba3d0bc517891a7c2f9da1.1391791103.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <512472c7d96cf1c239ba3d0bc517891a7c2f9da1.1391791103.git.rashika.kheria@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rashika Kheria <rashika.kheria@gmail.com>, alsa-devel@alsa-project.org, josh@joshtriplett.org
List-Id: alsa-devel@alsa-project.org

Move prototype declaration of function to header file oss/pas2.h
from oss/pas2_card.c because it is used by more than one file.

This eliminates the following warnings in oss/pas2_mixer.c:
sound/oss/pas2_mixer.c:62:1: warning: no previous prototype for =E2=80=98=
mix_write=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 sound/oss/pas2.h      |    3 +++
 sound/oss/pas2_card.c |    2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/oss/pas2.h b/sound/oss/pas2.h
index fa12c55..d19f757 100644
--- a/sound/oss/pas2.h
+++ b/sound/oss/pas2.h
@@ -15,3 +15,6 @@ int pas_init_mixer(void);
 /*	From pas_midi.c */
 void pas_midi_init(void);
 void pas_midi_interrupt(void);
+
+/*	From pas2_mixer.c*/
+void mix_write(unsigned char data, int ioaddr);
diff --git a/sound/oss/pas2_card.c b/sound/oss/pas2_card.c
index 7004e24..b07954a 100644
--- a/sound/oss/pas2_card.c
+++ b/sound/oss/pas2_card.c
@@ -74,8 +74,6 @@ static char    *pas_model_names[] =3D {
  * to support other than the default base address
  */
=20
-extern void     mix_write(unsigned char data, int ioaddr);
-
 unsigned char pas_read(int ioaddr)
 {
 	return inb(ioaddr + pas_translate_code);
--=20
1.7.9.5
