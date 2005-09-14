From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Platform bus question
Date: Wed, 14 Sep 2005 23:11:29 +0100
Message-ID: <1126735889.3428.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am writing a driver for the sound card on the Sega Dreamcast (you can
view it at http://newgolddream.dyndns.info/repos/aica) and I am using
this:

	snd_card_set_dev(dreamcastcard, &platform_bus);	

	/* Register the card with ALSA subsystem */
	if ((err = snd_card_register(dreamcastcard)) < 0) {
		snd_aicapcm_free();	
		snd_card_free(dreamcastcard);
		return err;
	}


In the hope that the card will be registered with the generic platform
bus.

The code does not generate any errors, but doesn't appear to work
either!

eg

sh-3.00# cd /sys
sh-3.00# ls
block     bus       class     devices   firmware  kernel    module
sh-3.00# cd bus
sh-3.00# ls
pci       platform  serio     shbus
sh-3.00# cd platform
sh-3.00# ls
devices  drivers
sh-3.00# cd devices
sh-3.00# ls -l
sh-3.00#

(ie nothing appearing in /sys/bus/platform/devices)

and

sh-3.00# cd /sys
sh-3.00# ls
block     bus       class     devices   firmware  kernel    module
sh-3.00# cd devices
sh-3.00# ls
pci0000:00  platform    shbus       system
sh-3.00# cd platform
sh-3.00# ls -l
sh-3.00#


Yet it also reports this...
sh-3.00# cd /sys
sh-3.00# ls
block     bus       class     devices   firmware  kernel    module
sh-3.00# cd class
sh-3.00# ls
graphics  mem       net       sound     vc
input     misc      pci_bus   tty
sh-3.00# cd sound
sh-3.00# ls
controlC0  pcmC0D0p   timer
sh-3.00# ls -l
drwxr-xr-x    2 root     root            0 Sep 14 17:07 controlC0
drwxr-xr-x    2 root     root            0 Sep 14 17:07 pcmC0D0p
drwxr-xr-x    2 root     root            0 Sep 14 17:07 timer
sh-3.00# cd pcmC0D0p/
sh-3.00# ls
dev     device
sh-3.00# ls -l
-r--r--r--    1 root     root         4096 Sep 14 17:11 dev
lrwxrwxrwx    1 root     root            0 Sep 14 17:11 device
-> ../../../devices/platform


Do I need to write specific platform bus code for this device or should
ALSA handle it for me?




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
