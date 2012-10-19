From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 7/9] ALSA: hdspm - Fix sync_in detection on
	AES/AES32
Date: Fri, 19 Oct 2012 17:42:28 +0200
Message-ID: <1350661350-5000-8-git-send-email-adi@drcomp.erfurt.thur.de>
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

According to the documentation, AES32 cards use a different bit position
for reporting the sync_in status.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 9c41661..e327484 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -3890,8 +3890,8 @@ static int hdspm_sync_in_sync_check(struct hdspm *hdspm)
 
 	case AES32:
 		status = hdspm_read(hdspm, HDSPM_statusRegister2);
-		lock = (status & HDSPM_syncInLock) ? 1 : 0;
-		sync = (status & HDSPM_syncInSync) ? 1 : 0;
+		lock = (status & 0x100000) ? 1 : 0;
+		sync = (status & 0x200000) ? 1 : 0;
 		break;
 
 	case MADIface:
-- 
1.7.10.4
