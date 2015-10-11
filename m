From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: continue packet processing
	at detecting wrong CIP headers
Date: Sun, 11 Oct 2015 22:33:50 +0900
Message-ID: <1444570430-18077-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 91491260688
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 15:33:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In firewire-lib, isochronous packet streaming is stopped when detecting
wrong value for FMT field of CIP headers. Although this is appropriate
to IEC 61883-1 and 6, some BeBoB based devices with vendors' customization
use invalid value to FMT field of CIP headers in the beginning of
streaming.

$ journalctl
  snd-bebob fw1.0: Detect unexpected protocol: 01000000 8000ffff

I got this log with M-Audio FireWire 1814. In this line, the value of FMT
field is 0x00, while it should be 0x10 in usual AMDTP.

Except for the beginning, these devices continue to transfer packets with
valid value for FMT field, except for the beginning. Therefore, in this
case, firewire-lib should continue to process packets. The former
implementation of firewire-lib performs it.

This commit loosens the handling of wrong value, to continue packet
processing in the case.

Fixes: 414ba022a528('ALSA: firewire-lib: add support arbitrary value for fmt/fdf fields in CIP header')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index fa10b58..ed29026 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -468,10 +468,12 @@ static int handle_in_packet(struct amdtp_stream *s,
 	/* Check valid protocol or not. */
 	fmt = (cip_header[1] & CIP_FMT_MASK) >> CIP_FMT_SHIFT;
 	if (fmt != s->fmt) {
-		dev_err(&s->unit->device,
-			"Detect unexpected protocol: %08x %08x\n",
-			cip_header[0], cip_header[1]);
-		return -EIO;
+		dev_info_ratelimited(&s->unit->device,
+				     "Detect unexpected protocol: %08x %08x\n",
+				     cip_header[0], cip_header[1]);
+		*data_blocks = 0;
+		pcm_frames = 0;
+		goto end;
 	}
 
 	/* Calculate data blocks */
-- 
2.1.4
