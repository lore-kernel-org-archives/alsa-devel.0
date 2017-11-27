From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: drivers: make array 'names' const,
	reduces object code size
Date: Mon, 27 Nov 2017 12:58:51 +0000
Message-ID: <20171127125851.10076-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B441A266DCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 13:58:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate array 'names' on the stack but instead make them static.
Makes the object code smaller by 50 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  21237	   9192	   1120	  31549	   7b3d	linux/sound/drivers/dummy.o

After:
   text	   data	    bss	    dec	    hex	filename
  21095	   9280	   1120	  31495	   7b07	linux/sound/drivers/dummy.o

(gcc version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/drivers/dummy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 7b2b1f766b00..69db45bc0197 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -830,7 +830,7 @@ static int snd_dummy_capsrc_put(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 static int snd_dummy_iobox_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *info)
 {
-	const char *const names[] = { "None", "CD Player" };
+	static const char *const names[] = { "None", "CD Player" };
 
 	return snd_ctl_enum_info(info, 1, 2, names);
 }
-- 
2.14.1
