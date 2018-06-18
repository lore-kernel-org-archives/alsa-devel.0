From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/5] ALSA: firewire-motu: add a flag for
	AES/EBU on XLR interface
Date: Mon, 18 Jun 2018 21:07:53 +0900
Message-ID: <20180618120755.19880-4-o-takashi@sakamocchi.jp>
References: <20180618120755.19880-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C1D42675E4
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:08:33 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id q1-v6so8065426pff.13
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 05:08:33 -0700 (PDT)
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

MOTU Traveler supports AES/EBU on XLR interface and data block of rx/tx
packet includes two chunk for the interface. This commit adds a flag
for this purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-protocol-v2.c | 5 +++++
 sound/firewire/motu/motu-protocol-v3.c | 5 +++++
 sound/firewire/motu/motu.h             | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/motu/motu-protocol-v2.c b/sound/firewire/motu/motu-protocol-v2.c
index 614f9b11e010..f25b1ba118a2 100644
--- a/sound/firewire/motu/motu-protocol-v2.c
+++ b/sound/firewire/motu/motu-protocol-v2.c
@@ -160,6 +160,11 @@ static void calculate_fixed_part(struct snd_motu_packet_format *formats,
 		pcm_chunks[1] += 2;
 	}
 
+	if (flags & SND_MOTU_SPEC_HAS_AESEBU_IFACE) {
+		pcm_chunks[0] += 2;
+		pcm_chunks[1] += 2;
+	}
+
 	/*
 	 * All of v2 models have a pair of coaxial interfaces for digital in/out
 	 * port. At 44.1/48.0/88.2/96.0 kHz, packets includes PCM from these
diff --git a/sound/firewire/motu/motu-protocol-v3.c b/sound/firewire/motu/motu-protocol-v3.c
index 293353991591..7cc80a05e91f 100644
--- a/sound/firewire/motu/motu-protocol-v3.c
+++ b/sound/firewire/motu/motu-protocol-v3.c
@@ -199,6 +199,11 @@ static void calculate_fixed_part(struct snd_motu_packet_format *formats,
 		pcm_chunks[1] += 2;
 	}
 
+	if (flags & SND_MOTU_SPEC_HAS_AESEBU_IFACE) {
+		pcm_chunks[0] += 2;
+		pcm_chunks[1] += 2;
+	}
+
 	/*
 	 * At least, packets have two data chunks for S/PDIF on coaxial
 	 * interface.
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index bced0407179e..2764bcaab327 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -79,7 +79,7 @@ enum snd_motu_spec_flags {
 	SND_MOTU_SPEC_TX_MICINST_CHUNK	= 0x0004,
 	SND_MOTU_SPEC_TX_RETURN_CHUNK	= 0x0008,
 	SND_MOTU_SPEC_TX_REVERB_CHUNK	= 0x0010,
-	SND_MOTU_SPEC_TX_AESEBU_CHUNK	= 0x0020,
+	SND_MOTU_SPEC_HAS_AESEBU_IFACE	= 0x0020,
 	SND_MOTU_SPEC_HAS_OPT_IFACE_A	= 0x0040,
 	SND_MOTU_SPEC_HAS_OPT_IFACE_B	= 0x0080,
 	SND_MOTU_SPEC_RX_MIDI_2ND_Q	= 0x0100,
-- 
2.14.1
