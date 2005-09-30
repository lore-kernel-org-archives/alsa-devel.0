From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] sound: align device drivers menus
Date: Thu, 29 Sep 2005 19:57:22 -0700
Message-ID: <20050929195722.1fe323ae.rdunlap@xenotime.net>
References: <20050928221857.741b9863.rdunlap@xenotime.net>
	<s5hek78dlbp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id C672916A
	for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2005 04:57:26 +0200 (MEST)
Received: from midway ([71.111.157.99]) by xenotime.net for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 19:57:24 -0700
In-Reply-To: <s5hek78dlbp.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: akpm@osdl.org, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Sep 2005 16:01:46 +0200 Takashi Iwai wrote:

> Hmm, this was intentionally out of "PCI devices" menu, because
> SND_AC97_CODEC and SND_AC97_BUS are independent from PCI, indeed.
> Having them into "PCI" menu breaks ARM pxa2xx-ac97 driver.
> 
> I guess simply moving them to drivers/Kconfig would solve, then.

Hi-
I think they work where I had moved them, but I'll move them again.
I did test with ARCH={i386,mips,arm} successfully (both patches).

Here's a replacement patch.

Andrew, please drop:  sound-align-device-drivers-menus.patch
and replace it with this one.

---
From: Randy Dunlap <rdunlap@xenotime.net>

AC97 Kconfig entries broke the ALSA device drivers menu,
so move them to a location where that won't happen,
enabling all device sub-menus to be presented together.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 sound/Kconfig     |    8 ++++++++
 sound/pci/Kconfig |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

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
 
diff -Naurp linux-2614-rc2-git6/sound/Kconfig~alsa_pci_config linux-2614-rc2-git6/sound/Kconfig
--- linux-2614-rc2-git6/sound/Kconfig~alsa_pci_config	2005-08-28 16:41:01.000000000 -0700
+++ linux-2614-rc2-git6/sound/Kconfig	2005-09-29 19:45:01.000000000 -0700
@@ -48,6 +48,14 @@ config SND
 
 	  For more information, see <http://www.alsa-project.org/>
 
+config SND_AC97_CODEC
+	tristate
+	select SND_PCM
+	select SND_AC97_BUS
+
+config SND_AC97_BUS
+	tristate
+
 source "sound/core/Kconfig"
 
 source "sound/drivers/Kconfig"


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
