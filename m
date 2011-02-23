From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 5/8] ALSA: hdspm - Remove input selector on
	MADIface
Date: Wed, 23 Feb 2011 11:43:12 +0100
Message-ID: <1298457795-28114-6-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

In contrast to the RME MADI card, coax/optical selection on the MADIface
is done via a physical switch located at the breakout box. Obviously,
the driver cannot switch ports in software.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 7246302..ea49ffe 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -4272,8 +4272,7 @@ static struct snd_kcontrol_new snd_hdspm_controls_madiface[] = {
 	HDSPM_SYNC_CHECK("MADI SyncCheck", 0),
 	HDSPM_TX_64("TX 64 channels mode", 0),
 	HDSPM_C_TMS("Clear Track Marker", 0),
-	HDSPM_SAFE_MODE("Safe Mode", 0),
-	HDSPM_INPUT_SELECT("Input Select", 0),
+	HDSPM_SAFE_MODE("Safe Mode", 0)
 };
 
 static struct snd_kcontrol_new snd_hdspm_controls_aio[] = {
-- 
1.7.2.3
