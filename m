From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] virmidi: use unsigned 1-bit fields
Date: Wed, 16 Feb 2005 15:55:07 -0800
Message-ID: <20050216155507.7e85092f.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6175C25D
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2005 00:55:10 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Can't have a boolean and a sign bit in 1 bit.

Fix (14) boolean/bitfield sparse warning:
include/sound/seq_virmidi.h:41:16: warning: dubious one-bit signed bitfield

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 include/sound/seq_virmidi.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./include/sound/seq_virmidi.h~sound_virmidi_bool ./include/sound/seq_virmidi.h
--- ./include/sound/seq_virmidi.h~sound_virmidi_bool	2004-12-24 13:35:29.000000000 -0800
+++ ./include/sound/seq_virmidi.h	2005-02-15 19:41:09.086122328 -0800
@@ -38,7 +38,7 @@ typedef struct _snd_virmidi {
 	int seq_mode;
 	int client;
 	int port;
-	int trigger: 1;
+	unsigned int trigger: 1;
 	snd_midi_event_t *parser;
 	snd_seq_event_t event;
 	snd_virmidi_dev_t *rdev;


---


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
