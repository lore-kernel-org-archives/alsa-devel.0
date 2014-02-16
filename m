From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ALSA: usb-audio: work around KEF X300A
	firmware bug
Date: Sun, 16 Feb 2014 17:11:10 +0100
Message-ID: <5300E31E.9070600@ladisch.de>
References: <1392284545.11227.4.camel@srv31.corp.novso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 231072616F4
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2014 17:11:36 +0100 (CET)
In-Reply-To: <1392284545.11227.4.camel@srv31.corp.novso.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Nicolas DEFFAYET <nicolas@deffayet.com>
List-Id: alsa-devel@alsa-project.org

When the driver tries to access Function Unit 10, the KEF X300A
speakers' firmware apparently locks up, making even PCM streaming
impossible.  Work around this by ignoring this FU.

Cc: <stable@vger.kernel.org>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/mixer_maps.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 32af6b7..d1d72ff 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -328,6 +328,11 @@ static struct usbmix_name_map gamecom780_map[] = {
 	{}
 };

+static const struct usbmix_name_map kef_x300a_map[] = {
+	{ 10, NULL }, /* firmware locks up (?) when we try to access this FU */
+	{ 0 }
+};
+
 /*
  * Control map entries
  */
@@ -419,6 +424,10 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x200c, 0x1018),
 		.map = ebox44_map,
 	},
+	{
+		.id = USB_ID(0x27ac, 0x1000),
+		.map = kef_x300a_map,
+	},
 	{ 0 } /* terminator */
 };
