From: Joe Perches <joe@perches.com>
Subject: [PATCH 18/18] ALSA: opl4: Move inline before return
	type
Date: Wed,  5 Jul 2017 13:02:27 -0700
Message-ID: <e19de389484090a3059d17584d5a342db90889e5.1499284835.git.joe@perches.com>
References: <cover.1499284835.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0066.hostedemail.com
 [216.40.44.66]) by alsa0.perex.cz (Postfix) with ESMTP id C5B94267031
 for <alsa-devel@alsa-project.org>; Wed,  5 Jul 2017 22:03:14 +0200 (CEST)
In-Reply-To: <cover.1499284835.git.joe@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>, Clemens Ladisch <clemens@ladisch.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Make the code like the rest of the kernel.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/drivers/opl4/opl4_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/opl4/opl4_lib.c b/sound/drivers/opl4/opl4_lib.c
index bc345d564f8d..db76a5bf2bd2 100644
--- a/sound/drivers/opl4/opl4_lib.c
+++ b/sound/drivers/opl4/opl4_lib.c
@@ -29,7 +29,7 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_DESCRIPTION("OPL4 driver");
 MODULE_LICENSE("GPL");
 
-static void inline snd_opl4_wait(struct snd_opl4 *opl4)
+static inline void snd_opl4_wait(struct snd_opl4 *opl4)
 {
 	int timeout = 10;
 	while ((inb(opl4->fm_port) & OPL4_STATUS_BUSY) && --timeout > 0)
-- 
2.10.0.rc2.1.g053435c
