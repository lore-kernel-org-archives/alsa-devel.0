From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v1 3/6] ALSA: usb: UAC3. Add initial mixer
	support.
Date: Tue, 19 Dec 2017 09:14:08 +0000
Message-ID: <20171219091411.16267-4-jorge.sanjuan@codethink.co.uk>
References: <20171219091411.16267-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 641E8267600
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 10:14:22 +0100 (CET)
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
 include/uapi/linux/usb/audio.h | 13 ++++++++++---
 sound/usb/mixer.c              | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
index ca33f47a2fd4..24a41afe6bae 100644
--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -292,9 +292,16 @@ static inline __u8 uac_mixer_unit_iChannelNames(struct uac_mixer_unit_descriptor
 static inline __u8 *uac_mixer_unit_bmControls(struct uac_mixer_unit_descriptor *desc,
 					      int protocol)
 {
-	return (protocol == UAC_VERSION_1) ?
-		&desc->baSourceID[desc->bNrInPins + 4] :
-		&desc->baSourceID[desc->bNrInPins + 6];
+	switch (protocol) {
+	case UAC_VERSION_1:
+		return &desc->baSourceID[desc->bNrInPins + 4];
+	case UAC_VERSION_2:
+		return &desc->baSourceID[desc->bNrInPins + 6];
+	case UAC_VERSION_3:
+		return &desc->baSourceID[desc->bNrInPins + 2];
+	default:
+		return NULL;
+	}
 }
 
 static inline __u8 uac_mixer_unit_iMixer(struct uac_mixer_unit_descriptor *desc)
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index c34a1f74ea56..4158be9ef43f 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -847,6 +847,30 @@ static int check_input_term(struct mixer_build *state, int id,
 				term->name = le16_to_cpu(d->wClockSourceStr);
 				return 0;
 			}
+			case UAC3_MIXER_UNIT: {
+				struct uac_mixer_unit_descriptor *d = p1;
+				struct uac3_cluster_header_descriptor c_header;
+				u16 cluster_id;
+
+				cluster_id = le16_to_cpu(d->baSourceID[d->bNrInPins]);
+
+				err = snd_usb_ctl_msg(state->chip->dev,
+						usb_rcvctrlpipe(state->chip->dev, 0),
+						UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
+						USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+						cluster_id,
+						snd_usb_ctrl_intf(state->chip),
+						&c_header, sizeof(c_header));
+				if (err < 0)
+					return err;
+				else if (err != sizeof(c_header))
+					return -EIO;
+
+				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				term->channels = c_header.bNrChannels;
+
+				return 0;
+			}
 			default:
 				return -ENODEV;
 			}
-- 
2.11.0
