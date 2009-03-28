From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] snd-usb-caiaq: clean up header includes
Date: Sat, 28 Mar 2009 21:19:49 +0100
Message-ID: <1238271589-16840-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 075CB1037E3
	for <alsa-devel@alsa-project.org>; Sat, 28 Mar 2009 21:19:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/caiaq/caiaq-audio.c   |    8 +-------
 sound/usb/caiaq/caiaq-control.c |    6 +-----
 sound/usb/caiaq/caiaq-device.c  |   13 +++----------
 sound/usb/caiaq/caiaq-input.c   |    6 ------
 sound/usb/caiaq/caiaq-midi.c    |    9 +--------
 5 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/sound/usb/caiaq/caiaq-audio.c b/sound/usb/caiaq/caiaq-audio.c
index 08d51e0..cf37331 100644
--- a/sound/usb/caiaq/caiaq-audio.c
+++ b/sound/usb/caiaq/caiaq-audio.c
@@ -16,17 +16,11 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 */
 
+#include <linux/spinlock.h>
 #include <linux/init.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/interrupt.h>
 #include <linux/usb.h>
-#include <linux/spinlock.h>
 #include <sound/core.h>
-#include <sound/initval.h>
 #include <sound/pcm.h>
-#include <sound/rawmidi.h>
-#include <linux/input.h>
 
 #include "caiaq-device.h"
 #include "caiaq-audio.h"
diff --git a/sound/usb/caiaq/caiaq-control.c b/sound/usb/caiaq/caiaq-control.c
index 77f60b4..52685cf 100644
--- a/sound/usb/caiaq/caiaq-control.c
+++ b/sound/usb/caiaq/caiaq-control.c
@@ -18,14 +18,10 @@
  */
 
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/usb.h>
+#include <sound/control.h>
 #include <sound/core.h>
-#include <sound/initval.h>
 #include <sound/pcm.h>
-#include <sound/rawmidi.h>
-#include <sound/control.h>
-#include <linux/input.h>
 
 #include "caiaq-device.h"
 #include "caiaq-control.h"
diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index cf573a9..89f8b68 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -19,27 +19,20 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 */
 
-#include <linux/init.h>
-#include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/usb.h>
-#include <linux/input.h>
-#include <linux/spinlock.h>
-#include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/core.h>
 #include <sound/pcm.h>
-#include <sound/rawmidi.h>
-#include <sound/control.h>
 
 #include "caiaq-device.h"
 #include "caiaq-audio.h"
 #include "caiaq-midi.h"
 #include "caiaq-control.h"
-
-#ifdef CONFIG_SND_USB_CAIAQ_INPUT
 #include "caiaq-input.h"
-#endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
 MODULE_DESCRIPTION("caiaq USB audio, version 1.3.13");
diff --git a/sound/usb/caiaq/caiaq-input.c b/sound/usb/caiaq/caiaq-input.c
index f743847..4451775 100644
--- a/sound/usb/caiaq/caiaq-input.c
+++ b/sound/usb/caiaq/caiaq-input.c
@@ -17,14 +17,8 @@
 */
 
 #include <linux/init.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/input.h>
 #include <linux/usb.h>
 #include <linux/usb/input.h>
-#include <linux/spinlock.h>
-#include <sound/core.h>
-#include <sound/rawmidi.h>
 #include <sound/pcm.h>
 #include "caiaq-device.h"
 #include "caiaq-input.h"
diff --git a/sound/usb/caiaq/caiaq-midi.c b/sound/usb/caiaq/caiaq-midi.c
index f19fd36..79424c1 100644
--- a/sound/usb/caiaq/caiaq-midi.c
+++ b/sound/usb/caiaq/caiaq-midi.c
@@ -16,21 +16,14 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 */
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/interrupt.h>
 #include <linux/usb.h>
-#include <linux/input.h>
-#include <linux/spinlock.h>
-#include <sound/core.h>
 #include <sound/rawmidi.h>
+#include <sound/core.h>
 #include <sound/pcm.h>
 
 #include "caiaq-device.h"
 #include "caiaq-midi.h"
 
-
 static int snd_usb_caiaq_midi_input_open(struct snd_rawmidi_substream *substream)
 {
 	return 0;
-- 
1.6.2.1
