From: Erik Mouw <erik@harddisk-recovery.com>
Subject: [PATCH 2.6.17-rc2] ALSA: PCMCIA sound devices shouldn't depend on ISA
Date: Wed, 19 Apr 2006 16:40:08 +0200
Message-ID: <20060419144008.GD24807@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from abra2.bitwizard.nl (dtp.xs4all.nl [80.126.206.180])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 7AB8616E
	for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2006 16:40:15 +0200 (MEST)
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
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The ALSA drivers for PCMCIA devices depend on ISA, but modern
laptops can have PCMCIA support without ISA. This patch removes
the dependency.

Signed-off-by: Erik Mouw <erik@harddisk-recovery.com>

diff --git a/sound/pcmcia/Kconfig b/sound/pcmcia/Kconfig
index 5d1b0b7..c9fa1a2 100644
--- a/sound/pcmcia/Kconfig
+++ b/sound/pcmcia/Kconfig
@@ -5,7 +5,7 @@ menu "PCMCIA devices"
 
 config SND_VXPOCKET
 	tristate "Digigram VXpocket"
-	depends on SND && PCMCIA && ISA
+	depends on SND && PCMCIA
 	select SND_VX_LIB
 	help
 	  Say Y here to include support for Digigram VXpocket and
@@ -16,7 +16,7 @@ config SND_VXPOCKET
 
 config SND_PDAUDIOCF
 	tristate "Sound Core PDAudioCF"
-	depends on SND && PCMCIA && ISA
+	depends on SND && PCMCIA
 	select SND_PCM
 	help
 	  Say Y here to include support for Sound Core PDAudioCF


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
