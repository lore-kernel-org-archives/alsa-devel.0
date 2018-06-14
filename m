From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v2 3/4] ALSA: usb-audio: UAC3. Add insertion
	control for BADD.
Date: Thu, 14 Jun 2018 15:05:57 +0100
Message-ID: <20180614140558.28277-4-jorge.sanjuan@codethink.co.uk>
References: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
 <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 47204267645
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 16:06:03 +0200 (CEST)
In-Reply-To: <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk>
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

The HEADSET ADAPTER profile for BADD devices is meant to support
Insertion Control for the Input and Output Terminals of the headset.

This patch defines the BADD inferred input and output terminals and
builds the connector controls.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 34fef71e0330..03b8a2ac93c8 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2918,6 +2918,23 @@ static int snd_usb_mixer_controls_badd(struct usb_mixer_interface *mixer,
 				       UAC3_BADD_FU_ID7, map->map);
 	}
 
+	/* Insertion Control */
+	if (f->subclass == UAC3_FUNCTION_SUBCLASS_HEADSET_ADAPTER) {
+		struct usb_audio_term iterm, oterm;
+
+		/* Input Term - Insertion control */
+		memset(&iterm, 0, sizeof(iterm));
+		iterm.id = UAC3_BADD_IT_ID4;
+		iterm.type = UAC_BIDIR_TERMINAL_HEADSET;
+		build_connector_control(mixer, &iterm, true);
+
+		/* Output Term - Insertion control */
+		memset(&oterm, 0, sizeof(oterm));
+		oterm.id = UAC3_BADD_OT_ID3;
+		oterm.type = UAC_BIDIR_TERMINAL_HEADSET;
+		build_connector_control(mixer, &oterm, false);
+	}
+
 	return 0;
 }
 
-- 
2.11.0
