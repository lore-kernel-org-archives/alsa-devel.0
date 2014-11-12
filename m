From: Chris J Arges <chris.j.arges@canonical.com>
Subject: [PATCH 2/4 v7] ALSA: usb-audio: Add private_data
	pointer to usb_mixer_elem_info
Date: Wed, 12 Nov 2014 12:07:00 -0600
Message-ID: <1415815622-31015-3-git-send-email-chris.j.arges@canonical.com>
References: <s5hk332svu5.wl-tiwai@suse.de>
 <1415815622-31015-1-git-send-email-chris.j.arges@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7457F2657C6
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 19:07:09 +0100 (CET)
In-Reply-To: <1415815622-31015-1-git-send-email-chris.j.arges@canonical.com>
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
Cc: tiwai@suse.de, th55@gmx.de, robin@gareus.org, clemens@ladisch.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Add a private_data pointer to usb_mixer_elem_info to allow other mixer
implementations to extend the structure as necessary.

Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
---
 sound/usb/mixer.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 73b1f64..8df9a73 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -53,6 +53,7 @@ struct usb_mixer_elem_info {
 	int cached;
 	int cache_val[MAX_CHANNELS];
 	u8 initialized;
+	void *private_data;
 };
 
 int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
-- 
2.1.3
