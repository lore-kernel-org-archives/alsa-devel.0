From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/11] ALSA: bebob: loosen up severity of
	checking continuity for BeBoB v3 quirk
Date: Sun, 14 Jun 2015 12:49:35 +0900
Message-ID: <1434253777-433-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 32678260505
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 05:49:46 +0200 (CEST)
In-Reply-To: <1434253777-433-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: kim@incendio.no, alsa-devel@alsa-project.org, jh1ood@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

PrismSound Orpheus, Behringer UFX1604 and FCA610 work with BeBoB v3, and
they're confirmed to transmit discontinuous packets in the beginning of
streaming.

payload    CIP headers
  8        0x00070000 0x9002FFFF
  8        0x00070000 0x9002FFFF
  8        0x00070000 0x9002FFFF
  8        0x00070008 0x9002FFFF <-
  8        0x00070008 0x9002FFFF
  8        0x00070008 0x9002FFFF
  8        0x00070008 0x9002FFFF
  8        0x00070008 0x9002FFFF
  8        0x00070008 0x9002FFFF
232        0x00070000 0x9002E798 <-
232        0x00070008 0x9002FB99
232        0x00070010 0x90021398
  8        0x00070018 0x9002FFFF
(This sample was got with Behringer FCA610 and FFADO library.)

This commit sets CIP_EMPTY_HAS_WRONG_DBC and CIP_SKIP_DBC_ZERO_CHECK to
ignore these discontinuities.

Tested-by: Kim Tore Jensen <kim@incendio.no>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 9c810f9..d0df6c1 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -540,6 +540,17 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 	/* See comments in next function */
 	init_completion(&bebob->bus_reset);
 	bebob->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK;
+
+	/*
+	 * BeBoB v3 transfers packets with these qurks:
+	 *  - In the beginning of streaming, the value of dbc is incremented
+	 *    even if no data blocks are transferred.
+	 *  - The value of dbc is reset suddenly.
+	 */
+	if (bebob->version > 2)
+		bebob->tx_stream.flags |= CIP_EMPTY_HAS_WRONG_DBC |
+					  CIP_SKIP_DBC_ZERO_CHECK;
+
 	/*
 	 * At high sampling rate, M-Audio special firmware transmits empty
 	 * packet with the value of dbc incremented by 8 but the others are
-- 
2.1.4
