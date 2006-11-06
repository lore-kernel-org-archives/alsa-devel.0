From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH] Stop Apple i2s DMA gracefully
Date: Mon, 06 Nov 2006 11:47:39 +0100
Message-ID: <1162810059.2762.14.camel@ux156>
References: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
	<1162456168.3241.2.camel@ux156>
	<17738.26872.275355.217147@cargo.ozlabs.ibm.com>
	<1162508394.3381.4.camel@johannes.berg> <s5hy7qosvv6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 993D1242
	for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2006 11:46:39 +0100 (MET)
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
Cc: alsa-devel@alsa-project.org, Paul Mackerras <paulus@samba.org>, benjamin@sipsolutions.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-11-06 at 11:38 +0100, Takashi Iwai wrote:

> The trigger callback cannot sleep in design.  It's always atomic.

Alright.

> Usually, the driver calls snd_pcm_suspend_all() in suspend callback,
> which triggers with SNDRV_PCM_TRIGGER_SUSPEND.  In your case, this
> should terminate the DMA while SNDRV_PCM_TRIGGER_STOP continues the
> DMA.  Or, put a sync call after snd_pcm_suspend_all() in the suspend
> callback.

Yeah, I think the latter is preferable.

> The implementation of resume depends on the hardware, BTW.
> In short, there is no snd_pcm_resume*() function.

Ok.

> If your hardware supports the real resume (i.e. can restart the stream
> as it was), set SNDRV_PCM_INFO_RESUME flag in snd_pcm_hardware info
> field, and do the right thing in resume callback.
> If not (in many cases), the usual reset procedure is done (prepare,
> trigger-start), so the resume callback doesn't have to do any special
> thing about PCM. SNDRV_PCM_TRIGGER_SUSPEND should be handled just like
> a normal STOP trigger, in such a case.

We can restart the stream as it was by just rewriting the dbdma command
register to point it where we were during suspend, since the dma command
ring will have been kept intact in memory over suspend. Hence, I think
we can actually support SNDRV_PCM_INFO_RESUME easily by doing the
regular stop, storing the command pointer, and starting back where we
were by reprogramming the dma engine properly.

However, this would also require reprogramming the i2s chip to the
correct format etc, so it will be a lot easier to just do the regular
prepare sequence.

Thanks,
johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
