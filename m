From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/2] sound: usb: allow clock source validity
	interrupts
Date: Fri,  8 Apr 2016 19:52:02 +0200
Message-ID: <1460137922-8993-2-git-send-email-daniel@zonque.org>
References: <1460137922-8993-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ECF426531F
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 19:52:12 +0200 (CEST)
In-Reply-To: <1460137922-8993-1-git-send-email-daniel@zonque.org>
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
Cc: tiwai@suse.de, orm.finnendahl@selma.hfmdk-frankfurt.de, clemens@ladisch.de, jan.baumgart@selma.hfmdk-frankfurt.de, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

miniDSP USBStreamer UAC2 devices send clock validity changes with the
control field set to zero. The current interrupt handler ignores all
packets if the control field does not match the mixer element's, but
it really should only do that in case that field is needed to
distinguish multiple elements with the same ID.

This patch implements a logic that lets notifications packets pass
if the element ID is unique for a given device.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/usb/mixer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 973274b..aa6f16e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2371,6 +2371,7 @@ static void snd_usb_mixer_interrupt_v2(struct usb_mixer_interface *mixer,
 	__u8 unitid = (index >> 8) & 0xff;
 	__u8 control = (value >> 8) & 0xff;
 	__u8 channel = value & 0xff;
+	unsigned int count = 0;
 
 	if (channel >= MAX_CHANNELS) {
 		usb_audio_dbg(mixer->chip,
@@ -2379,6 +2380,12 @@ static void snd_usb_mixer_interrupt_v2(struct usb_mixer_interface *mixer,
 		return;
 	}
 
+	for (list = mixer->id_elems[unitid]; list; list = list->next_id_elem)
+		count++;
+
+	if (count == 0)
+		return;
+
 	for (list = mixer->id_elems[unitid]; list; list = list->next_id_elem) {
 		struct usb_mixer_elem_info *info;
 
@@ -2386,7 +2393,7 @@ static void snd_usb_mixer_interrupt_v2(struct usb_mixer_interface *mixer,
 			continue;
 
 		info = (struct usb_mixer_elem_info *)list;
-		if (info->control != control)
+		if (count > 1 && info->control != control)
 			continue;
 
 		switch (attribute) {
-- 
2.4.3
