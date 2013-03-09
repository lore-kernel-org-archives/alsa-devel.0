From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 7/7] ALSA: hdspm - Enable new TCO ALSA controls
Date: Sun, 10 Mar 2013 00:37:27 +0100
Message-ID: <1362872247-29029-8-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1362872247-29029-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-7-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1362872247-29029-7-git-send-email-adi@drcomp.erfurt.thur.de>
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

Expose the newly added TCO LTC and sync check functions to userspace.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index f5ef788..c3516ed 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -4363,7 +4363,11 @@ static struct snd_kcontrol_new snd_hdspm_controls_tco[] = {
 	HDSPM_TCO_WCK_CONVERSION("TCO WCK Conversion", 0),
 	HDSPM_TCO_FRAME_RATE("TCO Frame Rate", 0),
 	HDSPM_TCO_SYNC_SOURCE("TCO Sync Source", 0),
-	HDSPM_TCO_WORD_TERM("TCO Word Term", 0)
+	HDSPM_TCO_WORD_TERM("TCO Word Term", 0),
+	HDSPM_TCO_LOCK_CHECK("TCO Input Check", 11),
+	HDSPM_TCO_LOCK_CHECK("TCO LTC Valid", 12),
+	HDSPM_TCO_LTC_FRAMES("TCO Detected Frame Rate", 0),
+	HDSPM_TCO_VIDEO_INPUT_FORMAT("Video Input Format", 0)
 };
 
 
-- 
1.7.10.4
