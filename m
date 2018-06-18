From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] ALSA: firewire-motu: suppless consumption
	for unused element of array in stack
Date: Mon, 18 Jun 2018 21:07:51 +0900
Message-ID: <20180618120755.19880-2-o-takashi@sakamocchi.jp>
References: <20180618120755.19880-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f65.google.com (mail-pl0-f65.google.com
 [209.85.160.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6ED40267642
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:08:27 +0200 (CEST)
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so8922031plp.3
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 05:08:27 -0700 (PDT)
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

In MOTU firewire protocol, data block consists of 24 bit data chunks except
for one quadlet for source packet header (SPH). The number of data chunk in
a data block is different between three clock modes; low, middle and high.
When unit supports ADAT on optical interface, the data block includes some
chunks for ADAT channels. These ADAT chunks are unavailable at high mode.

This driver has local functions to calculate the number of ADAT chunks. But
They uses stack for three clock modes. This is useless for higher mode.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-protocol-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/motu/motu-protocol-v2.c b/sound/firewire/motu/motu-protocol-v2.c
index 525b746330be..a51fd196d884 100644
--- a/sound/firewire/motu/motu-protocol-v2.c
+++ b/sound/firewire/motu/motu-protocol-v2.c
@@ -176,7 +176,7 @@ static void calculate_differed_part(struct snd_motu_packet_format *formats,
 				    enum snd_motu_spec_flags flags,
 				    u32 data, u32 mask, u32 shift)
 {
-	unsigned char pcm_chunks[3] = {0, 0};
+	unsigned char pcm_chunks[2] = {0, 0};
 
 	/*
 	 * When optical interfaces are configured for S/PDIF (TOSLINK),
-- 
2.14.1
