From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: firewire-motu: cancel chunk
	alignment for protocol version 2
Date: Mon, 18 Jun 2018 21:07:54 +0900
Message-ID: <20180618120755.19880-5-o-takashi@sakamocchi.jp>
References: <20180618120755.19880-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id D7167267707
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:08:36 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so7433492pgl.8
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 05:08:36 -0700 (PDT)
In-Reply-To: <20180618120755.19880-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

For MOTU protocol version 2, this driver arranges the number of data
chunks to align chunks to quadlet data channel. However, MOTU Traveler
has padding bytes in the end of data block at high clock mode.

This commit removes the arrangement. Fortunately, at low and middle clock
mode, supported model for v2 protocol (828mkII) gets no influence from this
change because all of combination for data chunks are just aligned to
quadlet data channel.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-protocol-v2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/motu/motu-protocol-v2.c b/sound/firewire/motu/motu-protocol-v2.c
index f25b1ba118a2..e5bd3ac02300 100644
--- a/sound/firewire/motu/motu-protocol-v2.c
+++ b/sound/firewire/motu/motu-protocol-v2.c
@@ -173,12 +173,9 @@ static void calculate_fixed_part(struct snd_motu_packet_format *formats,
 	pcm_chunks[0] += 2;
 	pcm_chunks[1] += 2;
 
-	/* This part should be multiples of 4. */
-	formats->fixed_part_pcm_chunks[0] = round_up(2 + pcm_chunks[0], 4) - 2;
-	formats->fixed_part_pcm_chunks[1] = round_up(2 + pcm_chunks[1], 4) - 2;
-	if (flags & SND_MOTU_SPEC_SUPPORT_CLOCK_X4)
-		formats->fixed_part_pcm_chunks[2] =
-					round_up(2 + pcm_chunks[2], 4) - 2;
+	formats->fixed_part_pcm_chunks[0] = pcm_chunks[0];
+	formats->fixed_part_pcm_chunks[1] = pcm_chunks[1];
+	formats->fixed_part_pcm_chunks[2] = pcm_chunks[2];
 }
 
 static void calculate_differed_part(struct snd_motu_packet_format *formats,
-- 
2.14.1
