From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ALSA: aoa: Remove wrong i2c_set_clientdata
	in	onyx_i2c_remove()
Date: Fri, 10 Dec 2010 17:34:26 +0800
Message-ID: <1291973666.27848.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BC4AF243C6
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 10:27:52 +0100 (CET)
Received: by yxs7 with SMTP id 7so2163571yxs.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 01:27:52 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It does not make sense to set clientdata to onyx in onyx_i2c_remove()
as we are going to kfree onyx.
What we really want here is i2c_set_clientdata(client, NULL);
Since the i2c core will take care of it now, so this patch just removes it.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/aoa/codecs/onyx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 91852e4..3687a6c 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -1114,7 +1114,6 @@ static int onyx_i2c_remove(struct i2c_client *client)
 	of_node_put(onyx->codec.node);
 	if (onyx->codec_info)
 		kfree(onyx->codec_info);
-	i2c_set_clientdata(client, onyx);
 	kfree(onyx);
 	return 0;
 }
-- 
1.7.2
