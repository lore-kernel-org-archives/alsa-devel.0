From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] ALSA: fix kernel panic in initialization
	of mpu401 driver
Date: Thu, 5 Oct 2006 10:58:52 -0700
Message-ID: <20061005175852.GC15180@suse.de>
References: <Pine.LNX.4.44L0.0610050959330.6226-100000@iolanthe.rowland.org>
	<Pine.LNX.4.61.0610051614220.9351@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 381DA170
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 20:48:44 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610051614220.9351@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>, Alan Stern <stern@rowland.harvard.edu>, Castet Matthieu <castet.matthieu@free.fr>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 05, 2006 at 04:16:01PM +0200, Jaroslav Kysela wrote:
> On Thu, 5 Oct 2006, Alan Stern wrote:
> 
> > On Thu, 5 Oct 2006, Jaroslav Kysela wrote:
> > 
> > > On Wed, 4 Oct 2006, Jiri Kosina wrote:
> > > 
> > > > I am getting kernel panic (NULL pointer dereference) on boot, with kernel 
> > > > compiled with CONFIG_SND_MPU401_UART=y, on machine which does not have 
> > > > this piece of hardware.
> > > > 
> > > > I have traced the problem down to 
> > > > sound/drivers/mpu401/mpu401.c:snd_mpu401_probe() returning EINVAL, when 
> > > > either port or IRQ parameters are not specified.
> > > > 
> > > > In such case, the drivers/base/bus.c:bus_attach_device() does not perform 
> > > > klist_add_tail() call, but rather sets dev->is_registered to 0. This flag 
> > > > is however not checked by the driver, so later on, when 
> > > > alsa_card_mpu401_init() is called and platform_device_register_simple() 
> > > > fails, the following callchain happens, causing NULL pointer dereference: 
> > > > alsa_card_mpu401_init() -> platform_device_unregister() -> 
> > > > platform_device_del() -> device_del() -> bus_remove_device() -> 
> > > > klist_del() -> BOOM (the entry was not added to klist in 
> > > > bus_attach_device()).
> > > > 
> > > > Proper solution is returning ENODEV from the ->probe() routine, which will 
> > > > be correctly handled then by the rest of the device-driver attaching 
> > > > subsystem (namely the retval check in bus_attach_device()). The following 
> > > > patch fixes the problem, please apply.
> > > 
> > > Unfortunately, I do not think that it's a proper solution. I think that
> > > platform device layer should play more nicely and if probe() fails for 
> > > a reason and if platform_device_register_simple() does not set 
> > > IS_ERR(), then platform_device_unregister() must be callable to free
> > > all resources.
> > > 
> > > Also, you've proposed to not fix all returns in snd_mpu401_probe() only 
> > > first two.
> > > 
> > > I would reject this patch and fix drivers/base/bus.c. The problematic 
> > > change is in commit f2eaae197f4590c4d96f31b09b0ee9067421a95c and this 
> > > patch will probably fix it:
> > 
> > Your patch is right as far as it goes, but it misses part of the problem.  
> > device_add() shouldn't ignore the return value from bus_attach_device().  
> > That's why we ended up trying to unregister a device which never was 
> > properly registered in the first place.
> > 
> > What do you think of this addition to your patch (untested)?
> 
> Your addition looks good. Acked from me.

Great, Alan, care to resend with a better description and the proper
signed-off-by lines?

thanks,

greg k-h

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
