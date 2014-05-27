From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/12] firewire-lib: Fix sparse warning of
	incorrect type in assignment
Date: Wed, 28 May 2014 00:14:37 +0900
Message-ID: <1401203687-4189-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 312C126585E
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

__be32 value should not be assigned directly to bool value.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/cmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index d31a403..ba8df5a 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -164,7 +164,9 @@ int cmp_connection_check_used(struct cmp_connection *c, bool *used)
 			c->resources.unit, TCODE_READ_QUADLET_REQUEST,
 			pcr_address(c), &pcr, 4, 0);
 	if (err >= 0)
-		*used = (pcr & cpu_to_be32(PCR_BCAST_CONN | PCR_P2P_CONN_MASK));
+		*used = !!(pcr & cpu_to_be32(PCR_BCAST_CONN |
+					     PCR_P2P_CONN_MASK));
+
 	return err;
 }
 EXPORT_SYMBOL(cmp_connection_check_used);
-- 
1.8.3.2
