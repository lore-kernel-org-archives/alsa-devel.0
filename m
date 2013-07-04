From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 02/11] ALSA: hdspm - Introduce
	hdspm_is_raydat_or_aio()
Date: Thu,  4 Jul 2013 15:16:29 +0200
Message-ID: <1372943796-18998-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1372943796-18998-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-2-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1372943796-18998-2-git-send-email-adi@drcomp.erfurt.thur.de>
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

RME RayDAT and AIO cards are new designs with different register
settings. Since we need to distinguish them from older cards multiple
times in the driver, refactor the code into a separate helper function.

No functional change intended.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index a0fc961..32a87dc 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1011,6 +1011,12 @@ static inline int HDSPM_bit2freq(int n)
 	return bit2freq_tab[n];
 }
 
+static bool hdspm_is_raydat_or_aio(struct hdspm *hdspm)
+{
+	return ((AIO == hdspm->io_type) || (RayDAT == hdspm->io_type));
+}
+
+
 /* Write/read to/from HDSPM with Adresses in Bytes
    not words but only 32Bit writes are allowed */
 
@@ -5142,9 +5148,8 @@ static int snd_hdspm_set_defaults(struct hdspm * hdspm)
 
 	all_in_all_mixer(hdspm, 0 * UNITY_GAIN);
 
-	if (hdspm->io_type == AIO || hdspm->io_type == RayDAT) {
+	if (hdspm_is_raydat_or_aio(hdspm))
 		hdspm_write(hdspm, HDSPM_WR_SETTINGS, hdspm->settings_register);
-	}
 
 	/* set a default rate so that the channel map is set up. */
 	hdspm_set_rate(hdspm, 48000, 1);
-- 
1.8.3.1
