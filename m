From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [ALSA STABLE 1/3] a few more -- fix the "enable" module parameter
 behaviour
Date: Thu, 13 Apr 2006 03:44:13 +0200
Message-ID: <443DACED.9010103__15904.1937128224$1144892598$gmane$org@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000408030601060207040109"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq3.tilbu1.nb.home.nl (smtpq3.tilbu1.nb.home.nl [213.51.146.202])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 034B3E0
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 03:42:32 +0200 (MEST)
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000408030601060207040109
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

The !enable[i] patch is also applicable to sound/drivers. This gets them
all.

   sound/drivers/dummy.c         |    4 +++-
   sound/drivers/mpu401/mpu401.c |    4 +++-
   sound/drivers/serial-u16550.c |    4 +++-
   sound/drivers/virmidi.c       |    4 +++-
   4 files changed, 12 insertions(+), 4 deletions(-)

Signed-off-by: Rene Herman <rene.herman@keyaccess.nl>



--------------000408030601060207040109
Content-Type: text/plain;
 name="alsa_platform_enable_remainder.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_enable_remainder.diff"

Index: local/sound/drivers/dummy.c
===================================================================
--- local.orig/sound/drivers/dummy.c	2006-03-20 06:53:29.000000000 +0100
+++ local/sound/drivers/dummy.c	2006-04-13 03:02:43.000000000 +0200
@@ -669,8 +669,10 @@ static int __init alsa_card_dummy_init(v
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_DUMMY_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/drivers/mpu401/mpu401.c
===================================================================
--- local.orig/sound/drivers/mpu401/mpu401.c	2006-03-20 06:53:29.000000000 +0100
+++ local/sound/drivers/mpu401/mpu401.c	2006-04-13 03:03:18.000000000 +0200
@@ -240,8 +240,10 @@ static int __init alsa_card_mpu401_init(
 		return err;
 
 	devices = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 #ifdef CONFIG_PNP
 		if (pnp[i])
 			continue;
Index: local/sound/drivers/serial-u16550.c
===================================================================
--- local.orig/sound/drivers/serial-u16550.c	2006-03-20 06:53:29.000000000 +0100
+++ local/sound/drivers/serial-u16550.c	2006-04-13 03:03:50.000000000 +0200
@@ -989,8 +989,10 @@ static int __init alsa_card_serial_init(
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_SERIAL_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {
Index: local/sound/drivers/virmidi.c
===================================================================
--- local.orig/sound/drivers/virmidi.c	2006-03-20 06:53:29.000000000 +0100
+++ local/sound/drivers/virmidi.c	2006-04-13 03:04:17.000000000 +0200
@@ -163,8 +163,10 @@ static int __init alsa_card_virmidi_init
 		return err;
 
 	cards = 0;
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
+		if (!enable[i])
+			continue;
 		device = platform_device_register_simple(SND_VIRMIDI_DRIVER,
 							 i, NULL, 0);
 		if (IS_ERR(device)) {


--------------000408030601060207040109--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
