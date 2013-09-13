From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ALSA: rme9652: Remove redundant break
Date: Fri, 13 Sep 2013 16:18:59 +0530
Message-ID: <1379069339-2693-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id CBDCC2608ED
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 13:07:08 +0200 (CEST)
Received: by mail-pa0-f46.google.com with SMTP id fa1so2385868pad.5
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 04:07:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sachin.kamat@linaro.org
List-Id: alsa-devel@alsa-project.org

'break' after return statement is not necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/pci/rme9652/hdspm.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 3cde55b..2907e68 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -3996,7 +3996,6 @@ static int hdspm_tco_sync_check(struct hdspm *hdspm)
 					return 1;
 			}
 			return 0;
-			break;
 		case AES32:
 			status = hdspm_read(hdspm, HDSPM_statusRegister);
 			if (status & HDSPM_tcoLockAes) {
@@ -4006,9 +4005,6 @@ static int hdspm_tco_sync_check(struct hdspm *hdspm)
 					return 1;
 			}
 			return 0;
-
-			break;
-
 		case RayDAT:
 		case AIO:
 			status = hdspm_read(hdspm, HDSPM_RD_STATUS_1);
@@ -4018,7 +4014,6 @@ static int hdspm_tco_sync_check(struct hdspm *hdspm)
 			if (status & 0x4000000)
 				return 1; /* Lock */
 			return 0; /* No signal */
-			break;
 
 		default:
 			break;
-- 
1.7.9.5
