From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/10] ALSA: riptide: Fix PCM format type
	conversion
Date: Wed, 25 Jul 2018 23:19:37 +0200
Message-ID: <20180725211945.19222-3-tiwai@suse.de>
References: <20180725211945.19222-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D81926775C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:19:54 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B325FB082
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:19:53 +0000 (UTC)
In-Reply-To: <20180725211945.19222-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

The PCM format type is with __bitwise, hence it needs to be explicitly
declared as snd_pcm_format_t, as warned by sparse:
  sound/pci/riptide/riptide.c:1028:34: warning: incorrect type in argument 1 (different base types)
  sound/pci/riptide/riptide.c:1028:34:    expected restricted snd_pcm_format_t [usertype] format
  sound/pci/riptide/riptide.c:1028:34:    got unsigned char [unsigned] format

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/riptide/riptide.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 44f3b48d47b1..9d2b2ef15c6b 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1017,7 +1017,7 @@ getsamplerate(struct cmdif *cif, unsigned char *intdec, unsigned int *rate)
 static int
 setsampleformat(struct cmdif *cif,
 		unsigned char mixer, unsigned char id,
-		unsigned char channels, unsigned char format)
+		unsigned char channels, snd_pcm_format_t format)
 {
 	unsigned char w, ch, sig, order;
 
-- 
2.18.0
