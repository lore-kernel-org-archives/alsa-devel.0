From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] ALSA: ctxfi: Deletion of an unnecessary check
 before the function call "kfree"
Date: Tue, 02 Dec 2014 13:07:44 -0800
Message-ID: <1417554464.2902.4.camel@perches.com>
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
	 <547E2738.1090708@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <547E2738.1090708@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-12-02 at 21:55 +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Dec 2014 20:00:33 +0100
> 
> The kfree() function performs also input parameter validation.
> Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  sound/pci/ctxfi/ctdaio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
> index c1c3f88..1712332 100644
> --- a/sound/pci/ctxfi/ctdaio.c
> +++ b/sound/pci/ctxfi/ctdaio.c
> @@ -577,7 +577,7 @@ static int get_daio_rsc(struct daio_mgr *mgr,
>  error:
>  	if (dao)
>  		kfree(dao);
> -	else if (dai)
> +	else
>  		kfree(dai);
>  
>  	spin_lock_irqsave(&mgr->mgr_lock, flags);

I think this not nice and would prefer something like:

---
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
