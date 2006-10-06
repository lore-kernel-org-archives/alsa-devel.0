From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] Driver core: Don't ignore error returns
	from probing
Date: Fri, 6 Oct 2006 09:53:34 +0200
Message-ID: <20061006095334.3cdebcc0@gondolin.boeblingen.de.ibm.com>
References: <20061005175852.GC15180@suse.de>
	<Pine.LNX.4.44L0.0610051656290.7144-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 19251178
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 09:53:02 +0200 (MEST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id k967r0ds189180
	for <alsa-devel@alsa-project.org>; Fri, 6 Oct 2006 07:53:00 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k967tD6U2617570
	for <alsa-devel@alsa-project.org>; Fri, 6 Oct 2006 09:55:13 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k967r0bL019896
	for <alsa-devel@alsa-project.org>; Fri, 6 Oct 2006 09:53:00 +0200
In-Reply-To: <Pine.LNX.4.44L0.0610051656290.7144-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>, Castet Matthieu <castet.matthieu@free.fr>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Thu, 5 Oct 2006 17:03:24 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> Index: 18g20/drivers/base/bus.c
> ===================================================================
> --- 18g20.orig/drivers/base/bus.c
> +++ 18g20/drivers/base/bus.c
> @@ -453,8 +453,10 @@ void bus_remove_device(struct device * d
>  		remove_deprecated_bus_links(dev);
>  		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
>  		device_remove_attrs(dev->bus, dev);
> -		dev->is_registered = 0;
> -		klist_del(&dev->knode_bus);
> +		if (dev->is_registered) {
> +			dev->is_registered = 0;
> +			klist_del(&dev->knode_bus);
> +		}
>  		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
>  		device_release_driver(dev);
>  		put_bus(dev->bus);
> Index: 18g20/drivers/base/core.c
> ===================================================================
> --- 18g20.orig/drivers/base/core.c
> +++ 18g20/drivers/base/core.c
> @@ -485,7 +485,8 @@ int device_add(struct device *dev)
>  	if ((error = bus_add_device(dev)))
>  		goto BusError;
>  	kobject_uevent(&dev->kobj, KOBJ_ADD);
> -	bus_attach_device(dev);
> +	if ((error = bus_attach_device(dev)))
> +		goto AttachError;
>  	if (parent)
>  		klist_add_tail(&dev->knode_parent, &parent->klist_children);
>  
> @@ -504,6 +505,8 @@ int device_add(struct device *dev)
>   	kfree(class_name);
>  	put_device(dev);
>  	return error;
> + AttachError:
> +	bus_remove_device(dev);
>   BusError:
>  	device_pm_remove(dev);
>   PMError:

Hm, I don't think we should call device_release_driver if
bus_attach_device failed (and I think calling bus_remove_device if
bus_attach_device failed is unintuitive). I did a patch that added a
function which undid just the things bus_add_device did (here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115816560424389&w=2),
which unfortunately got lost somewhere... (I'll rebase and resend.)

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
