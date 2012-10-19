From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 6/9] ALSA: hdspm - Fix sync_in reporting on RME
	MADI cards
Date: Fri, 19 Oct 2012 17:42:27 +0200
Message-ID: <1350661350-5000-7-git-send-email-adi@drcomp.erfurt.thur.de>
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

In contrast to AES32, MADI uses the first status register to report the
sync_in status.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 1a679e9..9c41661 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -3883,6 +3883,11 @@ static int hdspm_sync_in_sync_check(struct hdspm *hdspm)
 		break;
 
 	case MADI:
+		status = hdspm_read(hdspm, HDSPM_statusRegister);
+		lock = (status & HDSPM_syncInLock) ? 1 : 0;
+		sync = (status & HDSPM_syncInSync) ? 1 : 0;
+		break;
+
 	case AES32:
 		status = hdspm_read(hdspm, HDSPM_statusRegister2);
 		lock = (status & HDSPM_syncInLock) ? 1 : 0;
-- 
1.7.10.4
