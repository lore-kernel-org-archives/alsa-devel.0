From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: sparc: Mark expected switch fall-throughs
Date: Mon, 29 Jul 2019 20:49:44 -0500
Message-ID: <20190730014944.GA31900@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
List-Id: alsa-devel@alsa-project.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings (Building: sparc64):

sound/sparc/dbri.c: In function ‘reverse_bytes’:
sound/sparc/dbri.c:582:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
   b = ((b & 0xffff0000) >> 16) | ((b & 0x0000ffff) << 16);
   ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/sparc/dbri.c:583:2: note: here
  case 16:
  ^~~~
sound/sparc/dbri.c:584:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
   b = ((b & 0xff00ff00) >> 8) | ((b & 0x00ff00ff) << 8);
   ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/sparc/dbri.c:585:2: note: here
  case 8:
  ^~~~
sound/sparc/dbri.c:586:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
   b = ((b & 0xf0f0f0f0) >> 4) | ((b & 0x0f0f0f0f) << 4);
   ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/sparc/dbri.c:587:2: note: here
  case 4:
  ^~~~
sound/sparc/dbri.c:588:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
   b = ((b & 0xcccccccc) >> 2) | ((b & 0x33333333) << 2);
   ~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/sparc/dbri.c:589:2: note: here
  case 2:
  ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/sparc/dbri.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 010113156239..6e065d44060e 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -580,12 +580,16 @@ static __u32 reverse_bytes(__u32 b, int len)
 	switch (len) {
 	case 32:
 		b = ((b & 0xffff0000) >> 16) | ((b & 0x0000ffff) << 16);
+		/* fall through */
 	case 16:
 		b = ((b & 0xff00ff00) >> 8) | ((b & 0x00ff00ff) << 8);
+		/* fall through */
 	case 8:
 		b = ((b & 0xf0f0f0f0) >> 4) | ((b & 0x0f0f0f0f) << 4);
+		/* fall through */
 	case 4:
 		b = ((b & 0xcccccccc) >> 2) | ((b & 0x33333333) << 2);
+		/* fall through */
 	case 2:
 		b = ((b & 0xaaaaaaaa) >> 1) | ((b & 0x55555555) << 1);
 	case 1:
-- 
2.22.0
