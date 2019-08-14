From: Hui Peng <benquike@gmail.com>
Subject: [PATCH] Fix an OOB bug in parse_audio_mixer_unit
Date: Tue, 13 Aug 2019 22:36:24 -0400
Message-ID: <20190814023625.21683-1-benquike@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: security@kernel.org
Cc: Hui Peng <benquike@gmail.com>, Mathias Payer <mathias.payer@nebelwelt.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, YueHaibing <yuehaibing@huawei.com>, Wenwen Wang <wang6495@umn.edu>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The `uac_mixer_unit_descriptor` shown as below is read from the
device side. In `parse_audio_mixer_unit`, `baSourceID` field is
accessed from index 0 to `bNrInPins` - 1, the current implementation
assumes that descriptor is always valid (the length  of descriptor
is no shorter than 5 + `bNrInPins`). If a descriptor read from
the device side is invalid, it may trigger out-of-bound memory
access.

```
struct uac_mixer_unit_descriptor {
	__u8 bLength;
	__u8 bDescriptorType;
	__u8 bDescriptorSubtype;
	__u8 bUnitID;
	__u8 bNrInPins;
	__u8 baSourceID[];
}
```

This patch fixes the bug by add a sanity check on the length of
the descriptor.

Signed-off-by: Hui Peng <benquike@gmail.com>
Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
---
 sound/usb/mixer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 7498b5191b68..38202ce67237 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2091,6 +2091,15 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
 	struct usb_audio_term iterm;
 	int input_pins, num_ins, num_outs;
 	int pin, ich, err;
+	int desc_len = (int) ((unsigned long) state->buffer +
+			state->buflen - (unsigned long) raw_desc);
+
+	if (desc_len < sizeof(*desc) + desc->bNrInPins) {
+		usb_audio_err(state->chip,
+			      "descriptor %d too short\n",
+			      unitid);
+		return -EINVAL;
+	}
 
 	err = uac_mixer_unit_get_channels(state, desc);
 	if (err < 0) {
-- 
2.22.1
