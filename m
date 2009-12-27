From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ALSA: test off by one in setsamplerate()
Date: Sun, 27 Dec 2009 22:26:47 +0100
Message-ID: <4B37D117.3000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f212.google.com (mail-ew0-f212.google.com
	[209.85.219.212])
	by alsa0.perex.cz (Postfix) with ESMTP id B97082452D
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 22:23:54 +0100 (CET)
Received: by ewy4 with SMTP id 4so39298375ewy.32
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 13:23:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

With `while (i++ < MAX_WRITE_RETRY)' i reaches MAX_WRITE_RETRY + 1 after the loop

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 sound/pci/riptide/riptide.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index b5ca02e..e66ef2b 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1058,7 +1058,7 @@ setsamplerate(struct cmdif *cif, unsigned char *intdec, unsigned int rate)
 				 rptr.retwords[2] != M &&
 				 rptr.retwords[3] != N &&
 				 i++ < MAX_WRITE_RETRY);
-			if (i == MAX_WRITE_RETRY) {
+			if (i > MAX_WRITE_RETRY) {
 				snd_printdd("sent samplerate %d: %d failed\n",
 					    *intdec, rate);
 				return -EIO;
