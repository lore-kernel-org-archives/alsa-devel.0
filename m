From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: vmaster: Zero-clear ctl before
	calling slave get
Date: Thu,  8 Mar 2018 08:40:40 +0100
Message-ID: <20180308074040.16151-2-tiwai@suse.de>
References: <20180308074040.16151-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3363C267403
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 08:40:49 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8DDFDAE19
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 07:40:49 +0000 (UTC)
In-Reply-To: <20180308074040.16151-1-tiwai@suse.de>
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

Use kzalloc() instead of kmalloc() so that we don't need to rely fully
on the slave get() callback to clear the control value that might be
copied to user-space.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/vmaster.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
index b67de2bb06a2..9e96186742d0 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -63,7 +63,7 @@ static int slave_update(struct link_slave *slave)
 	struct snd_ctl_elem_value *uctl;
 	int err, ch;
 
-	uctl = kmalloc(sizeof(*uctl), GFP_KERNEL);
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (!uctl)
 		return -ENOMEM;
 	uctl->id = slave->slave.id;
-- 
2.16.2
