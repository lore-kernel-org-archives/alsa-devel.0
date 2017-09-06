From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: bebob: Improve a size determination
 in parse_stream_formation()
Date: Wed, 6 Sep 2017 12:24:22 +0200
Message-ID: <3092a93b-9991-eca8-bc77-5c973355477e@users.sourceforge.net>
References: <85f95150-9cec-7a53-7692-837ba543e1ec@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 32763266E02
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 12:24:57 +0200 (CEST)
In-Reply-To: <85f95150-9cec-7a53-7692-837ba543e1ec@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Sep 2017 11:55:45 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/firewire/bebob/bebob_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 211ff43207d6..a26863b82330 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -736,7 +736,7 @@ parse_stream_formation(u8 *buf, unsigned int len,
 		return -ENOSYS;
 
 	/* Avoid double count by different entries for the same rate. */
-	memset(&formation[i], 0, sizeof(struct snd_bebob_stream_formation));
+	memset(&formation[i], 0, sizeof(*formation));
 
 	for (e = 0; e < buf[4]; e++) {
 		channels = buf[5 + e * 2];
-- 
2.14.1
