From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 05/31] ALSA: hdspm - Add S/PDIF and WCK48
	controls for RME RayDAT
Date: Fri,  5 Jul 2013 11:27:57 +0200
Message-ID: <1373016503-9474-6-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
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

This commit adds new ALSA controls to send single-speed WordClock and
S/PDIF-Professional on RME RayDAT cards.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 631c546..4a3a822 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -4364,7 +4364,9 @@ static struct snd_kcontrol_new snd_hdspm_controls_raydat[] = {
 	HDSPM_AUTOSYNC_SAMPLE_RATE("ADAT3 Frequency", 5),
 	HDSPM_AUTOSYNC_SAMPLE_RATE("ADAT4 Frequency", 6),
 	HDSPM_AUTOSYNC_SAMPLE_RATE("TCO Frequency", 7),
-	HDSPM_AUTOSYNC_SAMPLE_RATE("SYNC IN Frequency", 8)
+	HDSPM_AUTOSYNC_SAMPLE_RATE("SYNC IN Frequency", 8),
+	HDSPM_TOGGLE_SETTING("S/PDIF Out Professional", HDSPM_c0_Pro),
+	HDSPM_TOGGLE_SETTING("Single Speed WordClock Out", HDSPM_c0_Wck48)
 };
 
 static struct snd_kcontrol_new snd_hdspm_controls_aes32[] = {
-- 
1.8.3.1
