From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] Revert "ALSA: firewire-lib: change structure
	member with proper type"
Date: Thu,  5 Jan 2017 09:41:31 +0900
Message-ID: <20170105004131.19202-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 6658A2675E7
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2017 01:41:36 +0100 (CET)
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

This reverts commit 6b7e95d1336b9eb0d4c6db190ce756480496bd13. This commit
is based on a concern about value of the given parameter. It's expected
to be ORed value with some enumeration-constants, thus often it can not be
one of the enumeration-constants. I understood that this is out of
specification and causes implementation-dependent issues.

In C language specification, enumerated type can be interpreted as an
integer type, in which all of enumeration-constants in corresponding
enumerator-list can be stored. Implementations can select one of char,
signed int and unsigned int as its type, and this selection is
implementation-dependent.

In GCC, a signed integer is selected when at least one of
enumeration-constants has negative value, else an unsigned integer is
selected. This behaviour can be switched by -fshort-enums to short type.
Anyway, the type can be decided after scanning all of
enumeration-constants.

Totally, there's no rules to constrain the value of enumerated type to
be one of enumeration-constants. In short, in enumerated type, decision
of actual type for the type is the most important and
enumeration-constants are just used for the decision, thus it's permitted
to have an integer value in a range of enumeration-constants. In our case,
actual type for the type is currently deterministic to be either char or
unsigned int. Under GCC, it's unsigned int.
---
 sound/firewire/amdtp-stream.c | 2 +-
 sound/firewire/amdtp-stream.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 8ce93cd..00060c4 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -69,7 +69,7 @@ static void pcm_period_tasklet(unsigned long data);
  * @protocol_size: the size to allocate newly for protocol
  */
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-		      enum amdtp_stream_direction dir, int flags,
+		      enum amdtp_stream_direction dir, enum cip_flags flags,
 		      unsigned int fmt,
 		      amdtp_stream_process_data_blocks_t process_data_blocks,
 		      unsigned int protocol_size)
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 7be2142..c1bc7fa 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -93,7 +93,7 @@ typedef unsigned int (*amdtp_stream_process_data_blocks_t)(
 						unsigned int *syt);
 struct amdtp_stream {
 	struct fw_unit *unit;
-	int flags;
+	enum cip_flags flags;
 	enum amdtp_stream_direction direction;
 	struct mutex mutex;
 
@@ -137,7 +137,7 @@ struct amdtp_stream {
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-		      enum amdtp_stream_direction dir, int flags,
+		      enum amdtp_stream_direction dir, enum cip_flags flags,
 		      unsigned int fmt,
 		      amdtp_stream_process_data_blocks_t process_data_blocks,
 		      unsigned int protocol_size);
-- 
2.9.3
