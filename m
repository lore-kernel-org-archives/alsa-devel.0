From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ALSA: hda: constify attribute_group structures.
Date: Thu, 29 Jun 2017 16:07:01 +0530
Message-ID: <bd709fe1a8e75d8389a5e97d5e3fce97fbf6f8b1.1498732573.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 208892668BF
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 12:37:52 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id j186so11455166pge.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 03:37:52 -0700 (PDT)
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
    995	    608	      0	   1603	    643	sound/pci/hda/hda_sysfs.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   1035	    544	      0	   1579	    62b	sound/pci/hda/hda_sysfs.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/pci/hda/hda_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index 9739fce..9b7efec 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -761,7 +761,7 @@ int snd_hda_load_patch(struct hda_bus *bus, size_t fw_size, const void *fw_buf)
 	NULL
 };
 
-static struct attribute_group hda_dev_attr_group = {
+static const struct attribute_group hda_dev_attr_group = {
 	.attrs	= hda_dev_attrs,
 };
 
-- 
1.9.1
