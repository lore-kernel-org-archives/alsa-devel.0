From: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: Re: [patch] fix AB-BA deadlock inversion at
	cs46xx_dsp_remove_scb
Date: Tue, 4 Jul 2006 12:03:14 +0200
Message-ID: <200607041203.15106.duncan.sands@math.u-psud.fr>
References: <200607041115.35997.duncan.sands@math.u-psud.fr>
	<1152005720.3109.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1CC521A7
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Jul 2006 12:03:37 +0200 (MEST)
In-Reply-To: <1152005720.3109.30.camel@laptopd505.fenrus.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, alsa-devel@alsa-project.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Yes, that fixes it.  However

> +	unsignded long flags;

should be "unsigned":

Index: Linux/sound/pci/cs46xx/dsp_spos_scb_lib.c
===================================================================
--- Linux.orig/sound/pci/cs46xx/dsp_spos_scb_lib.c	2006-07-04 10:09:05.778370000 +0200
+++ Linux/sound/pci/cs46xx/dsp_spos_scb_lib.c	2006-07-04 11:53:18.353662891 +0200
@@ -180,6 +180,7 @@
 void cs46xx_dsp_remove_scb (struct snd_cs46xx *chip, struct dsp_scb_descriptor * scb)
 {
 	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	unsigned long flags;
 
 	/* check integrety */
 	snd_assert ( (scb->index >= 0 && 
@@ -194,9 +195,9 @@
 		     goto _end);
 #endif
 
-	spin_lock(&scb->lock);
+	spin_lock_irqsave(&scb->lock, flags);
 	_dsp_unlink_scb (chip,scb);
-	spin_unlock(&scb->lock);
+	spin_unlock_irqrestore(&scb->lock, flags);
 
 	cs46xx_dsp_proc_free_scb_desc(scb);
 	snd_assert (scb->scb_symbol != NULL, return );

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
