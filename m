From: Jiri Kosina <jikos@jikos.cz>
Subject: [PATCH] ALSA: fix kernel panic in initialization of
	mpu401 driver
Date: Wed, 4 Oct 2006 22:22:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0610042216240.12556@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from twin.jikos.cz (twin.jikos.cz [213.151.79.26])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8053C18D
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Oct 2006 22:22:21 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>, Castet Matthieu <castet.matthieu@free.fr>, Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I am getting kernel panic (NULL pointer dereference) on boot, with kernel 
compiled with CONFIG_SND_MPU401_UART=y, on machine which does not have 
this piece of hardware.

I have traced the problem down to 
sound/drivers/mpu401/mpu401.c:snd_mpu401_probe() returning EINVAL, when 
either port or IRQ parameters are not specified.

In such case, the drivers/base/bus.c:bus_attach_device() does not perform 
klist_add_tail() call, but rather sets dev->is_registered to 0. This flag 
is however not checked by the driver, so later on, when 
alsa_card_mpu401_init() is called and platform_device_register_simple() 
fails, the following callchain happens, causing NULL pointer dereference: 
alsa_card_mpu401_init() -> platform_device_unregister() -> 
platform_device_del() -> device_del() -> bus_remove_device() -> 
klist_del() -> BOOM (the entry was not added to klist in 
bus_attach_device()).

Proper solution is returning ENODEV from the ->probe() routine, which will 
be correctly handled then by the rest of the device-driver attaching 
subsystem (namely the retval check in bus_attach_device()). The following 
patch fixes the problem, please apply.

Patch against current Linus' git tree.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

--- a/sound/drivers/mpu401/mpu401.c
+++ b/sound/drivers/mpu401/mpu401.c
@@ -104,11 +104,11 @@ static int __devinit snd_mpu401_probe(st
 
 	if (port[dev] == SNDRV_AUTO_PORT) {
 		snd_printk(KERN_ERR "specify port\n");
-		return -EINVAL;
+		return -ENODEV;
 	}
 	if (irq[dev] == SNDRV_AUTO_IRQ) {
 		snd_printk(KERN_ERR "specify or disable IRQ\n");
-		return -EINVAL;
+		return -ENODEV;
 	}
 	err = snd_mpu401_create(dev, &card);
 	if (err < 0)

-- 
Jiri Kosina

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
