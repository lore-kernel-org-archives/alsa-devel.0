From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] ACPI: ibm-acpi: improve backlight power
	handling
Date: Mon, 26 Feb 2007 22:01:26 -0300
Message-ID: <20070227010126.GA6828@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Improve the backlight code to emulate as much as possible the power
management events, as we are unable to really power on or power off the
backlight.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Richard Purdie <rpurdie@rpsys.net>
---

 Len, I have added this to the for-upstream/acpi-test branch
 of git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
 for when you pull it.

 drivers/acpi/ibm_acpi.c |    5 ++++-
 drivers/acpi/ibm_acpi.h |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index dd36be0..6573d01 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1664,7 +1664,10 @@ static void brightness_exit(void)
 
 static int brightness_update_status(struct backlight_device *bd)
 {
-	return brightness_set(bd->props.brightness);
+	return brightness_set(
+		(bd->props.fb_blank == FB_BLANK_UNBLANK &&
+		 bd->props.power == FB_BLANK_UNBLANK) ?
+				bd->props.brightness : 0);
 }
 
 static int brightness_get(struct backlight_device *bd)
diff --git a/drivers/acpi/ibm_acpi.h b/drivers/acpi/ibm_acpi.h
index 4d0387a..b63c014 100644
--- a/drivers/acpi/ibm_acpi.h
+++ b/drivers/acpi/ibm_acpi.h
@@ -32,6 +32,7 @@
 
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
+#include <linux/fb.h>
 #include <asm/uaccess.h>
 
 #include <linux/dmi.h>
-- 
1.5.0.1

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
