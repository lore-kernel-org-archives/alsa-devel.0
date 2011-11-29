From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] ALSA: ctxf: Use kcalloc instead of kzalloc to allocate
 array
Date: Tue, 29 Nov 2011 22:08:00 +0100
Message-ID: <1322600880.1534.351.camel@localhost.localdomain>
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

diff -u -p a/sound/pci/ctxfi/ctsrc.c b/sound/pci/ctxfi/ctsrc.c
--- a/sound/pci/ctxfi/ctsrc.c 2011-11-13 11:08:15.090921741 +0100
+++ b/sound/pci/ctxfi/ctsrc.c 2011-11-28 20:14:46.651112893 +0100
@@ -437,7 +437,7 @@ get_src_rsc(struct src_mgr *mgr, const s
 
 	/* Allocate mem for master src resource */
 	if (MEMRD == desc->mode)
-		src = kzalloc(sizeof(*src)*desc->multi, GFP_KERNEL);
+		src = kcalloc(desc->multi, sizeof(*src), GFP_KERNEL);
 	else
 		src = kzalloc(sizeof(*src), GFP_KERNEL);
 
