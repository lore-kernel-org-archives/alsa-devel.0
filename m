From: Dale Sedivec <dale-keyword-alsa.049f33@codefu.org>
Subject: [PATCH] au88x0: clean up __devinit/__devexit
Date: Sat, 8 Apr 2006 20:40:19 -0400
Message-ID: <20060409004019.GA23548@morgase.caliginous.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

Removed all use of __devinit/__devexit and init.h from headers.  Any
attributes given in the prototype but not in the function definition have
been moved to the definition.

An exception is vortex_eq_free: I removed the __devexit attribute because
vortex_eq_free is called from vortex_core_shutdown, and
vortex_core_shutdown may be called from __devinit snd_vortex_create.

Compile tested with allyesconfig and allmodconfig.

Signed-off-by: Dale Sedivec <dale@codefu.org>

---

Patches against 2.6.16, applies (with fuzz) against ALSA CVS.

These fixes originated as part of a Kernel Janitors task [1].  Patch
originally sent to kernel-janitors mailing list, resent here after it
was suggested that any patches against ALSA must be made through
alsa-devel [2].

  [1] http://www.kerneljanitors.org/TODO
  [2] http://lists.osdl.org/pipermail/kernel-janitors/2006-April/006193.html


 sound/pci/au88x0/au88x0.h      |   13 ++++++-------
 sound/pci/au88x0/au88x0_core.c |    2 +-
 sound/pci/au88x0/au88x0_eq.c   |    2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/pci/au88x0/au88x0.h b/sound/pci/au88x0/au88x0.h
index c2ad267..b115dba 100644
--- a/sound/pci/au88x0/au88x0.h
+++ b/sound/pci/au88x0/au88x0.h
@@ -19,7 +19,6 @@
 
 #ifdef __KERNEL__
 #include <sound/driver.h>
-#include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
 #include <sound/core.h>
@@ -277,14 +276,14 @@ static void vortex_Vort3D_InitializeSour
 #endif
 
 /* Driver stuff. */
-static int __devinit vortex_gameport_register(vortex_t * card);
+static int vortex_gameport_register(vortex_t * card);
 static void vortex_gameport_unregister(vortex_t * card);
 #ifndef CHIP_AU8820
-static int __devinit vortex_eq_init(vortex_t * vortex);
-static int __devexit vortex_eq_free(vortex_t * vortex);
+static int vortex_eq_init(vortex_t * vortex);
+static int vortex_eq_free(vortex_t * vortex);
 #endif
 /* ALSA stuff. */
-static int __devinit snd_vortex_new_pcm(vortex_t * vortex, int idx, int nr);
-static int __devinit snd_vortex_mixer(vortex_t * vortex);
-static int __devinit snd_vortex_midi(vortex_t * vortex);
+static int snd_vortex_new_pcm(vortex_t * vortex, int idx, int nr);
+static int snd_vortex_mixer(vortex_t * vortex);
+static int snd_vortex_midi(vortex_t * vortex);
 #endif
diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index e3394fe..5958945 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -2658,7 +2658,7 @@ static void vortex_spdif_init(vortex_t *
 
 /* Initialization */
 
-static int vortex_core_init(vortex_t * vortex)
+static int __devinit vortex_core_init(vortex_t * vortex)
 {
 
 	printk(KERN_INFO "Vortex: init.... ");
diff --git a/sound/pci/au88x0/au88x0_eq.c b/sound/pci/au88x0/au88x0_eq.c
index c8280f8..6c3f636 100644
--- a/sound/pci/au88x0/au88x0_eq.c
+++ b/sound/pci/au88x0/au88x0_eq.c
@@ -886,7 +886,7 @@ static char *EqBandLabels[10] __devinitd
 };
 
 /* ALSA driver entry points. Init and exit. */
-static int vortex_eq_init(vortex_t * vortex)
+static int __devinit vortex_eq_init(vortex_t * vortex)
 {
 	struct snd_kcontrol *kcontrol;
 	int err, i;


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
