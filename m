From: Ludovic Drolez <ldrolez@free.fr>
Subject: sb 16 pro + alsa 0.5.12a + k 2.4.17 = alsa isapnp bug
Date: Mon, 11 Feb 2002 22:42:17 +0100
Message-ID: <3C683AB9.2040402@free.fr>
References: <3C66C614.3000709@free.fr> <20020210204243.GA22208@arthur.ubicom.tudelft.nl> <3C66E9D1.1020302@free.fr> <20020210223504.GD22208@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from red.localdomain (strasbourg-2-a7-13-9.dial.proxad.net [62.147.13.9])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA08380
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2002 22:43:30 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi !


I recompiled alsa with the '--with-debug=detect' option to find why alsa 0.5.12a works 
perfectly with my 2.2.19 kernel but not with a 2.4.17.
Both kernel are compiled with ISAPNP but Alsa is compiled '--with-isapnp=no' because the 
SB16Pro is not PNP.

With k 2.2.19, 'modprobe snd-card-sb16 snd_irq=5' gives:

Feb 11 18:46:52 red kernel: snd: SB [0x220]: DSP chip found, version = 4.13

Ok, no problem at all, now with 2.4.17:

Feb 11 19:50:57 red kernel: snd: isapnp failed for SB16
Feb 11 19:50:57 red kernel: snd: Sound Blaster 16 soundcard #1 not found at 0x220 or 
device busy
Feb 11 19:50:57 red kernel: snd: Sound Blaster 16 soundcard #2 not found or device busy 


Problem: Alsa tries to detect a PNP card even with '--with-isapnp=no' !
Indeed the 1st line (...isapnp failed...) is output by card-sb16.c line 536.
There is a bug here because 'snd_sb16_isapnp()' should not be reached because of a '#ifdef 
__ISAPNP__' and because 'CONFIG_ISAPNP=0'.

My quick fix to make my card work with 2.4.17:


--- include/driver.h.orig       Mon Feb 11 22:04:50 2002
+++ include/driver.h    Mon Feb 11 22:05:02 2002
@@ -125,21 +125,21 @@

  #if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE)
)
  #if (defined(CONFIG_ISAPNP_KERNEL) && defined(ALSA_BUILD)) || (LINUX_VERSION_CO
DE >= KERNEL_VERSION(2, 3, 30) && !defined(ALSA_BUILD))
  #include <linux/isapnp.h>
  #define isapnp_dev pci_dev
  #define isapnp_card pci_bus
  #else
  #include "isapnp.h"
  #endif
  #undef __ISAPNP__
-#define __ISAPNP__
+//#define __ISAPNP__
  #endif

  #ifndef MODULE_LICENSE
  #define MODULE_LICENSE(license)
  #endif

  #ifndef ALSA_BUILD
  #include <linux/asound.h>
  #include <linux/asoundid.h>
  #else


So there must be a problem with all the #if but I do not know exactly where.

(CONFIG_ISAPNP is redefined somewhere but it should not be).


Cheers,

   Ludovic Drolez.




-- 
http://www.palmopensource.com       - The PalmOS Open Source Portal
http://www.drolez.com      - Personal site - Linux and PalmOS stuff


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
