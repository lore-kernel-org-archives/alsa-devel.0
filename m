From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ALSA: ctxfi: One function call less in get_daio_rsc()
 after error detection
Date: Tue, 02 Dec 2014 22:00:20 +0100
Message-ID: <547E2864.9080903@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net> <547E2612.6010304@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <547E2612.6010304@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Dec 2014 20:33:51 +0100

The kfree() function was called in two cases by the get_daio_rsc() function
during error handling even if the passed variable contained still
a null pointer. This implementation detail could be improved
by adjustments for jump labels.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/ctxfi/ctdaio.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
index 1712332..a12489e 100644
--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -549,22 +549,22 @@ static int get_daio_rsc(struct daio_mgr *mgr,
 		dao = kzalloc(sizeof(*dao), GFP_KERNEL);
 		if (!dao) {
 			err = -ENOMEM;
-			goto error;
+			goto alloc_error;
 		}
 		err = dao_rsc_init(dao, desc, mgr);
 		if (err)
-			goto error;
+			goto dao_init_error;
 
 		*rdaio = &dao->daio;
 	} else {
 		dai = kzalloc(sizeof(*dai), GFP_KERNEL);
 		if (!dai) {
 			err = -ENOMEM;
-			goto error;
+			goto alloc_error;
 		}
 		err = dai_rsc_init(dai, desc, mgr);
 		if (err)
-			goto error;
+			goto dai_init_error;
 
 		*rdaio = &dai->daio;
 	}
@@ -574,12 +574,12 @@ static int get_daio_rsc(struct daio_mgr *mgr,
 
 	return 0;
 
-error:
-	if (dao)
-		kfree(dao);
-	else
-		kfree(dai);
-
+dao_init_error:
+	kfree(dao);
+	goto alloc_error;
+dai_init_error:
+	kfree(dai);
+alloc_error:
 	spin_lock_irqsave(&mgr->mgr_lock, flags);
 	daio_mgr_put_rsc(&mgr->mgr, desc->type);
 	spin_unlock_irqrestore(&mgr->mgr_lock, flags);
-- 
2.1.3
