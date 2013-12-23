From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: ssm2518: Fix off-by-one error by ffs()
Date: Mon, 23 Dec 2013 11:42:55 +0100
Message-ID: <1387795375-17083-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BA1626082D
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2013 11:42:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

ffs() returns the bit position from 1, while the ssm2158 driver code
assumes it being 0-based.  Also, the bit mask computation of the two
channel slots are incorrect; it must have worked just casually.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

I found it casully while checking ab8500 bug.
The patch is untested, so please review/test first, and give Cc to
stable if needed.

 sound/soc/codecs/ssm2518.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index 95aed552139a..cc8debce752f 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -549,13 +549,13 @@ static int ssm2518_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		right_slot = 0;
 	} else {
 		/* We assume the left channel < right channel */
-		left_slot = ffs(tx_mask);
-		tx_mask &= ~(1 << tx_mask);
+		left_slot = __ffs(tx_mask);
+		tx_mask &= ~(1 << left_slot);
 		if (tx_mask == 0) {
 			right_slot = left_slot;
 		} else {
-			right_slot = ffs(tx_mask);
-			tx_mask &= ~(1 << tx_mask);
+			right_slot = __ffs(tx_mask);
+			tx_mask &= ~(1 << right_slot);
 		}
 	}
 
-- 
1.8.5.2
