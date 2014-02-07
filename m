From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 1/3] sound: Include appropriate header file in
 pcsp/pcsp_input.c
Date: Fri, 7 Feb 2014 22:11:53 +0530
Message-ID: <512472c7d96cf1c239ba3d0bc517891a7c2f9da1.1391791103.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rashika Kheria <rashika.kheria@gmail.com>, alsa-devel@alsa-project.org, josh@joshtriplett.org
List-Id: alsa-devel@alsa-project.org

Include appropriate header file in drivers/pcsp/pcsp_input.c because it
defines function whose prototype definitions are present in
drivers/pcsp/pcsp_input.h.

This eliminates the following warning in drivers/pcsp/pcsp_input.c:
sound/drivers/pcsp/pcsp_input.c:42:6: warning: no previous prototype fo=
r =E2=80=98pcspkr_stop_sound=E2=80=99 [-Wmissing-prototypes]
sound/drivers/pcsp/pcsp_input.c:80:5: warning: no previous prototype fo=
r =E2=80=98pcspkr_input_init=E2=80=99 [-Wmissing-prototypes]
sound/drivers/pcsp/pcsp_input.c:110:5: warning: no previous prototype f=
or =E2=80=98pcspkr_input_remove=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 sound/drivers/pcsp/pcsp_input.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/drivers/pcsp/pcsp_input.c b/sound/drivers/pcsp/pcsp_=
input.c
index b874b0a..0ecf8a4 100644
--- a/sound/drivers/pcsp/pcsp_input.c
+++ b/sound/drivers/pcsp/pcsp_input.c
@@ -16,6 +16,7 @@
 #include <linux/input.h>
 #include <asm/io.h>
 #include "pcsp.h"
+#include "pcsp_input.h"
=20
 static void pcspkr_do_sound(unsigned int count)
 {
--=20
1.7.9.5
