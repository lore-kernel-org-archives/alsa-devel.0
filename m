From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: usb-audio - NULL dereference on probe
	error
Date: Tue, 27 Sep 2011 10:44:07 +0300
Message-ID: <20110927074407.GA9346@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id EDC26243D8
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 09:44:25 +0200 (CEST)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: Oliver Neukum <oneukum@suse.de>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Thomas Pfaff <tpfaff@gmx.net>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

There was a potential NULL dereference introduced in 362e4e49abe
"ALSA: usb-audio - clear chip->probing on error exit"

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/usb/card.c b/sound/usb/card.c
index cc08588..8db260f 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -532,7 +532,8 @@ snd_usb_audio_probe(struct usb_device *dev,
  __error:
 	if (chip && !chip->num_interfaces)
 		snd_card_free(chip->card);
-	chip->probing = 0;
+	if (chip)
+		chip->probing = 0;
 	mutex_unlock(&register_mutex);
  __err_val:
 	return NULL;
