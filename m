From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/3] ALSA: hdspm - Fix jumping external
	wordclock frequency in AutoSync mode
Date: Sun, 12 Jun 2011 17:26:18 +0200
Message-ID: <1307892379-31179-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1307892379-31179-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1307892379-31179-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When using Word Clock on RME MADI cards, AutoSync mode was alternating
betweeen MADI and WC due to a typo: AutoSync is indicated in the second
status register (status2), not the first one (status).

While the proc output was always correct, the reported WC frequency to
ALSA was unstable as mentioned in

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006723.html

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 32d80af..d03ef94 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1143,7 +1143,7 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 
 		/* if wordclock has synced freq and wordclock is valid */
 		if ((status2 & HDSPM_wcLock) != 0 &&
-				(status & HDSPM_SelSyncRef0) == 0) {
+				(status2 & HDSPM_SelSyncRef0) == 0) {
 
 			rate_bits = status2 & HDSPM_wcFreqMask;
 
-- 
1.7.5.4
