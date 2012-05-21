From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] sound: sh: Fix up namespace collision in
	sh_dac_audio.
Date: Mon, 21 May 2012 18:21:54 +0900
Message-ID: <20120521092151.GF31763@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 814E024362
	for <alsa-devel@alsa-project.org>;
	Mon, 21 May 2012 11:21:58 +0200 (CEST)
Content-Disposition: inline
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
Cc: Axel Lin <axel.lin@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The module_platform_driver() conversion ended up tripping over the driver
name, leading to confusion in the macro with regards to 'driver' being
redefined. rename it to something slightly more suitable to avoid
namespace collisions.

sound/sh/sh_dac_audio.c:444:122: error: conflicting types for 'driver_init'
include/linux/device.h:773:6: note: previous declaration of 'driver_init' was here
make[3]: *** [sound/sh/sh_dac_audio.o] Error 1

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 sound/sh/sh_dac_audio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index b11f82b..f8b01c7 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -433,7 +433,7 @@ probe_error:
 /*
  * "driver" definition
  */
-static struct platform_driver driver = {
+static struct platform_driver sh_dac_driver = {
 	.probe	= snd_sh_dac_probe,
 	.remove = snd_sh_dac_remove,
 	.driver = {
@@ -441,4 +441,4 @@ static struct platform_driver driver = {
 	},
 };
 
-module_platform_driver(driver);
+module_platform_driver(sh_dac_driver);
