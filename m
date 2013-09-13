From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] ALSA: ctxfi: Staticize local symbols
Date: Fri, 13 Sep 2013 15:14:21 +0530
Message-ID: <1379065462-1720-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 426B52608B7
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:02:33 +0200 (CEST)
Received: by mail-pa0-f52.google.com with SMTP id kq13so2324892pab.11
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 03:02:32 -0700 (PDT)
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

Local symbols used only in this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/pci/ctxfi/ctdaio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
index 0c00eb4..84f86bf 100644
--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -33,7 +33,7 @@ struct daio_rsc_idx {
 	unsigned short right;
 };
 
-struct daio_rsc_idx idx_20k1[NUM_DAIOTYP] = {
+static struct daio_rsc_idx idx_20k1[NUM_DAIOTYP] = {
 	[LINEO1] = {.left = 0x00, .right = 0x01},
 	[LINEO2] = {.left = 0x18, .right = 0x19},
 	[LINEO3] = {.left = 0x08, .right = 0x09},
@@ -44,7 +44,7 @@ struct daio_rsc_idx idx_20k1[NUM_DAIOTYP] = {
 	[SPDIFI1] = {.left = 0x95, .right = 0x9d},
 };
 
-struct daio_rsc_idx idx_20k2[NUM_DAIOTYP] = {
+static struct daio_rsc_idx idx_20k2[NUM_DAIOTYP] = {
 	[LINEO1] = {.left = 0x40, .right = 0x41},
 	[LINEO2] = {.left = 0x60, .right = 0x61},
 	[LINEO3] = {.left = 0x50, .right = 0x51},
-- 
1.7.9.5
