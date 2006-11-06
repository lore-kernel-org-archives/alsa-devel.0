From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] Stop Apple i2s DMA gracefully
Date: Mon, 6 Nov 2006 21:41:21 +1100
Message-ID: <17743.4433.435455.686127@cargo.ozlabs.ibm.com>
References: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
	<1162456168.3241.2.camel@ux156>
	<17738.26872.275355.217147@cargo.ozlabs.ibm.com>
	<1162508394.3381.4.camel@johannes.berg>
	<s5hy7qosvv6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B2C8B23C
	for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2006 11:41:30 +0100 (MET)
In-Reply-To: <s5hy7qosvv6.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, alsa-devel@alsa-project.org, benjamin@sipsolutions.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai writes:

> The trigger callback cannot sleep in design.  It's always atomic.
> 
> Usually, the driver calls snd_pcm_suspend_all() in suspend callback,
> which triggers with SNDRV_PCM_TRIGGER_SUSPEND.  In your case, this
> should terminate the DMA while SNDRV_PCM_TRIGGER_STOP continues the
> DMA.  Or, put a sync call after snd_pcm_suspend_all() in the suspend
> callback.

OK, this sounds like the suspend trigger should just abort the DMA, on
the basis that the hardware will get reset in the suspend/resume
process and so there will be no bytes queued up to cause trouble
later.  I'll whip up a patch.

Paul.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
