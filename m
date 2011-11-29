From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] ALSA: asihp: Use kcalloc instead of kzalloc to allocate
 array
Date: Tue, 29 Nov 2011 22:08:00 +0100
Message-ID: <1322600880.1534.350.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The advantage of kcalloc is, that will prevent integer overflows which could
result from the multiplication of number of elements and size and it is also
a bit nicer to read.

The semantic patch that makes this change is available
in https://lkml.org/lkml/2011/11/25/107

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/sound/pci/asihpi/hpicmn.c b/sound/pci/asihpi/hpicmn.c
--- a/sound/pci/asihpi/hpicmn.c 2011-11-13 11:08:14.997586936 +0100
+++ b/sound/pci/asihpi/hpicmn.c 2011-11-28 20:15:05.524701909 +0100
@@ -631,7 +631,7 @@ struct hpi_control_cache *hpi_alloc_cont
 	if (!p_cache)
 		return NULL;
 
-	p_cache->p_info = kzalloc(sizeof(*p_cache->p_info) * control_count,
+	p_cache->p_info = kcalloc(control_count, sizeof(*p_cache->p_info),
 				  GFP_KERNEL);
 	if (!p_cache->p_info) {
 		kfree(p_cache);
