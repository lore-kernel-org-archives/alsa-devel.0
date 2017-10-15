From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: ens137x: remove redundant variable result
Date: Sun, 15 Oct 2017 22:16:45 +0100
Message-ID: <20171015211645.15826-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 09877266B69
 for <alsa-devel@alsa-project.org>; Sun, 15 Oct 2017 23:16:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Variable result is being assigned a value from a calculation
however the variable is never read, so this redundant variable
can be removed.

Cleans up clang warning: Value stored to 'result' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/ens1370.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index d4cd6451fdca..39f79a6b5283 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -732,7 +732,7 @@ static void snd_es1371_codec_wait(struct snd_ac97 *ac97)
 
 static void snd_es1371_adc_rate(struct ensoniq * ensoniq, unsigned int rate)
 {
-	unsigned int n, truncm, freq, result;
+	unsigned int n, truncm, freq;
 
 	mutex_lock(&ensoniq->src_mutex);
 	n = rate / 3000;
@@ -740,7 +740,6 @@ static void snd_es1371_adc_rate(struct ensoniq * ensoniq, unsigned int rate)
 		n--;
 	truncm = (21 * n - 1) | 1;
 	freq = ((48000UL << 15) / rate) * n;
-	result = (48000UL << 15) / (freq / n);
 	if (rate >= 24000) {
 		if (truncm > 239)
 			truncm = 239;
-- 
2.14.1
