From: Joachim Foerster <mls.JOFT@gmx.de>
Subject: Re: [PATCH] [ML403-AC97CR] Fix (device/driver) name
	registered	with platform bus
Date: Wed, 15 Aug 2007 20:45:22 +0200
Message-ID: <1187203522.1376.18.camel@localhost>
References: <1186655810.7420.26.camel@localhost>
	<s5hsl6sws0s.wl%tiwai@suse.de>  <1186849433.20835.33.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id DD72D243C2
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Aug 2007 20:45:27 +0200 (CEST)
In-Reply-To: <1186849433.20835.33.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel <alsa-devel@alsa-project.org>, Lorenz Kolb <lorenz.kolb@lkmail.de>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

below, you'll find a very small patch: In the current state, platform
bus _never_ activates (= calls probe() callback on) the driver, because
the driver's name has a dash and the device's name has an underscore. I
made this horrible change _after_ I tested the final patch, which I
posted on Saturday. Sorry.

From: Joachim Foerster <JOFT@gmx.de>

Names inside struct platform_device and struct platform_driver seem to
need underscores instead of dashes.

(Patch for Linus' master branch, date 2007/08/08 _including_ my patches
sent on Saturday)

Signed-off-by: Joachim Foerster <JOFT@gmx.de>
---
 arch/ppc/syslib/virtex_devices.c |    2 +-
 sound/drivers/ml403-ac97cr.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
index d0b04d6..9fa10b1 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -122,7 +122,7 @@
 }
 
 #define XPAR_AC97_CONTROLLER_REFERENCE(num) { \
-	.name = "ml403-ac97cr", \
+	.name = "ml403_ac97cr", \
 	.id = num, \
 	.num_resources = 3, \
 	.resource = (struct resource[]) { \
diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 2222315..2636249 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -66,7 +66,7 @@
 #include "pcm-indirect2.h"
 
 
-#define SND_ML403_AC97CR_DRIVER "ml403-ac97cr"
+#define SND_ML403_AC97CR_DRIVER "ml403_ac97cr"
 
 MODULE_AUTHOR("Joachim Foerster <JOFT@gmx.de>");
 MODULE_DESCRIPTION("Xilinx ML403 AC97 Controller Reference");
-- 
1.5.2.4
