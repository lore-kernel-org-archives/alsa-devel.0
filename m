From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: [PATCH 0/10] Convert gameport to driver model/sysfs
Date: Fri, 11 Feb 2005 01:58:47 -0500
Message-ID: <200502110158.47872.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp817.mail.sc5.yahoo.com (smtp817.mail.sc5.yahoo.com [66.163.170.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 98BB41FF
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2005 08:05:33 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hi,

This series of patches adds a new "gameport" bus to the driver model.
It is implemented very similarly to "serio" bus and also allows
individual drivers to be manually bound/disconnected from a port
by manipulating port's "drvctl" attribute.

01-gameport-renames1.patch
- rename gameport->driver to gameport->port_data in preparation
  to sysfs integration to avoid confusion with real drivers.

02-gameport-renames2.patch
- more renames in gameport in preparations to sysfs integration,
  gameport_dev renamed to gameport_driver, gameport_[un]register_device
  renamed to gameport_[un]register_driver

03-gameport-connect-mandatory.patch
- make connect and disconnect mandatory as these call gameport_open
  and gameport_close which actually bind driver and port together.

04-gameport-dynalloc-prepare.patch
- sysfs/kobjects requires objects be allocated synamically. Prepare
  to dynamic gameport allocation, create gameport_allocate_port and
  gameport_free_port; dynamically allocated ports are freed by core
  upon release. Also add gameport_set_name and gameport_set_phys
  to ease transition.

05-gameport-dynalloc-input.patch
- convert drivers in input/gameport to dynamic gameport allocation.

06-gameport-dynalloc-sound-oss.patch
- convert drivers in sound/oss to dynamic gameport allocation.

07-gameport-dynalloc-sound-alsa.patch
- convert drivers in sound/pci to dynamic gameport allocation.

08-gameport-drivers-sysfs.patch
- add "gameport" bus and have joystick gameport drivers register
  themselves on this bus.

09-gameport-devices-sysfs.patch
- complete gameport sysfs integration. Gameports are registered on
  the "gameport" bus.
 
10-gameport-drvdata.patch
- Get rid of gameport->private, use driver-specific data in device
  structure, access through gameport_get/set_drvdata helpers.

The changes can also be pulled from my tree (which has Vojtech's
input tree as a parent):

	bk pull bk://dtor.bkbits.net/input 

I am CC-ing ALSA list as the changes touch quite a few sound drivers.

Comments/testing is appreciated.

-- 
Dmitry


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
