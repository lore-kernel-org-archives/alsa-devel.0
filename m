From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: firewire-lib: use protocol error
	when detecting wrong value in CIP header
Date: Fri, 22 May 2015 23:21:14 +0900
Message-ID: <1432304474-6533-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id CA954265AEA
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 16:21:18 +0200 (CEST)
In-Reply-To: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
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

When detecting zero in 'dbs' field of CIP header, this packet streaming
should be aborted because of avoiding division-by-zero. This is an error
in an aspect of IEC 61883-1, thus protocol error.

This commit use EPROTO instead of EIO. Actually, the returned value is
not used for userspace and this commit has no effect.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 93cf93a..2b3e8b1 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -726,7 +726,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 			dev_err(&s->unit->device,
 				"Detect invalid value in dbs field: %08X\n",
 				cip_header[0]);
-			return -EIO;
+			return -EPROTO;
 		}
 		if (s->flags & CIP_WRONG_DBS)
 			data_block_quadlets = s->data_block_quadlets;
-- 
2.1.4
