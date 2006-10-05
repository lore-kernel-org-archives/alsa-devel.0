From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH] ALSA: fix kernel panic in initialization
	of mpu401 driver
Date: Thu, 5 Oct 2006 11:57:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0610051155010.12556@twin.jikos.cz>
References: <Pine.LNX.4.64.0610042216240.12556@twin.jikos.cz>
	<Pine.LNX.4.61.0610050951570.9351@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from twin.jikos.cz (twin.jikos.cz [213.151.79.26])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 42F2E22E
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 11:57:45 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0610050951570.9351@tm8103.perex-int.cz>
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
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Castet Matthieu <castet.matthieu@free.fr>
List-Id: alsa-devel@alsa-project.org

On Thu, 5 Oct 2006, Jaroslav Kysela wrote:

> Unfortunately, I do not think that it's a proper solution. I think that 
> platform device layer should play more nicely and if probe() fails for a 
> reason and if platform_device_register_simple() does not set IS_ERR(), 
> then platform_device_unregister() must be callable to free all 
> resources.

I agree.

> I would reject this patch and fix drivers/base/bus.c. The problematic 
> change is in commit f2eaae197f4590c4d96f31b09b0ee9067421a95c and this 
> patch will probably fix it:
> [PATCH] drivers/base - check if device is registered before removal
> Without this fix platform_device_unregister() might oops.
> Signed-off-by: Jaroslav Kysela <perex@suse.cz>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 12173d1..daa2390 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -428,8 +428,10 @@ void bus_remove_device(struct device * d
>  		sysfs_remove_link(&dev->kobj, "bus");
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

Yes, it (among other things) fixes the panic in MPU401 initialization.

Acked-by: Jiri Kosina <jikos@jikos.cz>

-- 
Jiri Kosina

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
