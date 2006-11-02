From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH] Stop Apple i2s DMA gracefully
Date: Thu, 02 Nov 2006 09:29:28 +0100
Message-ID: <1162456168.3241.2.camel@ux156>
References: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4A12B2F8
	for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2006 09:28:27 +0100 (MET)
In-Reply-To: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Paul Mackerras <paulus@samba.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, benjamin@sipsolutions.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-10-29 at 15:19 +1100, Paul Mackerras wrote:

>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  		if (!pi->dbdma_ring.running) {
>  			result = -EALREADY;
>  			goto out_unlock;
>  		}
> +		pi->dbdma_ring.running = 0;
>  
> -		/* turn off all relevant bits */
> -		out_le32(&pi->dbdma->control,
> -			 (RUN | WAKE | FLUSH | PAUSE) << 16);
> -		{
> -			/* FIXME: move to own function */
> -			int timeout = 5000;
> -			while ((in_le32(&pi->dbdma->status) & RUN)
> -			       && --timeout > 0)
> -				udelay(1);
> -			if (!timeout)
> -				printk(KERN_ERR
> -				       "i2sbus: timed out turning "
> -				       "off dbdma engine!\n");
> -		}
> +		/* Set the S0 bit to make the DMA branch to the stop cmd */
> +		out_le32(&pi->dbdma->control, (1 << 16) | 1);
> +		pi->dbdma_ring.stopping = 1;

Something that just crossed my mind because Ben was complaining about
suspend/resume breakage... In the suspend case we actually have to make
sure to have DMA stopped, no?

johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
