From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: usb-audio: Fix NULL dereference in
	create_fixed_stream_quirk()
Date: Wed, 16 Mar 2016 12:50:14 +0100
Message-ID: <1458129016-27188-2-git-send-email-tiwai@suse.de>
References: <1458129016-27188-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F199265E5B
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 12:50:19 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 08F29AD00
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:50:17 +0000 (UTC)
In-Reply-To: <1458129016-27188-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

create_fixed_stream_quirk() may cause a NULL-pointer dereference by
accessing the non-existing endpoint when a USB device with a malformed
USB descriptor is used.

This patch avoids it simply by adding a sanity check of bNumEndpoints
before the accesses.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=971125
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 5b03296a5bd9..529c35cceaa6 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -180,6 +180,12 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	}
 	alts = &iface->altsetting[fp->altset_idx];
 	altsd = get_iface_desc(alts);
+	if (altsd->bNumEndpoints < 1) {
+		kfree(fp);
+		kfree(rate_table);
+		return -EINVAL;
+	}
+
 	fp->protocol = altsd->bInterfaceProtocol;
 
 	if (fp->datainterval == 0)
-- 
2.7.3
