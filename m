From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/43] ALSA: control: Allow to pass items zero
	to snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:10:39 +0200
Message-ID: <1413886279-18704-4-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BAD7266634
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0A963ACA1
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 10:11:23 +0000 (UTC)
In-Reply-To: <1413886279-18704-1-git-send-email-tiwai@suse.de>
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

Although this is weird, some drivers want to allow empty control
elements intentionally, e.g. the number of items may change depending
on the firmware status.  Let the function simply returning in such a
case.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index f95df84437e1..5c35bbaf881e 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1745,6 +1745,8 @@ int snd_ctl_enum_info(struct snd_ctl_elem_info *info, unsigned int channels,
 	info->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	info->count = channels;
 	info->value.enumerated.items = items;
+	if (!items)
+		return 0;
 	if (info->value.enumerated.item >= items)
 		info->value.enumerated.item = items - 1;
 	WARN(strlen(names[info->value.enumerated.item]) >= sizeof(info->value.enumerated.name),
-- 
2.1.2
