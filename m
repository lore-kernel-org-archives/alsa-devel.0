From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 1/2] ALSA: usb-audio: Add bi-directional
	terminal types.
Date: Tue, 12 Jun 2018 15:32:00 +0100
Message-ID: <20180612143201.29988-2-jorge.sanjuan@codethink.co.uk>
References: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id E90CC266E8B
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 16:32:19 +0200 (CEST)
In-Reply-To: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ruslan.bilovol@gmail.com
List-Id: alsa-devel@alsa-project.org

Define the bi-directional USB terminal types for audio devices.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 include/uapi/linux/usb/audio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
index 13d98e6e0db1..74e520fb944f 100644
--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -230,6 +230,14 @@ struct uac1_output_terminal_descriptor {
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
