From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] ALSA: asihpi - use kzalloc()
Date: Sat, 06 Aug 2011 13:26:20 +0200
Message-ID: <1312629983.5589.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Thomas Meyer <thomas@m3y3r.de>


 Use kzalloc rather than kmalloc followed by memset with 0

 This considers some simple cases that are common and easy to validate
 Note in particular that there are no ...s in the rule, so all of the
 matched code has to be contiguous

 The semantic patch that makes this output is available
 in scripts/coccinelle/api/alloc/kzalloc-simple.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/sound/pci/asihpi/hpicmn.c b/sound/pci/asihpi/hpicmn.c
--- a/sound/pci/asihpi/hpicmn.c 2011-07-26 00:46:12.970154018 +0200
+++ b/sound/pci/asihpi/hpicmn.c 2011-08-01 20:42:34.859285236 +0200
@@ -631,13 +631,12 @@ struct hpi_control_cache *hpi_alloc_cont
 	if (!p_cache)
 		return NULL;
 
-	p_cache->p_info =
-		kmalloc(sizeof(*p_cache->p_info) * control_count, GFP_KERNEL);
+	p_cache->p_info = kzalloc(sizeof(*p_cache->p_info) * control_count,
+				  GFP_KERNEL);
 	if (!p_cache->p_info) {
 		kfree(p_cache);
 		return NULL;
 	}
-	memset(p_cache->p_info, 0, sizeof(*p_cache->p_info) * control_count);
 	p_cache->cache_size_in_bytes = size_in_bytes;
 	p_cache->control_count = control_count;
 	p_cache->p_cache = p_dsp_control_buffer;
