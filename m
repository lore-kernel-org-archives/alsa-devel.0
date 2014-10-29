From: Chris J Arges <chris.j.arges@canonical.com>
Subject: [PATCH v3 2/4] ALSA: usb-audio: Add
	usb_mixer_elem_enum_info
Date: Wed, 29 Oct 2014 15:56:01 -0500
Message-ID: <1414616163-14146-3-git-send-email-chris.j.arges@canonical.com>
References: <s5h1tq0egzi.wl-tiwai@suse.de>
 <1414616163-14146-1-git-send-email-chris.j.arges@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C9AD82605A5
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 21:56:10 +0100 (CET)
In-Reply-To: <1414616163-14146-1-git-send-email-chris.j.arges@canonical.com>
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

Add structure to hold enumeration control information and in addition add it
to the usb_mixer_elem_info structure. This allows this structure to be more
easily reused.

Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
---
 sound/usb/mixer.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 73b1f64..cf3967a4 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -36,10 +36,17 @@ enum {
 	USB_MIXER_U16,
 };
 
+struct usb_mixer_elem_enum_info {
+	int start;
+	int len;
+	const char * const *names;
+};
+
 struct usb_mixer_elem_info {
 	struct usb_mixer_interface *mixer;
 	struct usb_mixer_elem_info *next_id_elem; /* list of controls with same id */
 	struct snd_ctl_elem_id *elem_id;
+	const struct usb_mixer_elem_enum_info *opt; /* enum control info */
 	unsigned int id;
 	unsigned int control;	/* CS or ICN (high byte) */
 	unsigned int cmask; /* channel mask bitmap: 0 = master */
-- 
2.1.0
