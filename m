From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] sound: align device drivers menus
Date: Wed, 28 Sep 2005 22:18:57 -0700
Message-ID: <20050928221857.741b9863.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id D2F42188
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 07:19:01 +0200 (MEST)
Received: from midway ([71.111.157.99]) by xenotime.net for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2005 22:18:58 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: akpm <akpm@osdl.org>, perex@suse.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@xenotime.net>

AC97 Kconfig entries broke the ALSA device drivers menu,
so move them to a location where that won't happen,
enabling all device sub-menus to be presented together.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 sound/drivers/Kconfig |    8 ++++++++
 sound/pci/Kconfig     |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff -Naurp linux-2614-rc2-git6/sound/drivers/Kconfig~alsa_pci_config linux-2614-rc2-git6/sound/drivers/Kconfig
--- linux-2614-rc2-git6/sound/drivers/Kconfig~alsa_pci_config	2005-09-27 21:36:14.000000000 -0700
+++ linux-2614-rc2-git6/sound/drivers/Kconfig	2005-09-28 22:06:12.000000000 -0700
@@ -100,4 +100,12 @@ config SND_MPU401
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-mpu401.
 
+config SND_AC97_CODEC
+	tristate
+	select SND_PCM
+	select SND_AC97_BUS
+
+config SND_AC97_BUS
+	tristate
+
 endmenu
diff -Naurp linux-2614-rc2-git6/sound/pci/Kconfig~alsa_pci_config linux-2614-rc2-git6/sound/pci/Kconfig
--- linux-2614-rc2-git6/sound/pci/Kconfig~alsa_pci_config	2005-09-27 21:36:14.000000000 -0700
+++ linux-2614-rc2-git6/sound/pci/Kconfig	2005-09-28 22:05:15.000000000 -0700
@@ -1,13 +1,5 @@
 # ALSA PCI drivers
 
-config SND_AC97_CODEC
-	tristate
-	select SND_PCM
-	select SND_AC97_BUS
-
-config SND_AC97_BUS
-	tristate
-
 menu "PCI devices"
 	depends on SND!=n && PCI
 


---


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
