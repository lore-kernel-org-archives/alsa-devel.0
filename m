From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: delayed dma trigger
Date: Tue, 24 Oct 2006 17:13:04 +0200
Message-ID: <1161702784.2840.33.camel@ux156>
References: <1161593391.6617.25.camel@ux156> <s5hbqo317yo.wl%tiwai@suse.de>
	<1161611212.6617.53.camel@ux156> <s5h64eb15qs.wl%tiwai@suse.de>
	<1161613867.6617.64.camel@ux156>  <s5hbqo1pxaz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9995415C
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Oct 2006 17:12:04 +0200 (MEST)
In-Reply-To: <s5hbqo1pxaz.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Paul Mackerras <paulus@samba.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-10-24 at 17:07 +0200, Takashi Iwai wrote:

> It won't be called unless PCM_INFO_PAUSE bit flag is set.  It means
> that the driver doesn't support the hardware pause/resume function.
> The pseudo pause/resume is just like a stop -> reset -> start
> sequence.
> 
> In other words, once when you set SNDRV_PCM_INFO_PAUSE flag, the
> driver has to stop the stream by trigger(PAUSE_PUSH) and restart the
> stream by trigger(PAUSE_RELEASE) call without prepare callback.

Ok, then we can safely set that flag once we fix it as I outlined and if
someone does pause-release very quickly we won't pause at all. should be
fine.

Who wants to do the patch? :)

Many thanks,
Johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
