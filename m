From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] OSS gameport fixes
Date: Wed, 9 Mar 2005 12:32:17 +0100
Message-ID: <20050309113217.GB21688@stusta.de>
References: <20050304033215.1ffa8fec.akpm@osdl.org> <200503070941.59365.petkov@uni-muenster.de> <20050307215206.GH3170@stusta.de> <d120d50005030714126e345fe2@mail.gmail.com> <20050307230633.GJ3170@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id C1CF91A8
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2005 12:32:18 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20050307230633.GJ3170@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: dtor_core@ameritech.net, Borislav Petkov <petkov@uni-muenster.de>, perex@suse.cz, vojtech@suse.cz, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: alsa-devel@alsa-project.org

This patch adds dummy gameport_register_port, gameport_unregister_port 
and gameport_set_phys functions to gameport.h for the case when a driver 
can't use gameport.

This fixes the compilation of some OSS drivers with GAMEPORT=n without 
the need to #if inside every single driver.

This patch also removes the non-working and now obsolete SOUND_GAMEPORT.

This patch is also an alternative solution for ALSA drivers with similar 
problems (but #if's inside the drivers might have the advantage of 
saving some more bytes of gameport is not available).

The only user-visible change is that for GAMEPORT=m the affected OSS 
drivers are now allowed to be built statically (but they won't have 
gameport support).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/input/gameport/Kconfig |   20 --------------------
 include/linux/gameport.h       |   28 +++++++++++++++++++++++++---
 sound/oss/Kconfig              |   12 ++++++------
 3 files changed, 31 insertions(+), 29 deletions(-)

--- linux-2.6.11-mm2-full/include/linux/gameport.h.old	2005-03-09 06:25:41.000000000 +0100
+++ linux-2.6.11-mm2-full/include/linux/gameport.h	2005-03-09 06:41:58.000000000 +0100
@@ -67,6 +67,8 @@
 void gameport_close(struct gameport *gameport);
 void gameport_rescan(struct gameport *gameport);
 
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+
 void __gameport_register_port(struct gameport *gameport, struct module *owner);
 static inline void gameport_register_port(struct gameport *gameport)
 {
@@ -75,6 +77,29 @@
 
 void gameport_unregister_port(struct gameport *gameport);
 
+void gameport_set_phys(struct gameport *gameport, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
+
+#else
+
+static inline void gameport_register_port(struct gameport *gameport)
+{
+	return;
+}
+
+static inline void gameport_unregister_port(struct gameport *gameport)
+{
+	return;
+}
+
+static inline void gameport_set_phys(struct gameport *gameport,
+				     const char *fmt, ...)
+{
+	return;
+}
+
+#endif
+
 static inline struct gameport *gameport_allocate_port(void)
 {
 	struct gameport *gameport = kcalloc(1, sizeof(struct gameport), GFP_KERNEL);
@@ -92,9 +117,6 @@
 	strlcpy(gameport->name, name, sizeof(gameport->name));
 }
 
-void gameport_set_phys(struct gameport *gameport, const char *fmt, ...)
-	__attribute__ ((format (printf, 2, 3)));
-
 /*
  * Use the following fucntions to manipulate gameport's per-port
  * driver-specific data.
--- linux-2.6.11-mm2-full/drivers/input/gameport/Kconfig.old	2005-03-09 06:20:28.000000000 +0100
+++ linux-2.6.11-mm2-full/drivers/input/gameport/Kconfig	2005-03-09 06:20:56.000000000 +0100
@@ -64,23 +64,3 @@
 	tristate "Crystal SoundFusion gameport support"
 
 endif
-
-# Yes, SOUND_GAMEPORT looks a bit odd. Yes, it ends up being turned on
-# in every .config. Please don't touch it. It is here to handle an
-# unusual dependency between GAMEPORT and sound drivers.
-#
-# Some sound drivers call gameport functions. If GAMEPORT is
-# not selected, empty stubs are provided for the functions and all is
-# well.
-# If GAMEPORT is built in, everything is fine.
-# If GAMEPORT is a module, however, it would need to be loaded for the
-# sound driver to be able to link properly. Therefore, the sound
-# driver must be a module as well in that case. Since there's no way
-# to express that directly in Kconfig, we use SOUND_GAMEPORT to
-# express it. SOUND_GAMEPORT boils down to "if GAMEPORT is 'm',
-# anything that depends on SOUND_GAMEPORT must be 'm' as well. if
-# GAMEPORT is 'y' or 'n', it can be anything".
-config SOUND_GAMEPORT
-	tristate
-	default m if GAMEPORT=m
-	default y
--- linux-2.6.11-mm2-full/sound/oss/Kconfig.old	2005-03-09 06:21:05.000000000 +0100
+++ linux-2.6.11-mm2-full/sound/oss/Kconfig	2005-03-09 06:28:29.000000000 +0100
@@ -112,7 +112,7 @@
 
 config SOUND_ES1370
 	tristate "Ensoniq AudioPCI (ES1370)"
-	depends on SOUND_PRIME!=n && SOUND && PCI && SOUND_GAMEPORT
+	depends on SOUND_PRIME!=n && SOUND && PCI
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1370 chipset, such as Ensoniq's AudioPCI (non-97). To find
@@ -125,7 +125,7 @@
 
 config SOUND_ES1371
 	tristate "Creative Ensoniq AudioPCI 97 (ES1371)"
-	depends on SOUND_PRIME!=n && SOUND && PCI && SOUND_GAMEPORT
+	depends on SOUND_PRIME!=n && SOUND && PCI
 	help
 	  Say Y or M if you have a PCI sound card utilizing the Ensoniq
 	  ES1371 chipset, such as Ensoniq's AudioPCI97. To find out if
@@ -138,7 +138,7 @@
 
 config SOUND_ESSSOLO1
 	tristate "ESS Technology Solo1" 
-	depends on SOUND_PRIME!=n && SOUND && SOUND_GAMEPORT && PCI
+	depends on SOUND_PRIME!=n && SOUND && PCI
 	help
 	  Say Y or M if you have a PCI sound card utilizing the ESS Technology
 	  Solo1 chip. To find out if your sound card uses a
@@ -179,7 +179,7 @@
 
 config SOUND_SONICVIBES
 	tristate "S3 SonicVibes"
-	depends on SOUND_PRIME!=n && SOUND && SOUND_GAMEPORT
+	depends on SOUND_PRIME!=n && SOUND
 	help
 	  Say Y or M if you have a PCI sound card utilizing the S3
 	  SonicVibes chipset. To find out if your sound card uses a
@@ -226,7 +226,7 @@
 
 config SOUND_TRIDENT
 	tristate "Trident 4DWave DX/NX, SiS 7018 or ALi 5451 PCI Audio Core"
-	depends on SOUND_PRIME!=n && SOUND && SOUND_GAMEPORT
+	depends on SOUND_PRIME!=n && SOUND
 	---help---
 	  Say Y or M if you have a PCI sound card utilizing the Trident
 	  4DWave-DX/NX chipset or your mother board chipset has SiS 7018
@@ -739,7 +739,7 @@
 
 config SOUND_MAD16
 	tristate "OPTi MAD16 and/or Mozart based cards"
-	depends on SOUND_OSS && SOUND_GAMEPORT
+	depends on SOUND_OSS
 	---help---
 	  Answer Y if your card has a Mozart (OAK OTI-601) or MAD16 (OPTi
 	  82C928 or 82C929 or 82C931) audio interface chip. These chips are


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
