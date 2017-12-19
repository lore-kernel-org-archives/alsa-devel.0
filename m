From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v1 1/6] usb: audio: Add bi-directional terminal
	types.
Date: Tue, 19 Dec 2017 09:14:06 +0000
Message-ID: <20171219091411.16267-2-jorge.sanjuan@codethink.co.uk>
References: <20171219091411.16267-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AADE2675FD
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 10:14:17 +0100 (CET)
In-Reply-To: <20171219091411.16267-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: linux-kernel@lists.codethink.co.uk, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, ci005-internal@lists.codethink.co.uk
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 include/uapi/linux/usb/audio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
index c6f5b096c594..ca33f47a2fd4 100644
--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -229,6 +229,14 @@ struct uac1_output_terminal_descriptor {
 #define UAC_OUTPUT_TERMINAL_COMMUNICATION_SPEAKER	0x306
 #define UAC_OUTPUT_TERMINAL_LOW_FREQ_EFFECTS_SPEAKER	0x307
 
+/* Terminals - 2.4 Bi-directional Terminal Types */
+#define UAC_BIDIR_TERMINAL_UNDEFINED			0x400
+#define UAC_BIDIR_TERMINAL_HANDSET			0x401
+#define UAC_BIDIR_TERMINAL_HEADSET			0x402
+#define UAC_BIDIR_TERMINAL_SPEAKER_PHONE		0x403
+#define UAC_BIDIR_TERMINAL_ECHO_SUPPRESSING		0x404
+#define UAC_BIDIR_TERMINAL_ECHO_CANCELING		0x405
+
 /* Set bControlSize = 2 as default setting */
 #define UAC_DT_FEATURE_UNIT_SIZE(ch)		(7 + ((ch) + 1) * 2)
 
-- 
2.11.0
