From: Andrew Morton <akpm@osdl.org>
Subject: Re: bus_add_device() losing an error return from the probe() method
Date: Sat, 25 Mar 2006 17:53:22 -0800
Message-ID: <20060325175322.1e04852b.akpm__30368.9374625266$1143338295$gmane$org@osdl.org>
References: <44238489.8090402@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 571E31D4
	for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2006 03:57:06 +0200 (MEST)
In-Reply-To: <44238489.8090402@keyaccess.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: gregkh@suse.de, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Rene Herman <rene.herman@keyaccess.nl> wrote:
>
>  ===================================================================
>  --- local.orig/drivers/base/bus.c	2006-02-27 19:22:08.000000000 +0100
>  +++ local/drivers/base/bus.c	2006-03-24 04:27:02.000000000 +0100
>  @@ -363,19 +363,21 @@ static void device_remove_attrs(struct b
>   int bus_add_device(struct device * dev)
>   {
>   	struct bus_type * bus = get_bus(dev->bus);
>  -	int error = 0;
>  +	int error;
>   
>   	if (bus) {
>   		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
>  -		device_attach(dev);
>  +		error = device_attach(dev);
>  +		if (error < 0)
>  +			return error;
>   		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
>   		error = device_add_attrs(bus, dev);
>  -		if (!error) {
>  -			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
>  -			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
>  -		}
>  +		if (error)
>  +			return error;
>  +		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
>  +		sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
>   	}
>  -	return error;
>  +	return 0;
>   }
>   

Looks sane, but please don't sprinkle `return' statements all over a
function in this manner.


--- devel/drivers/base/bus.c~bus_add_device-losing-an-error-return-from-the-probe-method	2006-03-25 17:46:34.000000000 -0800
+++ devel-akpm/drivers/base/bus.c	2006-03-25 17:49:45.000000000 -0800
@@ -372,14 +372,17 @@ int bus_add_device(struct device * dev)
 
 	if (bus) {
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
-		device_attach(dev);
+		error = device_attach(dev);
+		if (error < 0)
+			goto out;
 		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
 		error = device_add_attrs(bus, dev);
-		if (!error) {
-			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
-			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
-		}
+		if (error)
+			goto out;
+		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
+		sysfs_create_link(&dev->kobj,&dev->bus->subsys.kset.kobj,"bus");
 	}
+out:
 	return error;
 }
 

It's a little surprising that this function returns "OK" if bus==NULL.

Note that sysfs_create_link() can fail too.  This was one optimistic
function.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
