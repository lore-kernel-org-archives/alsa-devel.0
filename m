From: Rob Herring <robh@kernel.org>
Subject: [PATCH v3] sound: aoa: Convert to using %pOF instead
	of full_name
Date: Mon,  7 Aug 2017 18:29:19 -0500
Message-ID: <20170807232919.30247-2-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f193.google.com (mail-yw0-f193.google.com
 [209.85.161.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DD33126733B
 for <alsa-devel@alsa-project.org>; Tue,  8 Aug 2017 01:29:26 +0200 (CEST)
Received: by mail-yw0-f193.google.com with SMTP id u207so1238362ywc.0
 for <alsa-devel@alsa-project.org>; Mon, 07 Aug 2017 16:29:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org
---
v3: Split aoa to separate patch

 sound/aoa/codecs/tas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index 733b6365dad6..15c05755d270 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -905,8 +905,8 @@ static int tas_i2c_probe(struct i2c_client *client,
 		goto fail;
 	}
 	printk(KERN_DEBUG
-	       "snd-aoa-codec-tas: tas found, addr 0x%02x on %s\n",
-	       (unsigned int)client->addr, node->full_name);
+	       "snd-aoa-codec-tas: tas found, addr 0x%02x on %pOF\n",
+	       (unsigned int)client->addr, node);
 	return 0;
  fail:
 	mutex_destroy(&tas->mtx);
-- 
2.11.0
