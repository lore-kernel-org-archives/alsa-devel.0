From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] refine rate selection in snd_interval_ratnum()
Date: Mon, 21 Dec 2009 17:07:08 +0100
Message-ID: <20091221170708.968b614a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 09E262412E
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 17:04:32 +0100 (CET)
Received: from poczta.interia.pl (mi06.poczta.interia.pl [10.217.12.6])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id 29A721068C4
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 17:04:30 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 680D913247A
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 17:04:29 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Refine the rate selection by choosing the rate
closer to the requested one in case of selecting
single frequency. Previously, the higher rate was
always selected.

Also, fix problem with the best_diff unsigned int
value wrapping (turning negative).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/core/pcm_lib.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a27545b..b07cc36 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -745,10 +745,13 @@ int snd_interval_ratnum(struct snd_interval *i,
 			unsigned int rats_count, struct snd_ratnum *rats,
 			unsigned int *nump, unsigned int *denp)
 {
-	unsigned int best_num, best_diff, best_den;
+	unsigned int best_num, best_den;
+	int best_diff;
 	unsigned int k;
 	struct snd_interval t;
 	int err;
+	unsigned int result_num, result_den;
+	int result_diff;
 
 	best_num = best_den = best_diff = 0;
 	for (k = 0; k < rats_count; ++k) {
@@ -770,6 +773,8 @@ int snd_interval_ratnum(struct snd_interval *i,
 				den -= r;
 		}
 		diff = num - q * den;
+		if (diff < 0)
+			diff = -diff;
 		if (best_num == 0 ||
 		    diff * best_den < best_diff * den) {
 			best_diff = diff;
@@ -784,6 +789,9 @@ int snd_interval_ratnum(struct snd_interval *i,
 	t.min = div_down(best_num, best_den);
 	t.openmin = !!(best_num % best_den);
 	
+	result_num = best_num;
+	result_diff = best_diff;
+	result_den = best_den;
 	best_num = best_den = best_diff = 0;
 	for (k = 0; k < rats_count; ++k) {
 		unsigned int num = rats[k].num;
@@ -806,6 +814,8 @@ int snd_interval_ratnum(struct snd_interval *i,
 				den += rats[k].den_step - r;
 		}
 		diff = q * den - num;
+		if (diff < 0)
+			diff = -diff;
 		if (best_num == 0 ||
 		    diff * best_den < best_diff * den) {
 			best_diff = diff;
@@ -825,10 +835,14 @@ int snd_interval_ratnum(struct snd_interval *i,
 		return err;
 
 	if (snd_interval_single(i)) {
+		if (best_diff * result_den < result_diff * best_den) {
+			result_num = best_num;
+			result_den = best_den;
+		}
 		if (nump)
-			*nump = best_num;
+			*nump = result_num;
 		if (denp)
-			*denp = best_den;
+			*denp = result_den;
 	}
 	return err;
 }
-- 
1.6.4


----------------------------------------------------------------------
Milosc, praca, pieniadze.
Sprawdz swoj horoskop na dzis >> http://link.interia.pl/f2531
