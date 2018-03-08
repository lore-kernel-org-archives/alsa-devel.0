From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: vmaster: Propagate slave error
Date: Thu,  8 Mar 2018 08:40:39 +0100
Message-ID: <20180308074040.16151-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 34AA8267412
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 08:40:49 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 88D41AE05
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 07:40:49 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In slave_update() of vmaster code ignores the error from the slave
get() callback and copies the values.  It's not only about the missing
error code but also that this may potentially lead to a leak of
uninitialized variables when the slave get() don't clear them.

This patch fixes slave_update() not to copy the potentially
uninitialized values when an error is returned from the slave get()
callback, and to propagate the error value properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/vmaster.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
index 8632301489fa..b67de2bb06a2 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -68,10 +68,13 @@ static int slave_update(struct link_slave *slave)
 		return -ENOMEM;
 	uctl->id = slave->slave.id;
 	err = slave->slave.get(&slave->slave, uctl);
+	if (err < 0)
+		goto error;
 	for (ch = 0; ch < slave->info.count; ch++)
 		slave->vals[ch] = uctl->value.integer.value[ch];
+ error:
 	kfree(uctl);
-	return 0;
+	return err < 0 ? err : 0;
 }
 
 /* get the slave ctl info and save the initial values */
-- 
2.16.2
