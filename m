From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2] ALSA: control: Add sanity checks for user
	ctl id name string
Date: Thu, 12 Mar 2015 07:41:01 +0100
Message-ID: <1426142461-16095-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C789D265554
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 07:41:04 +0100 (CET)
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
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

There was no check about the id string of user control elements, so we
accepted even a control element with an empty string, which is
obviously bogus.  This patch adds more sanity checks of id strings.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: fix typos, thinkos

 sound/core/control.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 35324a8e83c8..eeb691d1911f 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1170,6 +1170,10 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 
 	if (info->count < 1)
 		return -EINVAL;
+	if (!*info->id.name)
+		return -EINVAL;
+	if (strnlen(info->id.name, sizeof(info->id.name)) >= sizeof(info->id.name))
+		return -EINVAL;
 	access = info->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
 		(info->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|
 				 SNDRV_CTL_ELEM_ACCESS_INACTIVE|
-- 
2.3.2
