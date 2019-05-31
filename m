From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: control: Use struct_size()
Date: Fri, 31 May 2019 11:53:19 +0200
Message-ID: <20190531095321.16002-2-tiwai@suse.de>
References: <20190531095321.16002-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52358F896E4
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 11:53:25 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4CDDCB020
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 09:53:25 +0000 (UTC)
In-Reply-To: <20190531095321.16002-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

For code simplification and safety, use struct_size() macro for
calculating the snd_kcontrol object size with the variable array.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index a5cc9a874062..04eb1a15ffb4 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -211,16 +211,12 @@ EXPORT_SYMBOL(snd_ctl_notify);
 static int snd_ctl_new(struct snd_kcontrol **kctl, unsigned int count,
 		       unsigned int access, struct snd_ctl_file *file)
 {
-	unsigned int size;
 	unsigned int idx;
 
 	if (count == 0 || count > MAX_CONTROL_COUNT)
 		return -EINVAL;
 
-	size  = sizeof(struct snd_kcontrol);
-	size += sizeof(struct snd_kcontrol_volatile) * count;
-
-	*kctl = kzalloc(size, GFP_KERNEL);
+	*kctl = kzalloc(struct_size(*kctl, vd, count), GFP_KERNEL);
 	if (!*kctl)
 		return -ENOMEM;
 
-- 
2.16.4
