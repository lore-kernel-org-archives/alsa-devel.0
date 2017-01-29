From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 18/19] firewire-lib: add a quirk of packet
	without valid EOH in CIP format
Date: Sun, 29 Jan 2017 12:54:16 +0900
Message-ID: <20170129035417.2095-19-o-takashi@sakamocchi.jp>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C65AB266A55
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2017 04:54:28 +0100 (CET)
In-Reply-To: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
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

In IEC 61883-1, when two quadlets CIP header is used, the top most bit in
second CIP header stands. However, packets from units with MOTU protocol
version 3 have a quirk without this flag. Current packet streaming layer
handles this as protocol error.

This commit adds a new enumeration constant for this quirk, to handle MOTU
protocol version 3.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 5 +++--
 sound/firewire/amdtp-stream.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index f9d12f4..112ad03 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -480,8 +480,9 @@ static int handle_in_packet(struct amdtp_stream *s,
 	 * This module supports 'Two-quadlet CIP header with SYT field'.
 	 * For convenience, also check FMT field is AM824 or not.
 	 */
-	if (((cip_header[0] & CIP_EOH_MASK) == CIP_EOH) ||
-	    ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH)) {
+	if ((((cip_header[0] & CIP_EOH_MASK) == CIP_EOH) ||
+	     ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH)) &&
+	    (!(s->flags & CIP_HEADER_WITHOUT_EOH))) {
 		dev_info_ratelimited(&s->unit->device,
 				"Invalid CIP header for AMDTP: %08X:%08X\n",
 				cip_header[0], cip_header[1]);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index d2a3163..a31dfd8 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -29,6 +29,8 @@
  * @CIP_JUMBO_PAYLOAD: Only for in-stream. The number of data blocks in an
  *	packet is larger than IEC 61883-6 defines. Current implementation
  *	allows 5 times as large as IEC 61883-6 defines.
+ * @CIP_HEADER_WITHOUT_EOH: Only for in-stream. CIP Header doesn't include
+ *	valid EOH.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -39,6 +41,7 @@ enum cip_flags {
 	CIP_SKIP_DBC_ZERO_CHECK	= 0x10,
 	CIP_EMPTY_HAS_WRONG_DBC	= 0x20,
 	CIP_JUMBO_PAYLOAD	= 0x40,
+	CIP_HEADER_WITHOUT_EOH	= 0x80,
 };
 
 /**
-- 
2.9.3
