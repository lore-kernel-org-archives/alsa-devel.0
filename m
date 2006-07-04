From: Arjan van de Ven <arjan@infradead.org>
Subject: [patch] fix AB-BA deadlock inversion at
	cs46xx_dsp_remove_scb
Date: Tue, 04 Jul 2006 11:35:20 +0200
Message-ID: <1152005720.3109.30.camel@laptopd505.fenrus.org>
References: <200607041115.35997.duncan.sands@math.u-psud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 873671A7
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Jul 2006 11:35:28 +0200 (MEST)
In-Reply-To: <200607041115.35997.duncan.sands@math.u-psud.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: akpm@osdl.org, alsa-devel@alsa-project.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-07-04 at 11:15 +0200, Duncan Sands wrote:
> Linux version 2.6.17-git22 (duncan@baldrick) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #20 PREEMPT Tue Jul 4 10:35:04 CEST 2006
> 
> 
> [  612.924372] =========================================================
> [  612.948112] [ INFO: possible irq lock inversion dependency detected ]
> [  612.967383] ---------------------------------------------------------
> [  612.986657] aplay/5128 just changed the state of lock:
> [  613.002034]  (&ins->scbs[index].lock){-...}, at: [<e099f95e>] cs46xx_dsp_remove_scb+0x1e/0xca [snd_cs46xx]
> [  613.031150] but this lock was taken by another, hard-irq-safe lock in the past:
> [  613.053019]  (&substream->self_group.lock){+...}
> [  613.066369]
> [  613.066371] and interrupts could create inverse lock ordering between them.
> [  613.066374]


ok so there is a code sequence where the locking is
substream->self_group.lock -> ins->scbs[index].lock

substream->self_group.lock is interrupt safe, and taken from irq context
as well (trace is snipped for brevity)

so what can happen is

cpu 0                   	cpu 1								
user context			user context

				take ins->scbs[index].lock without disabling interrupts
											
get substream->self_group.lock (irqsafe)
try to get ins->scbs[index].lock (spins)

				interrupt happens
				try to get substream->self_group.lock (spins)
		

which is an obvious AB-BA deadlock

fix is to just take the lock with _irqsafe

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 sound/pci/cs46xx/dsp_spos_scb_lib.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.17-mm4/sound/pci/cs46xx/dsp_spos_scb_lib.c
===================================================================
--- linux-2.6.17-mm4.orig/sound/pci/cs46xx/dsp_spos_scb_lib.c
+++ linux-2.6.17-mm4/sound/pci/cs46xx/dsp_spos_scb_lib.c
@@ -180,6 +180,7 @@ static void _dsp_clear_sample_buffer (st
 void cs46xx_dsp_remove_scb (struct snd_cs46xx *chip, struct dsp_scb_descriptor * scb)
 {
 	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
+	unsignded long flags;
 
 	/* check integrety */
 	snd_assert ( (scb->index >= 0 && 
@@ -194,9 +195,9 @@ void cs46xx_dsp_remove_scb (struct snd_c
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
