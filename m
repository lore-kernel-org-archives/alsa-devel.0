From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: usb-audio: localize function without
	external linkage
Date: Tue, 21 Feb 2017 05:09:19 +0900
Message-ID: <20170220200921.824-4-o-takashi@sakamocchi.jp>
References: <20170220200921.824-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 1DC90266B26
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 21:09:27 +0100 (CET)
In-Reply-To: <20170220200921.824-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: onkel@paraair.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When accessed inner a file, functions should have static qualifier for
local-linkage.

This commit fixes the bug. Sparse generated below warning.

sound/usb/mixer_us16x08.c:1043:32: warning: symbol 'snd_us16x08_create_meter_store' was not declared. Should it be static?

Fixes: d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/usb/mixer_us16x08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index d135e2e..5dae63c 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -1041,7 +1041,7 @@ static struct snd_us16x08_eq_store *snd_us16x08_create_eq_store(void)
 	return tmp;
 }
 
-struct snd_us16x08_meter_store *snd_us16x08_create_meter_store(void)
+static struct snd_us16x08_meter_store *snd_us16x08_create_meter_store(void)
 {
 	struct snd_us16x08_meter_store *tmp =
 		kzalloc(sizeof(struct snd_us16x08_meter_store), GFP_KERNEL);
-- 
2.9.3
