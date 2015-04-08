From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: ctl: fix a bug to return no
	identical information in
Date: Thu,  9 Apr 2015 02:07:16 +0900
Message-ID: <1428512838-2493-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1428512838-2493-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E20CD2606C2
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 19:07:21 +0200 (CEST)
In-Reply-To: <1428512838-2493-1-git-send-email-o-takashi@sakamocchi.jp>
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

In operations of SNDRV_CTL_IOCTL_ELEM_INFO, identical information in
returned value is cleared. This is not better to userspace application.

This commit confirms to return full identical information to the
operations.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 6d12e85..37203a6 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1042,6 +1042,8 @@ static int snd_ctl_elem_user_info(struct snd_kcontrol *kcontrol,
 	struct user_element *ue = kcontrol->private_data;
 
 	*uinfo = ue->info;
+	uinfo->id = kcontrol->id;
+
 	return 0;
 }
 
@@ -1055,6 +1057,7 @@ static int snd_ctl_elem_user_enum_info(struct snd_kcontrol *kcontrol,
 	item = uinfo->value.enumerated.item;
 
 	*uinfo = ue->info;
+	uinfo->id = kcontrol->id;
 
 	item = min(item, uinfo->value.enumerated.items - 1);
 	uinfo->value.enumerated.item = item;
-- 
2.1.0
