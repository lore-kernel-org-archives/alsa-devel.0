From: Antonio Ospite <ao2@amarulasolutions.com>
Subject: [PATCH 1/4] ALSA: snd-usb-caiaq: remove the unused
	snd_card_used variable
Date: Fri, 21 Jun 2013 13:11:48 +0200
Message-ID: <1371813111-26661-2-git-send-email-ao2@amarulasolutions.com>
References: <1371813111-26661-1-git-send-email-ao2@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1371813111-26661-1-git-send-email-ao2@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patch@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Antonio Ospite <ao2@amarulasolutions.com>, Clemens Ladisch <clemens@ladisch.de>, Karsten Wiese <annabellesgarden@yahoo.de>, Torsten Schenk <torsten.schenk@zoho.com>, Daniel Mack <daniel@caiaq.de>, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

The snd_card_used variable is only read but never written, remove it.

Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---
 sound/usb/caiaq/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 48b63cc..23cf55d 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -57,7 +57,6 @@ MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP; /* Enable this card */
-static int snd_card_used[SNDRV_CARDS];
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for the caiaq sound device");
@@ -388,7 +387,7 @@ static int create_card(struct usb_device *usb_dev,
 	struct snd_usb_caiaqdev *cdev;
 
 	for (devnum = 0; devnum < SNDRV_CARDS; devnum++)
-		if (enable[devnum] && !snd_card_used[devnum])
+		if (enable[devnum])
 			break;
 
 	if (devnum >= SNDRV_CARDS)
-- 
1.8.3.1
