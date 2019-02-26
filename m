From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-motu: fix construction of PCM frame for capture direction
Date: Tue, 26 Feb 2019 13:38:37 +0900
Message-ID: <20190226043837.31815-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In data blocks of common isochronous packet for MOTU devices, PCM
frames are multiplexed in a shape of '24 bit * 4 Audio Pack', described
in IEC 61883-6. The frames are not aligned to quadlet.

For capture PCM substream, ALSA firewire-motu driver constructs PCM
frames by reading data blocks byte-by-byte. However this operation
includes bug for lower byte of the PCM sample. This brings invalid
content of the PCM samples.

This commit fixes the bug.

Reported-by: Peter Sjöberg <autopeter@gmail.com>
Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 4641c9394010 ("ALSA: firewire-motu: add MOTU specific protocol layer")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/amdtp-motu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index f0555a24d90e..6c9b743ea74b 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -136,7 +136,9 @@ static void read_pcm_s32(struct amdtp_stream *s,
 		byte = (u8 *)buffer + p->pcm_byte_offset;
 
 		for (c = 0; c < channels; ++c) {
-			*dst = (byte[0] << 24) | (byte[1] << 16) | byte[2];
+			*dst = (byte[0] << 24) |
+			       (byte[1] << 16) |
+			       (byte[2] << 8);
 			byte += 3;
 			dst++;
 		}
-- 
2.19.1
