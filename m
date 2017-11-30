From: Tamaki Nishino <otamachan@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Change the semantics of the
	enable option
Date: Thu, 30 Nov 2017 20:27:52 +0900
Message-ID: <1512041272-8653-1-git-send-email-otamachan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Tamaki Nishino <otamachan@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch changes the semantics of the enable option for snd-usb-audio
in order to allow users to disable a device specified by either or both
of the vendor id and the product id.

Signed-off-by: Tamaki Nishino <otamachan@gmail.com>
---
 sound/usb/card.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 23d1d23..8018d56 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -585,15 +585,24 @@ static int usb_audio_probe(struct usb_interface *intf,
 		 * now look for an empty slot and create a new card instance
 		 */
 		for (i = 0; i < SNDRV_CARDS; i++)
-			if (enable[i] && ! usb_chip[i] &&
+			if (!usb_chip[i] &&
 			    (vid[i] == -1 || vid[i] == USB_ID_VENDOR(id)) &&
 			    (pid[i] == -1 || pid[i] == USB_ID_PRODUCT(id))) {
-				err = snd_usb_audio_create(intf, dev, i, quirk,
-							   id, &chip);
-				if (err < 0)
+				if (enable[i]) {
+					err = snd_usb_audio_create(intf, dev, i, quirk,
+								   id, &chip);
+					if (err < 0)
+						goto __error;
+					chip->pm_intf = intf;
+					break;
+				} else if (vid[i] != -1 || pid[i] != -1) {
+					dev_info(&dev->dev,
+						 "device (%04x:%04x) is disabled\n",
+						 USB_ID_VENDOR(id),
+						 USB_ID_PRODUCT(id));
+					err = -ENOENT;
 					goto __error;
-				chip->pm_intf = intf;
-				break;
+				}
 			}
 		if (!chip) {
 			dev_err(&dev->dev, "no available usb audio device\n");
-- 
2.7.4
