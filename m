From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/12] firewire-lib: Use ARRAY_SIZE() instead
	of sizeof() for correct loop limit
Date: Wed, 28 May 2014 00:14:36 +0900
Message-ID: <1401203687-4189-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EE79265848
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:15:14 +0200 (CEST)
In-Reply-To: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, dan.carpenter@oracle.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit fixes a big for loop count with array. The limitation of loop
count should be calcurated with the number of elements in the array, not
with the number of bytes.

Aditionally, this commit apply the same declaration as a prototype in header
for the array.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index e573f25..31dd1cf 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -107,7 +107,7 @@ const unsigned int amdtp_syt_intervals[CIP_SFC_COUNT] = {
 };
 EXPORT_SYMBOL(amdtp_syt_intervals);
 
-const unsigned int amdtp_rate_table[] = {
+const unsigned int amdtp_rate_table[CIP_SFC_COUNT] = {
 	[CIP_SFC_32000]  =  32000,
 	[CIP_SFC_44100]  =  44100,
 	[CIP_SFC_48000]  =  48000,
@@ -198,7 +198,7 @@ void amdtp_stream_set_parameters(struct amdtp_stream *s,
 	    WARN_ON(midi_channels > AMDTP_MAX_CHANNELS_FOR_MIDI))
 		return;
 
-	for (sfc = 0; sfc < sizeof(amdtp_rate_table); ++sfc)
+	for (sfc = 0; sfc < ARRAY_SIZE(amdtp_rate_table); ++sfc)
 		if (amdtp_rate_table[sfc] == rate)
 			goto sfc_found;
 	WARN_ON(1);
-- 
1.8.3.2
