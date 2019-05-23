From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 1/2] pcm: add mmap_begin callback to
	snd_pcm_fast_ops_t api
Date: Thu, 23 May 2019 15:00:39 +0200
Message-ID: <1558616440-21044-2-git-send-email-amiartus@de.adit-jv.com>
References: <1558616440-21044-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1558616440-21044-1-git-send-email-amiartus@de.adit-jv.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

main motivation for adding the callback is to use it to enable operation
on mmaped buffer before user access for pcm_file plugin

support for MMAP read access with masking by data from input file is not
implemented for pcm_file plugin, by adding this callback implementing
such feature can be done by rewriting next continuous portion of buffer
on each mmap_begin call

plugins like softvol use pcm_plugin interface and overwrite the buffer by
looping around it in avail_update callback, this patch hopes to simplify
the task by adding new api callback, removing the need for rewriting
pcm_file (to use pcm_plugin callbacks) and careful checking when looping
around whole mmaped buffer

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
Reviewed-by: Timo Wischer <twischer@de.adit-jv.com>
---
 src/pcm/pcm.c       | 6 ++++++
 src/pcm/pcm_local.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 3a71d79..323926e 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -7129,7 +7129,13 @@ int __snd_pcm_mmap_begin(snd_pcm_t *pcm, const snd_pcm_channel_area_t **areas,
 	snd_pcm_uframes_t f;
 	snd_pcm_uframes_t avail;
 	const snd_pcm_channel_area_t *xareas;
+
 	assert(pcm && areas && offset && frames);
+
+	if (pcm->fast_ops->mmap_begin)
+		return pcm->fast_ops->mmap_begin(pcm->fast_op_arg, areas, offset, frames);
+
+	/* fallback for plugins that do not specify new callback */
 	xareas = snd_pcm_mmap_areas(pcm);
 	if (xareas == NULL)
 		return -EBADFD;
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index d52229d..d5726eb 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -184,6 +184,7 @@ typedef struct {
 	int (*poll_descriptors)(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space); /* locked */
 	int (*poll_revents)(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents); /* locked */
 	int (*may_wait_for_avail_min)(snd_pcm_t *pcm, snd_pcm_uframes_t avail);
+	int (*mmap_begin)(snd_pcm_t *pcm, const snd_pcm_channel_area_t **areas, snd_pcm_uframes_t *offset, snd_pcm_uframes_t *frames); /* locked */
 } snd_pcm_fast_ops_t;
 
 struct _snd_pcm {
-- 
2.7.4
