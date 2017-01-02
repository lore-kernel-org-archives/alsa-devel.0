From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: [PATCH v2 2/2] ALSA: usb-audio: test EP_FLAG_RUNNING at urb completion
Date: Mon,  2 Jan 2017 17:50:31 +0200
Message-ID: <20170102155031.3638-3-adi@adirat.com>
References: <20170102155031.3638-1-adi@adirat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170102155031.3638-1-adi@adirat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, perex@perex.cz, o-takashi@sakamocchi.jp
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Testing EP_FLAG_RUNNING in snd_complete_urb() before running the completion
logic allows us to save a few cpu cycles by returning early, skipping the
pending urb in case the stream was stopped; the stop logic handles the urb
and sets the completion callbacks to NULL.

Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
---
 sound/usb/endpoint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 2f0ea70a998c..c90607ebe155 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -384,6 +384,9 @@ static void snd_complete_urb(struct urb *urb)
 	if (unlikely(atomic_read(&ep->chip->shutdown)))
 		goto exit_clear;
 
+	if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep->flags)))
+		goto exit_clear;
+
 	if (usb_pipeout(ep->pipe)) {
 		retire_outbound_urb(ep, ctx);
 		/* can be stopped during retire callback */
-- 
2.11.0
