From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 1/2] alsa: pcm: add unsupported OPS
Date: Mon, 8 Jul 2019 13:04:48 +0200
Message-ID: <1562583889-2109-2-git-send-email-amiartus@de.adit-jv.com>
References: <1562583889-2109-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1562583889-2109-1-git-send-email-amiartus@de.adit-jv.com>
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
Cc: alsa-devel@alsa-project.org, Andreas Pape <apape@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
---
 src/pcm/Makefile.am       |   4 +-
 src/pcm/pcm_unsupported.c | 265 ++++++++++++++++++++++++++++++++++++++++++++++
 src/pcm/pcm_unsupported.h | 166 +++++++++++++++++++++++++++++
 3 files changed, 433 insertions(+), 2 deletions(-)
 create mode 100644 src/pcm/pcm_unsupported.c
 create mode 100644 src/pcm/pcm_unsupported.h

diff --git a/src/pcm/Makefile.am b/src/pcm/Makefile.am
index 8edbd0b..ba07869 100644
--- a/src/pcm/Makefile.am
+++ b/src/pcm/Makefile.am
@@ -8,7 +8,7 @@ libpcm_la_SOURCES = mask.c interval.c \
 		    pcm_hw.c pcm_misc.c pcm_mmap.c pcm_symbols.c
 
 if BUILD_PCM_PLUGIN
-libpcm_la_SOURCES += pcm_generic.c pcm_plugin.c
+libpcm_la_SOURCES += pcm_generic.c pcm_plugin.c pcm_unsupported.c
 endif
 if BUILD_PCM_PLUGIN_COPY
 libpcm_la_SOURCES += pcm_copy.c
@@ -108,7 +108,7 @@ EXTRA_DIST = pcm_dmix_i386.c pcm_dmix_x86_64.c pcm_dmix_generic.c
 noinst_HEADERS = pcm_local.h pcm_plugin.h mask.h mask_inline.h \
 	         interval.h interval_inline.h plugin_ops.h ladspa.h \
 		 pcm_direct.h pcm_dmix_i386.h pcm_dmix_x86_64.h \
-		 pcm_generic.h pcm_ext_parm.h
+		 pcm_generic.h pcm_ext_parm.h pcm_unsupported.h
 
 alsadir = $(datadir)/alsa
 
diff --git a/src/pcm/pcm_unsupported.c b/src/pcm/pcm_unsupported.c
new file mode 100644
index 0000000..b7abf04
--- /dev/null
+++ b/src/pcm/pcm_unsupported.c
@@ -0,0 +1,265 @@
+/**
+ * \file pcm/pcm_unsupported.c
+ * \ingroup PCM
+ * \brief PCM Unsupported Interface
+ * \author Andreas Pape <apape@de.adit-jv.com>
+ * \date 2019
+ */
+/*
+ *  PCM - Common plugin code for unsupported operations
+ *  Copyright (c) 2019 by Andreas Pape <apape@de.adit-jv.com>
+ *
+ *
+ *   This library is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU Lesser General Public
+ *   License as published by the Free Software Foundation; either
+ *   version 2.1 of the License, or (at your option) any later version.
+ *
+ *   This library is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *   Lesser General Public License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public
+ *   License along with this library; if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include "pcm_local.h"
+#include "pcm_unsupported.h"
+
+#ifndef DOC_HIDDEN
+
+#define PCM_UNSUPPORTED_ERR (-ENOSYS)
+void snd_pcm_unsupported_dump(snd_pcm_t *pcm, snd_output_t *out)
+{
+	snd_output_printf(out, "unsupported\n");
+}
+
+int snd_pcm_unsupported_close(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_nonblock(snd_pcm_t *pcm, int nonblock)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_async(snd_pcm_t *pcm, int sig, pid_t pid)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_poll_descriptors_count(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_info(snd_pcm_t *pcm, snd_pcm_info_t * info)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_hw_free(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_prepare(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t *info)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_state_t snd_pcm_unsupported_state(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_hwsync(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_reset(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_start(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_drop(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_drain(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_pause(snd_pcm_t *pcm, int enable)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_resume(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_sframes_t snd_pcm_unsupported_forwardable(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_sframes_t snd_pcm_unsupported_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_sframes_t snd_pcm_unsupported_rewindable(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_sframes_t snd_pcm_unsupported_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_link(snd_pcm_t *pcm1, snd_pcm_t *pcm2)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_link_slaves(snd_pcm_t *pcm, snd_pcm_t *master)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_unlink(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_sframes_t snd_pcm_unsupported_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_sframes_t snd_pcm_unsupported_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_sframes_t snd_pcm_unsupported_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_sframes_t snd_pcm_unsupported_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_sframes_t snd_pcm_unsupported_mmap_commit(snd_pcm_t *pcm,
+					      snd_pcm_uframes_t offset,
+					      snd_pcm_uframes_t size)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_sframes_t snd_pcm_unsupported_avail_update(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_htimestamp(snd_pcm_t *pcm, snd_pcm_uframes_t *avail,
+			       snd_htimestamp_t *tstamp)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_real_htimestamp(snd_pcm_t *pcm, snd_pcm_uframes_t *avail,
+				    snd_htimestamp_t *tstamp)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_mmap(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_munmap(snd_pcm_t *pcm)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+snd_pcm_chmap_query_t **snd_pcm_unsupported_query_chmaps(snd_pcm_t *pcm)
+{
+	return NULL;
+}
+
+snd_pcm_chmap_t *snd_pcm_unsupported_get_chmap(snd_pcm_t *pcm)
+{
+	return NULL;
+}
+
+int snd_pcm_unsupported_set_chmap(snd_pcm_t *pcm, const snd_pcm_chmap_t *map)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+int snd_pcm_unsupported_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail ATTRIBUTE_UNUSED)
+{
+	return PCM_UNSUPPORTED_ERR;
+}
+
+
+#endif /* DOC_HIDDEN */
diff --git a/src/pcm/pcm_unsupported.h b/src/pcm/pcm_unsupported.h
new file mode 100644
index 0000000..13e4d1b
--- /dev/null
+++ b/src/pcm/pcm_unsupported.h
@@ -0,0 +1,166 @@
+/*
+ *  PCM - Common plugin code for unsupported operations
+ *  Copyright (c) 2017 by Andreas Pape <apape@de.adit-jv.com>
+ *
+ *
+ *   This library is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU Lesser General Public License as
+ *   published by the Free Software Foundation; either version 2.1 of
+ *   the License, or (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU Lesser General Public License for more details.
+ *
+ *   You should have received a copy of the GNU Lesser General Public
+ *   License along with this library; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+  
+
+/* make local functions really local */
+#define snd_pcm_unsupported_dump \
+	snd1_pcm_unsupported_dump
+#define snd_pcm_unsupported_close \
+	snd1_pcm_unsupported_close
+#define snd_pcm_unsupported_nonblock \
+	snd1_pcm_unsupported_nonblock
+#define snd_pcm_unsupported_async \
+	snd1_pcm_unsupported_async
+#define snd_pcm_unsupported_poll_descriptors_count \
+	snd1_pcm_unsupported_poll_descriptors_count
+#define snd_pcm_unsupported_poll_descriptors \
+	snd1_pcm_unsupported_poll_descriptors
+#define snd_pcm_unsupported_poll_revents \
+	snd1_pcm_unsupported_poll_revents
+#define snd_pcm_unsupported_info \
+	snd1_pcm_unsupported_info
+#define snd_pcm_unsupported_hw_free \
+	snd1_pcm_unsupported_hw_free
+#define snd_pcm_unsupported_sw_params \
+	snd1_pcm_unsupported_sw_params
+#define snd_pcm_unsupported_hw_refine \
+	snd1_pcm_unsupported_hw_refine
+#define snd_pcm_unsupported_hw_params \
+	snd1_pcm_unsupported_hw_params
+#define snd_pcm_unsupported_channel_info \
+	snd1_pcm_unsupported_channel_info
+#define snd_pcm_unsupported_channel_info_no_buffer \
+	snd1_pcm_unsupported_channel_info_no_buffer
+#define snd_pcm_unsupported_status \
+	snd1_pcm_unsupported_status
+#define snd_pcm_unsupported_state \
+	snd1_pcm_unsupported_state
+#define snd_pcm_unsupported_prepare \
+	snd1_pcm_unsupported_prepare
+#define snd_pcm_unsupported_hwsync \
+	snd1_pcm_unsupported_hwsync
+#define snd_pcm_unsupported_reset \
+	snd1_pcm_unsupported_reset
+#define snd_pcm_unsupported_start \
+	snd1_pcm_unsupported_start
+#define snd_pcm_unsupported_drop \
+	snd1_pcm_unsupported_drop
+#define snd_pcm_unsupported_drain \
+	snd1_pcm_unsupported_drain
+#define snd_pcm_unsupported_pause \
+	snd1_pcm_unsupported_pause
+#define snd_pcm_unsupported_resume \
+	snd1_pcm_unsupported_resume
+#define snd_pcm_unsupported_delay \
+	snd1_pcm_unsupported_delay
+#define snd_pcm_unsupported_forwardable \
+	snd1_pcm_unsupported_forwardable
+#define snd_pcm_unsupported_forward \
+	snd1_pcm_unsupported_forward
+#define snd_pcm_unsupported_rewindable \
+	snd1_pcm_unsupported_rewindable
+#define snd_pcm_unsupported_rewind \
+	snd1_pcm_unsupported_rewind
+#define snd_pcm_unsupported_link \
+	snd1_pcm_unsupported_link
+#define snd_pcm_unsupported_link_slaves \
+	snd1_pcm_unsupported_link_slaves
+#define snd_pcm_unsupported_unlink \
+	snd1_pcm_unsupported_unlink
+#define snd_pcm_unsupported_writei \
+	snd1_pcm_unsupported_writei
+#define snd_pcm_unsupported_writen \
+	snd1_pcm_unsupported_writen
+#define snd_pcm_unsupported_readi \
+	snd1_pcm_unsupported_readi
+#define snd_pcm_unsupported_readn \
+	snd1_pcm_unsupported_readn
+#define snd_pcm_unsupported_mmap_commit \
+	snd1_pcm_unsupported_mmap_commit
+#define snd_pcm_unsupported_avail_update	\
+	snd1_pcm_unsupported_avail_update
+#define snd_pcm_unsupported_htimestamp	\
+	snd1_pcm_unsupported_htimestamp
+#define snd_pcm_unsupported_real_htimestamp	\
+	snd1_pcm_unsupported_real_htimestamp
+#define snd_pcm_unsupported_mmap \
+	snd1_pcm_unsupported_mmap
+#define snd_pcm_unsupported_munmap \
+	snd1_pcm_unsupported_munmap
+#define snd_pcm_unsupported_query_chmaps \
+	snd1_pcm_unsupported_query_chmaps
+#define snd_pcm_unsupported_get_chmap \
+	snd1_pcm_unsupported_get_chmap
+#define snd_pcm_unsupported_set_chmap \
+	snd1_pcm_unsupported_set_chmap
+#define snd_pcm_unsupported_may_wait_for_avail_min \
+	snd1_pcm_unsupported_may_wait_for_avail_min
+
+int snd_pcm_unsupported_close(snd_pcm_t *pcm);
+int snd_pcm_unsupported_nonblock(snd_pcm_t *pcm, int nonblock);
+int snd_pcm_unsupported_async(snd_pcm_t *pcm, int sig, pid_t pid);
+int snd_pcm_unsupported_poll_descriptors_count(snd_pcm_t *pcm);
+int snd_pcm_unsupported_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space);
+int snd_pcm_unsupported_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents);
+int snd_pcm_unsupported_info(snd_pcm_t *pcm, snd_pcm_info_t * info);
+int snd_pcm_unsupported_hw_free(snd_pcm_t *pcm);
+int snd_pcm_unsupported_sw_params(snd_pcm_t *pcm, snd_pcm_sw_params_t *params);
+int snd_pcm_unsupported_hw_refine(snd_pcm_t *pcm, snd_pcm_hw_params_t *params);
+int snd_pcm_unsupported_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params);
+int snd_pcm_unsupported_channel_info(snd_pcm_t *pcm, snd_pcm_channel_info_t * info);
+int snd_pcm_unsupported_channel_info_no_buffer(snd_pcm_t *pcm, snd_pcm_channel_info_t * info);
+int snd_pcm_unsupported_status(snd_pcm_t *pcm, snd_pcm_status_t * status);
+snd_pcm_state_t snd_pcm_unsupported_state(snd_pcm_t *pcm);
+int snd_pcm_unsupported_prepare(snd_pcm_t *pcm);
+int snd_pcm_unsupported_hwsync(snd_pcm_t *pcm);
+int snd_pcm_unsupported_reset(snd_pcm_t *pcm);
+int snd_pcm_unsupported_start(snd_pcm_t *pcm);
+int snd_pcm_unsupported_drop(snd_pcm_t *pcm);
+int snd_pcm_unsupported_drain(snd_pcm_t *pcm);
+int snd_pcm_unsupported_pause(snd_pcm_t *pcm, int enable);
+int snd_pcm_unsupported_resume(snd_pcm_t *pcm);
+int snd_pcm_unsupported_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp);
+snd_pcm_sframes_t snd_pcm_unsupported_forwardable(snd_pcm_t *pcm);
+snd_pcm_sframes_t snd_pcm_unsupported_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
+snd_pcm_sframes_t snd_pcm_unsupported_rewindable(snd_pcm_t *pcm);
+snd_pcm_sframes_t snd_pcm_unsupported_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames);
+int snd_pcm_unsupported_link(snd_pcm_t *pcm1, snd_pcm_t *pcm2);
+int snd_pcm_unsupported_link_slaves(snd_pcm_t *pcm, snd_pcm_t *master);
+int snd_pcm_unsupported_unlink(snd_pcm_t *pcm);
+snd_pcm_sframes_t snd_pcm_unsupported_writei(snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size);
+snd_pcm_sframes_t snd_pcm_unsupported_writen(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size);
+snd_pcm_sframes_t snd_pcm_unsupported_readi(snd_pcm_t *pcm, void *buffer, snd_pcm_uframes_t size);
+snd_pcm_sframes_t snd_pcm_unsupported_readn(snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size);
+snd_pcm_sframes_t snd_pcm_unsupported_mmap_commit(snd_pcm_t *pcm,
+					      snd_pcm_uframes_t offset,
+					      snd_pcm_uframes_t size);
+snd_pcm_sframes_t snd_pcm_unsupported_avail_update(snd_pcm_t *pcm);
+int snd_pcm_unsupported_htimestamp(snd_pcm_t *pcm, snd_pcm_uframes_t *avail,
+			       snd_htimestamp_t *timestamp);
+int snd_pcm_unsupported_real_htimestamp(snd_pcm_t *pcm, snd_pcm_uframes_t *avail,
+				    snd_htimestamp_t *tstamp);
+int snd_pcm_unsupported_mmap(snd_pcm_t *pcm);
+int snd_pcm_unsupported_munmap(snd_pcm_t *pcm);
+snd_pcm_chmap_query_t **snd_pcm_unsupported_query_chmaps(snd_pcm_t *pcm);
+snd_pcm_chmap_t *snd_pcm_unsupported_get_chmap(snd_pcm_t *pcm);
+int snd_pcm_unsupported_set_chmap(snd_pcm_t *pcm, const snd_pcm_chmap_t *map);
+int snd_pcm_unsupported_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail);
+
-- 
2.7.4
