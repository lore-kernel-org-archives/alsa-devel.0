From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ALSA: pcm: constify attribute_group structures.
Date: Thu, 29 Jun 2017 16:02:56 +0530
Message-ID: <51656954c56bb69937adee61e23eec07b3bc08d0.1498729390.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CEFA266AE1
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 12:33:49 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id f127so11433718pgc.2
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 03:33:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/device.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   9781	    240	      8	  10029	   272d	sound/core/pcm.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   9813	    176	      8	   9997	   270d	sound/core/pcm.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/core/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 8e980aa..ee3e8db0 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1056,7 +1056,7 @@ static ssize_t show_pcm_class(struct device *dev,
 	NULL
 };
 
-static struct attribute_group pcm_dev_attr_group = {
+static const struct attribute_group pcm_dev_attr_group = {
 	.attrs	= pcm_dev_attrs,
 };
 
-- 
1.9.1
