From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/1] ALSA: hdspm - Work around broken DDS value
	on PCI RME MADI
Date: Wed, 30 May 2012 14:23:18 +0200
Message-ID: <1338380598-7434-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

On PCI RME MADI cards, the PLL register does not contain the proper
value, so the calculated system_sample_rate is wrong. In this case, we
simply return the cached rate from struct hdspm.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index f27a98e..f3cf8d0 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1988,6 +1988,13 @@ static int hdspm_get_system_sample_rate(struct hdspm *hdspm)
 	period = hdspm_read(hdspm, HDSPM_RD_PLL_FREQ);
 	rate = hdspm_calc_dds_value(hdspm, period);
 
+	if (rate > 207000) {
+		/* Unreasonable high sample rate as seen on PCI MADI cards.
+		 * Use the cached value instead.
+		 */
+		rate = hdspm->system_sample_rate;
+	}
+
 	return rate;
 }
 
-- 
1.7.10
