From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: firewire-motu: add a flag for chunks
	for main 1/2 out
Date: Mon, 18 Jun 2018 21:07:52 +0900
Message-ID: <20180618120755.19880-3-o-takashi@sakamocchi.jp>
References: <20180618120755.19880-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f51.google.com (mail-pl0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 08C85267642
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:08:29 +0200 (CEST)
Received: by mail-pl0-f51.google.com with SMTP id c41-v6so8913115plj.10
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 05:08:29 -0700 (PDT)
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

This driver explicitly assumes that all of supported models have main data
chunk separated from chunk for analog ports. However, MOTU Traveler doesn't
support the separated main data chunk.

This commit adds a flag for the separated main data chunk.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-protocol-v2.c | 14 +++++++++-----
 sound/firewire/motu/motu-protocol-v3.c | 14 +++++++++-----
 sound/firewire/motu/motu.c             |  3 +++
 sound/firewire/motu/motu.h             |  1 +
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/motu/motu-protocol-v2.c b/sound/firewire/motu/motu-protocol-v2.c
index a51fd196d884..614f9b11e010 100644
--- a/sound/firewire/motu/motu-protocol-v2.c
+++ b/sound/firewire/motu/motu-protocol-v2.c
@@ -149,11 +149,15 @@ static void calculate_fixed_part(struct snd_motu_packet_format *formats,
 			pcm_chunks[1] += 2;
 		}
 	} else {
-		/*
-		 * Packets to v2 units transfer main-out-1/2 and phone-out-1/2.
-		 */
-		pcm_chunks[0] += 4;
-		pcm_chunks[1] += 4;
+		if (flags & SND_MOTU_SPEC_RX_SEPARETED_MAIN) {
+			pcm_chunks[0] += 2;
+			pcm_chunks[1] += 2;
+		}
+
+		// Packets to v2 units include 2 chunks for phone 1/2, except
+		// for 176.4/192.0 kHz.
+		pcm_chunks[0] += 2;
+		pcm_chunks[1] += 2;
 	}
 
 	/*
diff --git a/sound/firewire/motu/motu-protocol-v3.c b/sound/firewire/motu/motu-protocol-v3.c
index c7cd9864dc4d..293353991591 100644
--- a/sound/firewire/motu/motu-protocol-v3.c
+++ b/sound/firewire/motu/motu-protocol-v3.c
@@ -188,11 +188,15 @@ static void calculate_fixed_part(struct snd_motu_packet_format *formats,
 			pcm_chunks[1] += 2;
 		}
 	} else {
-		/*
-		 * Packets to v2 units transfer main-out-1/2 and phone-out-1/2.
-		 */
-		pcm_chunks[0] += 4;
-		pcm_chunks[1] += 4;
+		if (flags & SND_MOTU_SPEC_RX_SEPARETED_MAIN) {
+			pcm_chunks[0] += 2;
+			pcm_chunks[1] += 2;
+		}
+
+		// Packets to v3 units include 2 chunks for phone 1/2, except
+		// for 176.4/192.0 kHz.
+		pcm_chunks[0] += 2;
+		pcm_chunks[1] += 2;
 	}
 
 	/*
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 0d6b526105ab..445aa589582d 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -200,6 +200,7 @@ static const struct snd_motu_spec motu_828mk2 = {
 	.flags = SND_MOTU_SPEC_SUPPORT_CLOCK_X2 |
 		 SND_MOTU_SPEC_TX_MICINST_CHUNK |
 		 SND_MOTU_SPEC_TX_RETURN_CHUNK |
+		 SND_MOTU_SPEC_RX_SEPARETED_MAIN |
 		 SND_MOTU_SPEC_HAS_OPT_IFACE_A |
 		 SND_MOTU_SPEC_RX_MIDI_2ND_Q |
 		 SND_MOTU_SPEC_TX_MIDI_2ND_Q,
@@ -216,6 +217,7 @@ static const struct snd_motu_spec motu_828mk3 = {
 		 SND_MOTU_SPEC_TX_MICINST_CHUNK |
 		 SND_MOTU_SPEC_TX_RETURN_CHUNK |
 		 SND_MOTU_SPEC_TX_REVERB_CHUNK |
+		 SND_MOTU_SPEC_RX_SEPARETED_MAIN |
 		 SND_MOTU_SPEC_HAS_OPT_IFACE_A |
 		 SND_MOTU_SPEC_HAS_OPT_IFACE_B |
 		 SND_MOTU_SPEC_RX_MIDI_3RD_Q |
@@ -231,6 +233,7 @@ static const struct snd_motu_spec motu_audio_express = {
 	.flags = SND_MOTU_SPEC_SUPPORT_CLOCK_X2 |
 		 SND_MOTU_SPEC_TX_MICINST_CHUNK |
 		 SND_MOTU_SPEC_TX_RETURN_CHUNK |
+		 SND_MOTU_SPEC_RX_SEPARETED_MAIN |
 		 SND_MOTU_SPEC_RX_MIDI_2ND_Q |
 		 SND_MOTU_SPEC_TX_MIDI_3RD_Q,
 	.analog_in_ports = 2,
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 4b23cf337c4b..bced0407179e 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -86,6 +86,7 @@ enum snd_motu_spec_flags {
 	SND_MOTU_SPEC_RX_MIDI_3RD_Q	= 0x0200,
 	SND_MOTU_SPEC_TX_MIDI_2ND_Q	= 0x0400,
 	SND_MOTU_SPEC_TX_MIDI_3RD_Q	= 0x0800,
+	SND_MOTU_SPEC_RX_SEPARETED_MAIN	= 0x1000,
 };
 
 #define SND_MOTU_CLOCK_RATE_COUNT	6
-- 
2.14.1
