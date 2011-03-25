From: linux@audioscience.com
Subject: [PATCH 1/3] Support single-rate no-SRC cards.
Date: Fri, 25 Mar 2011 15:25:46 +1300
Message-ID: <1301019948-3539-1-git-send-email-linux@audioscience.com>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Cards without settable local samplerate and without SRC
still must have a valid samplerate.
This fixed rate is determined by reading the current rate for the card.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index 0ac1f98..22606e3 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -381,13 +381,13 @@ static void snd_card_asihpi_pcm_samplerates(struct snd_card_asihpi *asihpi,
 				"No local sampleclock, err %d\n", err);
 		}
 
-		for (idx = 0; idx < 100; idx++) {
-			if (hpi_sample_clock_query_local_rate(
-				h_control, idx, &sample_rate)) {
-				if (!idx)
-					snd_printk(KERN_ERR
-						"Local rate query failed\n");
-
+		for (idx = -1; idx < 100; idx++) {
+			if (idx == -1) {
+				if (hpi_sample_clock_get_sample_rate(h_control,
+								&sample_rate))
+					continue;
+			} else if (hpi_sample_clock_query_local_rate(h_control,
+							idx, &sample_rate)) {
 				break;
 			}
 
@@ -440,8 +440,6 @@ static void snd_card_asihpi_pcm_samplerates(struct snd_card_asihpi *asihpi,
 		}
 	}
 
-	/* printk(KERN_INFO "Supported rates %X %d %d\n",
-	   rates, rate_min, rate_max); */
 	pcmhw->rates = rates;
 	pcmhw->rate_min = rate_min;
 	pcmhw->rate_max = rate_max;
-- 
1.7.0.4
