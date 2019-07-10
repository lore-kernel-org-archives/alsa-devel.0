From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] sound: ppc: snd_ps3: Remove Unneeded variable: "ret"
Date: Wed, 10 Jul 2019 08:09:46 +0530
Message-ID: <20190710023946.GA15604@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Geoff Levand <geoff@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes below issue reported by coccicheck
sound/ppc/snd_ps3.c:631:5-8: Unneeded variable: "ret". Return "0" on
line 668

We cannot change return type of snd_ps3_pcm_trigger as it is registered
with snd_pcm_ops->trigger

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/ppc/snd_ps3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 71b7fd3..c213eb7 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -628,7 +628,6 @@ static int snd_ps3_pcm_trigger(struct snd_pcm_substream *substream,
 			       int cmd)
 {
 	struct snd_ps3_card_info *card = snd_pcm_substream_chip(substream);
-	int ret = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -665,7 +664,7 @@ static int snd_ps3_pcm_trigger(struct snd_pcm_substream *substream,
 
 	}
 
-	return ret;
+	return 0;
 };
 
 /*
-- 
2.7.4
