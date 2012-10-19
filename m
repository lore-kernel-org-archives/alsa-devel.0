From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 8/9] ALSA: hdspm - Fix typo in kcontrol element
	on RME MADI cards
Date: Fri, 19 Oct 2012 17:42:29 +0200
Message-ID: <1350661350-5000-9-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1350661350-5000-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1350661350-5000-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, andre.schramm@iosono-sound.com
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index e327484..4bc65ab 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -4471,7 +4471,7 @@ static struct snd_kcontrol_new snd_hdspm_controls_madi[] = {
 	HDSPM_AUTOSYNC_SAMPLE_RATE("External Rate", 0),
 	HDSPM_SYNC_CHECK("WC SyncCheck", 0),
 	HDSPM_SYNC_CHECK("MADI SyncCheck", 1),
-	HDSPM_SYNC_CHECK("TCO SyncCHeck", 2),
+	HDSPM_SYNC_CHECK("TCO SyncCheck", 2),
 	HDSPM_SYNC_CHECK("SYNC IN SyncCheck", 3),
 	HDSPM_LINE_OUT("Line Out", 0),
 	HDSPM_TX_64("TX 64 channels mode", 0),
-- 
1.7.10.4
