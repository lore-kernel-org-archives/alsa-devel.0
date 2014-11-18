From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: fix kerneldoc errors
Date: Tue, 18 Nov 2014 23:59:40 +0900
Message-ID: <1416322780-16097-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id D1B5D260492
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 15:59:45 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Complete missing parameters, correct wrong reference, and add an explaination
about the differences between the latest specification and our implementation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.h | 24 ++++++++++++++++++++++--
 sound/firewire/cmp.c   |  2 ++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 4823c08..e6e8926 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -23,7 +23,7 @@
  *	corresponds to the end of event in the packet. Out of IEC 61883.
  * @CIP_WRONG_DBS: Only for in-stream. The value of dbs is wrong in in-packets.
  *	The value of data_block_quadlets is used instead of reported value.
- * @SKIP_DBC_ZERO_CHECK: Only for in-stream.  Packets with zero in dbc is
+ * @CIP_SKIP_DBC_ZERO_CHECK: Only for in-stream.  Packets with zero in dbc is
  *	skipped for detecting discontinuity.
  * @CIP_SKIP_INIT_DBC_CHECK: Only for in-stream. The value of dbc in first
  *	packet is not continuous from an initial value.
@@ -43,7 +43,27 @@ enum cip_flags {
 };
 
 /**
- * enum cip_sfc - a stream's sample rate
+ * enum cip_sfc - supported Sampling Frequency Codes (SFCs)
+ * @CIP_SFC_32000:   32,000 data blocks
+ * @CIP_SFC_44100:   44,100 data blocks
+ * @CIP_SFC_48000:   48,000 data blocks
+ * @CIP_SFC_88200:   88,200 data blocks
+ * @CIP_SFC_96000:   96,000 data blocks
+ * @CIP_SFC_176400: 176,400 data blocks
+ * @CIP_SFC_192000: 192,000 data blocks
+ * @CIP_SFC_COUNT: the number of supported SFCs
+ *
+ * These values are used to show nominal Sampling Frequency Code in
+ * Format Dependent Field (FDF) of AMDTP packet header. In IEC 61883-6:2002,
+ * this code means the number of events per second. Actually the code
+ * represents the number of data blocks transferred per second in an AMDTP
+ * stream.
+ *
+ * In IEC 61883-6:2005, some extensions were added to support more types of
+ * data such as 'One Bit LInear Audio', therefore the meaning of SFC became
+ * different depending on the types.
+ *
+ * Currently our implementation is compatible with IEC 61883-6:2002.
  */
 enum cip_sfc {
 	CIP_SFC_32000  = 0,
diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index ba8df5a..ae3bc19 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -114,6 +114,7 @@ static int pcr_modify(struct cmp_connection *c,
  * cmp_connection_init - initializes a connection manager
  * @c: the connection manager to initialize
  * @unit: a unit of the target device
+ * @direction: input or output
  * @pcr_index: the index of the iPCR/oPCR on the target device
  */
 int cmp_connection_init(struct cmp_connection *c,
@@ -154,6 +155,7 @@ EXPORT_SYMBOL(cmp_connection_init);
 /**
  * cmp_connection_check_used - check connection is already esablished or not
  * @c: the connection manager to be checked
+ * @used: the pointer to store the result of checking the connection
  */
 int cmp_connection_check_used(struct cmp_connection *c, bool *used)
 {
-- 
2.1.0
