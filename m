From: Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] ALSA: ctxfi: Remove null check before kfree
Date: Thu, 31 Aug 2017 20:36:42 +0530
Message-ID: <1504192002-12105-1-git-send-email-himanshujha199640@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>
List-Id: alsa-devel@alsa-project.org

kfree on NULL pointer is a no-op and therefore checking is redundant.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 sound/pci/ctxfi/ctresource.c | 6 ++----
 sound/pci/ctxfi/ctsrc.c      | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/pci/ctxfi/ctresource.c b/sound/pci/ctxfi/ctresource.c
index c5124c3..80c4d84 100644
--- a/sound/pci/ctxfi/ctresource.c
+++ b/sound/pci/ctxfi/ctresource.c
@@ -258,10 +258,8 @@ int rsc_mgr_init(struct rsc_mgr *mgr, enum RSCTYP type,
 
 int rsc_mgr_uninit(struct rsc_mgr *mgr)
 {
-	if (NULL != mgr->rscs) {
-		kfree(mgr->rscs);
-		mgr->rscs = NULL;
-	}
+	kfree(mgr->rscs);
+	mgr->rscs = NULL;
 
 	if ((NULL != mgr->hw) && (NULL != mgr->ctrl_blk)) {
 		switch (mgr->type) {
diff --git a/sound/pci/ctxfi/ctsrc.c b/sound/pci/ctxfi/ctsrc.c
index a5a72df..bb4c9c3 100644
--- a/sound/pci/ctxfi/ctsrc.c
+++ b/sound/pci/ctxfi/ctsrc.c
@@ -702,10 +702,8 @@ static int srcimp_rsc_init(struct srcimp *srcimp,
 
 static int srcimp_rsc_uninit(struct srcimp *srcimp)
 {
-	if (NULL != srcimp->imappers) {
-		kfree(srcimp->imappers);
-		srcimp->imappers = NULL;
-	}
+	kfree(srcimp->imappers);
+	srcimp->imappers = NULL;
 	srcimp->ops = NULL;
 	srcimp->mgr = NULL;
 	rsc_uninit(&srcimp->rsc);
-- 
2.7.4
