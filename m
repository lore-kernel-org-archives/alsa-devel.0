From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] Driver core: Don't ignore error returns from
	probing
Date: Thu, 5 Oct 2006 17:03:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0610051656290.7144-100000@iolanthe.rowland.org>
References: <20061005175852.GC15180@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E45D7171
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 23:03:26 +0200 (MEST)
In-Reply-To: <20061005175852.GC15180@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>, Castet Matthieu <castet.matthieu@free.fr>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

This patch (as797) fixes device_add() in the driver core.  It needs to
pay attention when the driver for a new device reports an error.

At the same time, since bus_remove_device() undoes the effects of both
bus_add_device() and bus_attach_device(), it needs to check whether
the bus_attach_device step failed.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

On Thu, 5 Oct 2006, Greg KH wrote:

> Great, Alan, care to resend with a better description and the proper
> signed-off-by lines?

Here it is.  Mind you, I still haven't tested it.  And the way the code
was written originally makes me wonder if the probe error wasn't
deliberately ignored.  Although if it was deliberate, there ought to have
been a comment explaining things.

Anyway, the change to bus.c is exactly the same as Jaroslav's patch, and
it is obviously correct.


Index: 18g20/drivers/base/bus.c
===================================================================
--- 18g20.orig/drivers/base/bus.c
+++ 18g20/drivers/base/bus.c
@@ -453,8 +453,10 @@ void bus_remove_device(struct device * d
 		remove_deprecated_bus_links(dev);
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
-		dev->is_registered = 0;
-		klist_del(&dev->knode_bus);
+		if (dev->is_registered) {
+			dev->is_registered = 0;
+			klist_del(&dev->knode_bus);
+		}
 		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
 		put_bus(dev->bus);
Index: 18g20/drivers/base/core.c
===================================================================
--- 18g20.orig/drivers/base/core.c
+++ 18g20/drivers/base/core.c
@@ -485,7 +485,8 @@ int device_add(struct device *dev)
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
-	bus_attach_device(dev);
+	if ((error = bus_attach_device(dev)))
+		goto AttachError;
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
@@ -504,6 +505,8 @@ int device_add(struct device *dev)
  	kfree(class_name);
 	put_device(dev);
 	return error;
+ AttachError:
+	bus_remove_device(dev);
  BusError:
 	device_pm_remove(dev);
  PMError:



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
