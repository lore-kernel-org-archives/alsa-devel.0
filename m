From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/5] ALSA: snd_usb_caiaq: give better shortname
Date: Sat, 30 May 2009 22:25:20 +0200
Message-ID: <1243715123-16414-2-git-send-email-daniel@caiaq.de>
References: <y>
 <1243715123-16414-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C55EB2433E
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 22:25:34 +0200 (CEST)
In-Reply-To: <1243715123-16414-1-git-send-email-daniel@caiaq.de>
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

ALSA's core will only take the last part of a string from the shortname,
hence replace all ' ' by '_'. For example, the card name 'Audio 4 DJ'
was shortened to 'DJ' before which doesn't look nice at all.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/caiaq/device.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 9be0f2e..4756b48 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -435,6 +435,11 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
 	strcpy(card->driver, MODNAME);
 	strcpy(card->shortname, dev->product_name);
 
+	/* replace ' ' with '_' in device shortname */
+	for (c = card->shortname; *c; c++)
+		if (*c == ' ')
+			*c = '_';
+
 	len = snprintf(card->longname, sizeof(card->longname),
 		       "%s %s (serial %s, ",
 		       dev->vendor_name, dev->product_name, dev->serial);
-- 
1.6.3.1
