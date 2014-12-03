From: Joe Perches <joe@perches.com>
Subject: [PATCH] ALSA: ctxfi: Neaten get_daio_rsc
Date: Wed, 03 Dec 2014 09:59:31 -0800
Message-ID: <1417629571.2902.16.camel@perches.com>
References: <5307CAA2.8060406@users.sourceforge.net>
	 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
	 <530A086E.8010901@users.sourceforge.net>
	 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
	 <530A72AA.3000601@users.sourceforge.net>
	 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
	 <530B5FB6.6010207@users.sourceforge.net>
	 <alpine.DEB.2.10.1402241710370.2074@hadrien>
	 <530C5E18.1020800@users.sourceforge.net>
	 <alpine.DEB.2.10.1402251014170.2080@hadrien>
	 <530CD2C4.4050903@users.sourceforge.net>
	 <alpine.DEB.2.10.1402251840450.7035@hadrien>
	 <530CF8FF.8080600@users.sourceforge.net>
	 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
	 <530DD06F.4090703@users.sourceforge.net>
	 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
	 <5317A59D.4@users.sourceforge.net> <547E2612.6010304@users.sourceforge.net>
	 <s5hvblt6xav.wl-tiwai@suse.de> <547EF64B.1080403@users.sourceforge.net>
	 <s5h61dssy5n.wl-tiwai@suse.de> <1417626888.2902.13.camel@perches.com>
	 <s5hh9xcr68v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hh9xcr68v.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

Move the pointer declarations into the blocks that use them.
Neaten the kfree calls when the _init functions fail.

Trivially reduces object size (defconfig x86-64)

$ size sound/pci/ctxfi/ctdaio.o.*
   text	   data	    bss	    dec	    hex	filename
   5287	    224	      0	   5511	   1587	sound/pci/ctxfi/ctdaio.o.new
   5319	    224	      0	   5543	   15a7	sound/pci/ctxfi/ctdaio.o.old

Signed-off-by: Joe Perches <joe@perches.com>
Noticed-by: Markus Elfring <elfring@users.sourceforge.net>
---
On Wed, 2014-12-03 at 18:30 +0100, Takashi Iwai wrote:
> At Wed, 03 Dec 2014 09:14:48 -0800, Joe Perches wrote:
> > On Wed, 2014-12-03 at 13:41 +0100, Takashi Iwai wrote:
> > Takashi, what did you think of this?
> > https://lkml.org/lkml/2014/12/2/771
> > 
> > Just unnecessary?
> 
> Well, this one looks more consistent.  But honestly speaking, it's
> rather a matter of taste.  So I'm not so much inclined to merge the
> stuff, too, sorry.  If it's proven to reduce the compiled size, etc,
> I'll happily apply it, though.

 sound/pci/ctxfi/ctdaio.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
index c1c3f88..9b87dd2 100644
--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -528,8 +528,6 @@ static int get_daio_rsc(struct daio_mgr *mgr,
 			struct daio **rdaio)
 {
 	int err;
-	struct dai *dai = NULL;
-	struct dao *dao = NULL;
 	unsigned long flags;
 
 	*rdaio = NULL;
@@ -544,27 +542,30 @@ static int get_daio_rsc(struct daio_mgr *mgr,
 		return err;
 	}
 
+	err = -ENOMEM;
 	/* Allocate mem for daio resource */
 	if (desc->type <= DAIO_OUT_MAX) {
-		dao = kzalloc(sizeof(*dao), GFP_KERNEL);
-		if (!dao) {
-			err = -ENOMEM;
+		struct dao *dao = kzalloc(sizeof(*dao), GFP_KERNEL);
+		if (!dao)
 			goto error;
-		}
+
 		err = dao_rsc_init(dao, desc, mgr);
-		if (err)
+		if (err) {
+			kfree(dao);
 			goto error;
+		}
 
 		*rdaio = &dao->daio;
 	} else {
-		dai = kzalloc(sizeof(*dai), GFP_KERNEL);
-		if (!dai) {
-			err = -ENOMEM;
+		struct dai *dai = kzalloc(sizeof(*dai), GFP_KERNEL);
+		if (!dai)
 			goto error;
-		}
+
 		err = dai_rsc_init(dai, desc, mgr);
-		if (err)
+		if (err) {
+			kfree(dai);
 			goto error;
+		}
 
 		*rdaio = &dai->daio;
 	}
@@ -575,11 +576,6 @@ static int get_daio_rsc(struct daio_mgr *mgr,
 	return 0;
 
 error:
-	if (dao)
-		kfree(dao);
-	else if (dai)
-		kfree(dai);
-
 	spin_lock_irqsave(&mgr->mgr_lock, flags);
 	daio_mgr_put_rsc(&mgr->mgr, desc->type);
 	spin_unlock_irqrestore(&mgr->mgr_lock, flags);
