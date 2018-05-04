From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH v2 6/7] include: usb: audio-v3: add BADD-specific values
Date: Fri,  4 May 2018 04:24:03 +0300
Message-ID: <1525397044-15080-7-git-send-email-ruslan.bilovol@gmail.com>
References: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>, Andrew Chant <achant@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add BADD-specific predefined values to audio-v3
so usb-audio in ALSA and UAC3 gadget can use them

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 include/linux/usb/audio-v3.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/usb/audio-v3.h b/include/linux/usb/audio-v3.h
index a8959aa..38add1d 100644
--- a/include/linux/usb/audio-v3.h
+++ b/include/linux/usb/audio-v3.h
@@ -392,4 +392,30 @@ struct uac3_interrupt_data_msg {
 #define UAC3_AC_ACTIVE_INTERFACE_CONTROL	0x01
 #define UAC3_AC_POWER_DOMAIN_CONTROL		0x02
 
+/* BADD predefined Unit/Terminal values */
+#define UAC3_BADD_IT_ID1	1  /* Input Terminal ID1: bTerminalID = 1 */
+#define UAC3_BADD_FU_ID2	2  /* Feature Unit ID2: bUnitID = 2 */
+#define UAC3_BADD_OT_ID3	3  /* Output Terminal ID3: bTerminalID = 3 */
+#define UAC3_BADD_IT_ID4	4  /* Input Terminal ID4: bTerminalID = 4 */
+#define UAC3_BADD_FU_ID5	5  /* Feature Unit ID5: bUnitID = 5 */
+#define UAC3_BADD_OT_ID6	6  /* Output Terminal ID6: bTerminalID = 6 */
+#define UAC3_BADD_FU_ID7	7  /* Feature Unit ID7: bUnitID = 7 */
+#define UAC3_BADD_MU_ID8	8  /* Mixer Unit ID8: bUnitID = 8 */
+#define UAC3_BADD_CS_ID9	9  /* Clock Source Entity ID9: bClockID = 9 */
+#define UAC3_BADD_PD_ID10	10 /* Power Domain ID10: bPowerDomainID = 10 */
+#define UAC3_BADD_PD_ID11	11 /* Power Domain ID11: bPowerDomainID = 11 */
+
+/* BADD wMaxPacketSize of AS endpoints */
+#define UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_16		0x0060
+#define UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_16		0x0062
+#define UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_24		0x0090
+#define UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_24		0x0093
+#define UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_16		0x00C0
+#define UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_16		0x00C4
+#define UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_24		0x0120
+#define UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_24		0x0126
+
+/* BADD sample rate is always fixed to 48kHz */
+#define UAC3_BADD_SAMPLING_RATE				48000
+
 #endif /* __LINUX_USB_AUDIO_V3_H */
-- 
1.9.1
