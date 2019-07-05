From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: cs4281: remove redundant assignment to variable val and remove a goto
Date: Fri,  5 Jul 2019 10:57:04 +0100
Message-ID: <20190705095704.26050-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The variable val is being assigned with a value that is never
read and it is being updated later with a new value. The
assignment is redundant and can be removed.  Also remove a
goto statement and a label and replace with a break statement.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/cs4281.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index a2cce3ecda6f..04c712647853 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -694,7 +694,7 @@ static int snd_cs4281_trigger(struct snd_pcm_substream *substream, int cmd)
 
 static unsigned int snd_cs4281_rate(unsigned int rate, unsigned int *real_rate)
 {
-	unsigned int val = ~0;
+	unsigned int val;
 	
 	if (real_rate)
 		*real_rate = rate;
@@ -707,9 +707,8 @@ static unsigned int snd_cs4281_rate(unsigned int rate, unsigned int *real_rate)
 	case 44100:	return 1;
 	case 48000:	return 0;
 	default:
-		goto __variable;
+		break;
 	}
-      __variable:
 	val = 1536000 / rate;
 	if (real_rate)
 		*real_rate = 1536000 / val;
-- 
2.20.1
