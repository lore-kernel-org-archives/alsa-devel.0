From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/6] ALSA: usb-audio: Put missing KERN_CONT
	prefix
Date: Thu, 31 Aug 2017 11:33:32 +0200
Message-ID: <20170831093334.9050-5-tiwai@suse.de>
References: <20170831093334.9050-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DA8A2672C0
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 11:33:37 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 50068AEE5
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 09:33:37 +0000 (UTC)
In-Reply-To: <20170831093334.9050-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

The usb-audio driver has a debug printk code without proper KERN_
prefix.  On recent kernels, KERN_CONT prefix is mandatory for
continued output lines.  Put it properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index bd9d02268724..a92e2b2a91ec 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -242,8 +242,8 @@ static void dump_urb(const char *type, const u8 *data, int length)
 {
 	snd_printk(KERN_DEBUG "%s packet: [", type);
 	for (; length > 0; ++data, --length)
-		printk(" %02x", *data);
-	printk(" ]\n");
+		printk(KERN_CONT " %02x", *data);
+	printk(KERN_CONT " ]\n");
 }
 #else
 #define dump_urb(type, data, length) /* nothing */
-- 
2.14.1
