From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH] ALSA: compress_driver.h: include sound/core.h explicitly
Date: Fri, 19 Dec 2014 11:38:30 +0000
Message-ID: <1418989110-10011-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Qais Yousef <qais.yousef@imgtec.com>, Vinod Koul <vinod.koul@intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

=46ixes the following compilation error:

   include/sound/compress_driver.h: In function =E2=80=98snd_compr_drai=
n_notify=E2=80=99:
   include/sound/compress_driver.h:177:2: error: implicit declaration o=
f function =E2=80=98snd_BUG_ON=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]
     if (snd_BUG_ON(!stream))

snd_BUG_ON() is defined in sound/core.h but the file is not included ex=
plicitly,
so include it.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org

---
 include/sound/compress_driver.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_d=
river.h
index 396e8f73670a..1e2531058b7e 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -27,6 +27,7 @@
=20
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <sound/core.h>
 #include <sound/compress_offload.h>
 #include <sound/asound.h>
 #include <sound/pcm.h>
--=20
2.1.0
