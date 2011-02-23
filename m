From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 8/8] ALSA: hdspm - Fix lock/sync reporting on
	MADI and AES32
Date: Wed, 23 Feb 2011 11:43:15 +0100
Message-ID: <1298457795-28114-9-git-send-email-adi@drcomp.erfurt.thur.de>
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


Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index ced1406..5dbf620 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -3700,8 +3700,8 @@ static int hdspm_sync_in_sync_check(struct hdspm *hdspm)
 	case MADI:
 	case AES32:
 		status = hdspm_read(hdspm, HDSPM_statusRegister2);
-		lock = (status & 0x400000) ? 1 : 0;
-		sync = (status & 0x800000) ? 1 : 0;
+		lock = (status & HDSPM_syncInLock) ? 1 : 0;
+		sync = (status & HDSPM_syncInSync) ? 1 : 0;
 		break;
 
 	case MADIface:
-- 
1.7.2.3
