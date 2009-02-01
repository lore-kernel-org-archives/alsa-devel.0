From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] msnd: add module description and license for
 the snd-msnd-lib
Date: Sun, 1 Feb 2009 21:13:15 +0100
Message-ID: <20090201211315.1b948350.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ADF51037F3
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 21:09:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The missing module license generates warning
during module loading.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/msnd/msnd.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/isa/msnd/msnd.c b/sound/isa/msnd/msnd.c
index 264e082..9064544 100644
--- a/sound/isa/msnd/msnd.c
+++ b/sound/isa/msnd/msnd.c
@@ -700,3 +700,6 @@ int snd_msnd_pcm(struct snd_card *card, int device,
 }
 EXPORT_SYMBOL(snd_msnd_pcm);
 
+MODULE_DESCRIPTION("Common routines for Turtle Beach Multisound drivers");
+MODULE_LICENSE("GPL");
+
-- 
1.5.2.2


----------------------------------------------------------------------
Konkurs Walentynkowy! Wybierz nagrode i wygraj!
Sprawdz >>  http://link.interia.pl/f2039 
