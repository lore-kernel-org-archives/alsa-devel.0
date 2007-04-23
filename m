From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: [PATCH] PnP: Protocol for Media Vision
	Jazz16	sound cards
Date: Mon, 23 Apr 2007 20:52:21 +0200
Message-ID: <20070423185221.GA3157@sygehus.dk>
References: <20070412195523.GC5324@sygehus.dk> <4628F7FD.7000808@gmail.com>
	<20070420200007.GD3192@sygehus.dk> <462B8D00.8020305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 30AFE2488D
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2007 20:52:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <462B8D00.8020305@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Adam Belay <ambx1@neo.rr.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 22, 2007 at 06:27:44PM +0200, Rene Herman wrote:
> 
> The Intel 430TX and 440BX (which also uses the PIIX4 if I'm not mistaken) 
> were hugely popular chipsets in the later generation of boards that still 
> had ISA slots and given that noone will deperately want the MPU-401 IRQ 
> assigned; how would you feel about the attached? Just adds the preffered 
> options minus the MPU IRQ as the first acceptable. Works for me...

   Fine with me. Maybe the MPU IRQ should be omitted alltogether? You tell
me.

   Thanks for the testing you've done.

> As to the PnP part; other than that IRQ9 thing everything also working fine 

   Aren't you having problems loading the module after a resource allocation
failure? I find that I need this additional patch to be able to retry:

--- linux-2.6.20.6-clean/drivers/pnp/driver.c	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.20.6-ril/drivers/pnp/driver.c	2007-04-15 10:10:35.000000000 +0200
@@ -96,13 +96,13 @@
 		if (!(pnp_drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE)) {
 			error = pnp_activate_dev(pnp_dev);
 			if (error < 0)
-				return error;
+				goto fail;
 		}
 	} else if ((pnp_drv->flags & PNP_DRIVER_RES_DISABLE)
 		    == PNP_DRIVER_RES_DISABLE) {
 		error = pnp_disable_dev(pnp_dev);
 		if (error < 0)
-			return error;
+			goto fail;
 	}
 	error = 0;
 	if (pnp_drv->probe) {


   Without it, the device stays attached to the driver. What happens is

	pnp_attach_device (device, driver);
	error = pnp_activate_dev(device);
	if (error < 0)
		return error;
	...
fail:
	pnp_detach_device (device, driver);
	return error;

-- 
Rask Ingemann Lambertsen
