From: Alberto Aguirre <albaguirre@gmail.com>
Subject: [PATCH 2/2] ALSA: usb-audio: add implicit fb quirk for
	Axe-Fx III
Date: Wed, 18 Apr 2018 09:35:35 -0500
Message-ID: <20180418143535.11097-3-albaguirre@gmail.com>
References: <20180418143535.11097-1-albaguirre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id F3444266E30
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 16:35:45 +0200 (CEST)
Received: by mail-oi0-f68.google.com with SMTP id e11-v6so1764889oii.11
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 07:35:45 -0700 (PDT)
In-Reply-To: <20180418143535.11097-1-albaguirre@gmail.com>
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
Cc: Alberto Aguirre <albaguirre@gmail.com>
List-Id: alsa-devel@alsa-project.org

The Axe-Fx III implicit feedback end point and the data sink endpoint
are in different interface descriptors. Add quirk to ensure a sync
endpoint is properly configured.

Signed-off-by: Alberto Aguirre <albaguirre@gmail.com>
---
 sound/usb/pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index c0746cc20ac4..ad39b3cca247 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -342,6 +342,10 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 		ep = 0x86;
 		ifnum = 2;
 		goto add_sync_ep_from_ifnum;
+	case USB_ID(0x2466, 0x8010): /* Fractal Audio Axe-Fx III */
+		ep = 0x81;
+		ifnum = 2;
+		goto add_sync_ep_from_ifnum;
 	case USB_ID(0x1397, 0x0002): /* Behringer UFX1204 */
 		ep = 0x81;
 		ifnum = 1;
-- 
2.14.1
