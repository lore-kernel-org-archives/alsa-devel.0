From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: 2.6.12-rc1-mm2
Date: Thu, 24 Mar 2005 17:00:18 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503241658360.29178-100000@monsoon.he.net>
References: <20050324044114.5aa5b166.akpm@osdl.org> <1111682812.23440.6.camel@mindpipe>
 <20050324121722.759610f4.akpm@osdl.org> <200503242331.46985.rjw@sisk.pl>
 <42434E59.2060805@free.fr> <20050324154920.4e506d76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20050324154920.4e506d76.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: Laurent Riffard <laurent.riffard@free.fr>, rjw@sisk.pl, rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: alsa-devel@alsa-project.org


On Thu, 24 Mar 2005, Andrew Morton wrote:

> Laurent Riffard <laurent.riffard@free.fr> wrote:
> >
> > hello,
> >
> > Same kinds of problem here. It depends on the removed module. I mean:
> > "rmmod loop" or "rmmod pcspkr" works. But "rmmod snd_ens1371" or "rmmod
> > ohci1394" hangs.
> >
> > Sysrq-T when rmmoding snd_ens1371 :

<snip>

> It looks like we're getting stuck in the wait_for_completion() in the new
> klist_remove().

D'oh! It's getting hung while waiting to remove the current node from the
list (which it can't remove because it's being used). The patch below
should fix it.


	Pat


===== drivers/base/dd.c 1.3 vs edited =====
--- 1.3/drivers/base/dd.c	2005-03-21 12:25:04 -08:00
+++ edited/drivers/base/dd.c	2005-03-24 16:55:21 -08:00
@@ -177,7 +177,7 @@

 	sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 	sysfs_remove_link(&dev->kobj, "driver");
-	klist_remove(&dev->knode_driver);
+	klist_del(&dev->knode_driver);

 	down(&dev->sem);
 	device_detach_shutdown(dev);


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
