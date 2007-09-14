From: James Pearson <james-p@moving-picture.com>
Subject: alsa-driver-1.0.15rc2 build issues on RHEL4/CentOS4
Date: Fri, 14 Sep 2007 11:15:12 +0100
Message-ID: <46EA5F30.7000404@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id DB3DE24489
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 12:15:12 +0200 (CEST)
Received: from minion.mpc.local ([172.16.11.112] helo=moving-picture.com)
	by moving-picture.com with esmtp (Exim 4.43) id 1IW8Ce-0004gx-Ag
	for alsa-devel@alsa-project.org; Fri, 14 Sep 2007 11:15:12 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

alsa-driver-1.0.15rc2 won't build cleanly on RHEL4/CentOS4 (2.6.9 based 
kernel).

I've included the relevant errors below after running:

configure --with-redhat
make -i

The problem with misc/ac97_bus.c, I've already reported at:

<http://mailman.alsa-project.org/pipermail/alsa-devel/2007-September/003119.html>

James Pearson


Build errors:

   CC [M]  /tmp/alsa-driver-1.0.15rc2/misc/ac97_bus.o
In file included from /tmp/alsa-driver-1.0.15rc2/misc/ac97_bus.c:3:
/tmp/alsa-driver-1.0.15rc2/misc/../alsa-kernel/ac97_bus.c: In function 
`ac97_bus_suspend':
/tmp/alsa-driver-1.0.15rc2/misc/../alsa-kernel/ac97_bus.c:35: error: too 
few arguments to function
/tmp/alsa-driver-1.0.15rc2/misc/../alsa-kernel/ac97_bus.c: In function 
`ac97_bus_resume':
/tmp/alsa-driver-1.0.15rc2/misc/../alsa-kernel/ac97_bus.c:45: error: too 
few arguments to function
make[4]: [/tmp/alsa-driver-1.0.15rc2/misc/ac97_bus.o] Error 1 (ignored)


   CC [M]  /tmp/alsa-driver-1.0.15rc2/pci/cs5535audio/cs5535audio_pm.o
In file included from 
/tmp/alsa-driver-1.0.15rc2/pci/cs5535audio/cs5535audio_pm.c:2:
/tmp/alsa-driver-1.0.15rc2/pci/cs5535audio/../../alsa-kernel/pci/cs5535audio/cs5535audio_pm.c: 
In function `snd_cs5535audio_suspend':
/tmp/alsa-driver-1.0.15rc2/pci/cs5535audio/../../alsa-kernel/pci/cs5535audio/cs5535audio_pm.c:77: 
error: void value not ignored as it ought to be
/tmp/alsa-driver-1.0.15rc2/pci/cs5535audio/../../alsa-kernel/pci/cs5535audio/cs5535audio_pm.c: 
In function `snd_cs5535audio_resume':
/tmp/alsa-driver-1.0.15rc2/pci/cs5535audio/../../alsa-kernel/pci/cs5535audio/cs5535audio_pm.c:95: 
error: void value not ignored as it ought to be
make[5]: [/tmp/alsa-driver-1.0.15rc2/pci/cs5535audio/cs5535audio_pm.o] 
Error 1 (ignored)
   LD [M]  /tmp/alsa-driver-1.0.15rc2/pci/cs5535audio/snd-cs5535audio.o
ld: /tmp/alsa-driver-1.0.15rc2/pci/cs5535audio/cs5535audio_pm.o: No such 
file: No such file or directory
make[5]: [/tmp/alsa-driver-1.0.15rc2/pci/cs5535audio/snd-cs5535audio.o] 
Error 1 (ignored)


   Building modules, stage 2.
   MODPOST
*** Warning: "class_device_destroy" 
[/tmp/alsa-driver-1.0.15rc2/pci/asihpi/snd-asihpi.ko] undefined!
*** Warning: "ac97_bus_type" 
[/tmp/alsa-driver-1.0.15rc2/pci/ac97/snd-ac97-codec.ko] undefined!
*** Warning: "platform_device_alloc" 
[/tmp/alsa-driver-1.0.15rc2/drivers/snd-portman2x4.ko] undefined!
*** Warning: "platform_device_add" 
[/tmp/alsa-driver-1.0.15rc2/drivers/snd-portman2x4.ko] undefined!
*** Warning: "platform_device_put" 
[/tmp/alsa-driver-1.0.15rc2/drivers/snd-portman2x4.ko] undefined!
*** Warning: "platform_device_alloc" 
[/tmp/alsa-driver-1.0.15rc2/drivers/snd-mts64.ko] undefined!
*** Warning: "platform_device_add" 
[/tmp/alsa-driver-1.0.15rc2/drivers/snd-mts64.ko] undefined!
*** Warning: "platform_device_put" 
[/tmp/alsa-driver-1.0.15rc2/drivers/snd-mts64.ko] undefined!
