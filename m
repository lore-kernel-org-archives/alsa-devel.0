From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/3] ALSA: hdspm - Allow SingleSpeed WordClock
	when in DS/QS mode
Date: Fri, 31 May 2013 12:57:11 +0200
Message-ID: <1369997831-7274-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1369997831-7274-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1369997831-7274-2-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1369997831-7274-2-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Similarly to MADI, WordClock can also be at SingleSpeed while the card
is actually working at twice or four times this rate. If so, multiply
the base rate accordingly.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 8eb2070..bd50193 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1225,7 +1225,7 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 		 */
 		if (rate != 0 &&
 		(status2 & HDSPM_SelSyncRefMask) == HDSPM_SelSyncRef_WORD)
-			return rate;
+			return hdspm_rate_multiplier(hdspm, rate);
 
 		/* maybe a madi input (which is taken if sel sync is madi) */
 		if (status & HDSPM_madiLock) {
-- 
1.7.10.4
