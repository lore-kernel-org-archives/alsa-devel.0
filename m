From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH] pcm_plugin: fix appl pointer not correct when
	mmap_commit() return error
Date: Wed, 6 Apr 2016 19:02:12 +0800
Message-ID: <1459940532-15614-1-git-send-email-shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0102.outbound.protection.outlook.com [65.55.169.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EC9F260870
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 13:02:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When snd_pcm_mmap_commit() return error, the appl pointer is also updated.
which cause the avail_update()'s result wrong.
This patch move the snd_pcm_mmap_appl_forward() to the place when
snd_pcm_mmap_commit() is successfully returned.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 src/pcm/pcm_plugin.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index d007e8c..940491d 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -279,18 +279,22 @@ static snd_pcm_sframes_t snd_pcm_plugin_write_areas(snd_pcm_t *pcm,
 			return -EPIPE;
 		}
 		snd_atomic_write_begin(&plugin->watom);
-		snd_pcm_mmap_appl_forward(pcm, frames);
 		result = snd_pcm_mmap_commit(slave, slave_offset, slave_frames);
 		if (result > 0 && (snd_pcm_uframes_t)result != slave_frames) {
 			snd_pcm_sframes_t res;
 			res = plugin->undo_write(pcm, slave_areas, slave_offset + result, slave_frames, slave_frames - result);
-			if (res < 0)
+			if (res < 0) {
+				snd_atomic_write_end(&plugin->watom);
 				return xfer > 0 ? (snd_pcm_sframes_t)xfer : res;
+			}
 			frames -= res;
 		}
-		snd_atomic_write_end(&plugin->watom);
-		if (result <= 0)
+		if (result <= 0) {
+			snd_atomic_write_end(&plugin->watom);
 			return xfer > 0 ? (snd_pcm_sframes_t)xfer : result;
+		}
+		snd_pcm_mmap_appl_forward(pcm, frames);
+		snd_atomic_write_end(&plugin->watom);
 		offset += frames;
 		xfer += frames;
 		size -= frames;
@@ -325,19 +329,23 @@ static snd_pcm_sframes_t snd_pcm_plugin_read_areas(snd_pcm_t *pcm,
 			return -EPIPE;
 		}
 		snd_atomic_write_begin(&plugin->watom);
-		snd_pcm_mmap_appl_forward(pcm, frames);
 		result = snd_pcm_mmap_commit(slave, slave_offset, slave_frames);
 		if (result > 0 && (snd_pcm_uframes_t)result != slave_frames) {
 			snd_pcm_sframes_t res;
 			
 			res = plugin->undo_read(slave, areas, offset, frames, slave_frames - result);
-			if (res < 0)
+			if (res < 0) {
+				snd_atomic_write_end(&plugin->watom);
 				return xfer > 0 ? (snd_pcm_sframes_t)xfer : res;
+			}
 			frames -= res;
 		}
-		snd_atomic_write_end(&plugin->watom);
-		if (result <= 0)
+		if (result <= 0) {
+			snd_atomic_write_end(&plugin->watom);
 			return xfer > 0 ? (snd_pcm_sframes_t)xfer : result;
+		}
+		snd_pcm_mmap_appl_forward(pcm, frames);
+		snd_atomic_write_end(&plugin->watom);
 		offset += frames;
 		xfer += frames;
 		size -= frames;
@@ -423,19 +431,23 @@ snd_pcm_plugin_mmap_commit(snd_pcm_t *pcm,
 		frames = plugin->write(pcm, areas, appl_offset, frames,
 				       slave_areas, slave_offset, &slave_frames);
 		snd_atomic_write_begin(&plugin->watom);
-		snd_pcm_mmap_appl_forward(pcm, frames);
 		result = snd_pcm_mmap_commit(slave, slave_offset, slave_frames);
-		snd_atomic_write_end(&plugin->watom);
 		if (result > 0 && (snd_pcm_uframes_t)result != slave_frames) {
 			snd_pcm_sframes_t res;
 			
 			res = plugin->undo_write(pcm, slave_areas, slave_offset + result, slave_frames, slave_frames - result);
-			if (res < 0)
+			if (res < 0) {
+				snd_atomic_write_end(&plugin->watom);
 				return xfer > 0 ? xfer : res;
+			}
 			frames -= res;
 		}
-		if (result <= 0)
+		if (result <= 0) {
+			snd_atomic_write_end(&plugin->watom);
 			return xfer > 0 ? xfer : result;
+		}
+		snd_pcm_mmap_appl_forward(pcm, frames);
+		snd_atomic_write_end(&plugin->watom);
 		if (frames == cont)
 			appl_offset = 0;
 		else
@@ -490,19 +502,23 @@ static snd_pcm_sframes_t snd_pcm_plugin_avail_update(snd_pcm_t *pcm)
 			frames = (plugin->read)(pcm, areas, hw_offset, frames,
 					      slave_areas, slave_offset, &slave_frames);
 			snd_atomic_write_begin(&plugin->watom);
-			snd_pcm_mmap_hw_forward(pcm, frames);
 			result = snd_pcm_mmap_commit(slave, slave_offset, slave_frames);
-			snd_atomic_write_end(&plugin->watom);
 			if (result > 0 && (snd_pcm_uframes_t)result != slave_frames) {
 				snd_pcm_sframes_t res;
 				
 				res = plugin->undo_read(slave, areas, hw_offset, frames, slave_frames - result);
-				if (res < 0)
+				if (res < 0) {
+					snd_atomic_write_end(&plugin->watom);
 					return xfer > 0 ? (snd_pcm_sframes_t)xfer : res;
+				}
 				frames -= res;
 			}
-			if (result <= 0)
+			if (result <= 0) {
+				snd_atomic_write_end(&plugin->watom);
 				return xfer > 0 ? (snd_pcm_sframes_t)xfer : result;
+			}
+			snd_pcm_mmap_hw_forward(pcm, frames);
+			snd_atomic_write_end(&plugin->watom);
 			if (frames == cont)
 				hw_offset = 0;
 			else
-- 
1.9.1
