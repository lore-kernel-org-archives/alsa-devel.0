From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] ALSA: usb-audio: localize one-referrer
	variable
Date: Tue, 21 Feb 2017 05:09:17 +0900
Message-ID: <20170220200921.824-2-o-takashi@sakamocchi.jp>
References: <20170220200921.824-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 20001266B2C
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

When accessed by one referrer inner a file, variables should have static
qualifier to declare local-linkage.

This commit fixes the bug. Sparse generated below warnings.
sound/usb/mixer_us16x08.c:156:13: warning: duplicate const
sound/usb/mixer_us16x08.c:156:18: warning: symbol 'route_names' was not declared. Should it be static?

Fixes: d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/usb/mixer_us16x08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 301939b..019336f 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -153,7 +153,7 @@ static const char ratio_map[] = {
 };
 
 /* route enumeration names */
-const const char *route_names[] = {
+static const char *const route_names[] = {
 	"Master Left", "Master Right", "Output 1", "Output 2", "Output 3",
 	"Output 4", "Output 5", "Output 6", "Output 7", "Output 8",
 };
-- 
2.9.3
