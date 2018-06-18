From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] ALSA: line6: stop using get_seconds()
Date: Mon, 18 Jun 2018 17:41:01 +0200
Message-ID: <20180618154108.2227779-2-arnd@arndb.de>
References: <20180618154108.2227779-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id DFF5C266E77
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 17:41:54 +0200 (CEST)
In-Reply-To: <20180618154108.2227779-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The get_seconds() function is deprecated because it truncates the
timestamp to 32 bits, so all users should change to ktime_get_seconds()
or ktime_get_real_seconds().

The firmware interface for passing the timestamp is also limited to
32 bits, so this patch only has the cosmetic effect of avoiding the
old interface.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/usb/line6/toneport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 750467fb95db..f47ba94e6f4a 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -367,12 +367,13 @@ static bool toneport_has_source_select(struct usb_line6_toneport *toneport)
 */
 static void toneport_setup(struct usb_line6_toneport *toneport)
 {
-	int ticks;
+	u32 ticks;
 	struct usb_line6 *line6 = &toneport->line6;
 	struct usb_device *usbdev = line6->usbdev;
 
 	/* sync time on device with host: */
-	ticks = (int)get_seconds();
+	/* note: 32-bit timestamps overflow in year 2106 */
+	ticks = (u32)ktime_get_real_seconds();
 	line6_write_data(line6, 0x80c6, &ticks, 4);
 
 	/* enable device: */
-- 
2.9.0
