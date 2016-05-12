From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: au88x0: Fix zero clear of
	stream->resources
Date: Thu, 12 May 2016 18:08:05 +0200
Message-ID: <1463069285-1382-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4242226670B
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 18:08:06 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0A3E8AC95
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 16:08:06 +0000 (UTC)
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

There are a few calls of memset() to stream->resources, but they all
are called in a wrong size, sizeof(unsigned char) * VORTEX_RESOURCE_LAST,
while this field is a u32 array.  This may leave the memories not
zero-cleared.

Fix it by replacing them with a simpler sizeof(stream->resources)
instead.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/au88x0/au88x0_core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index 4667c3232b7f..4a054d720112 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -2151,8 +2151,7 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 							   stream->resources, en,
 							   VORTEX_RESOURCE_SRC)) < 0) {
 					memset(stream->resources, 0,
-					       sizeof(unsigned char) *
-					       VORTEX_RESOURCE_LAST);
+					       sizeof(stream->resources));
 					return -EBUSY;
 				}
 				if (stream->type != VORTEX_PCM_A3D) {
@@ -2162,7 +2161,7 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 								   VORTEX_RESOURCE_MIXIN)) < 0) {
 						memset(stream->resources,
 						       0,
-						       sizeof(unsigned char) * VORTEX_RESOURCE_LAST);
+						       sizeof(stream->resources));
 						return -EBUSY;
 					}
 				}
@@ -2175,8 +2174,7 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 						   stream->resources, en,
 						   VORTEX_RESOURCE_A3D)) < 0) {
 				memset(stream->resources, 0,
-				       sizeof(unsigned char) *
-				       VORTEX_RESOURCE_LAST);
+				       sizeof(stream->resources));
 				dev_err(vortex->card->dev,
 					"out of A3D sources. Sorry\n");
 				return -EBUSY;
@@ -2290,8 +2288,7 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 						   VORTEX_RESOURCE_MIXOUT))
 			    < 0) {
 				memset(stream->resources, 0,
-				       sizeof(unsigned char) *
-				       VORTEX_RESOURCE_LAST);
+				       sizeof(stream->resources));
 				return -EBUSY;
 			}
 			if ((src[i] =
@@ -2299,8 +2296,7 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 						   stream->resources, en,
 						   VORTEX_RESOURCE_SRC)) < 0) {
 				memset(stream->resources, 0,
-				       sizeof(unsigned char) *
-				       VORTEX_RESOURCE_LAST);
+				       sizeof(stream->resources));
 				return -EBUSY;
 			}
 		}
-- 
2.8.2
