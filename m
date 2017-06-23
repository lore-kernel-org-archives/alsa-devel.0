From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 1/2] pcm: obsolete 'mmap_emulation'
	parameter of snd_pcm_hw_open_fd()
Date: Fri, 23 Jun 2017 22:09:23 +0900
Message-ID: <20170623130924.19620-2-o-takashi@sakamocchi.jp>
References: <20170623130924.19620-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 23C43266AE9
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 15:09:29 +0200 (CEST)
In-Reply-To: <20170623130924.19620-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A function, snd_pcm_hw_open_fd(), is just for internal use. This function
has an obsoleted parameter and we can remove it without any compatibility
issue.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_direct.c | 2 +-
 src/pcm/pcm_hw.c     | 6 ++----
 src/pcm/pcm_local.h  | 3 ++-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 43702601..9fd376d8 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1523,7 +1523,7 @@ int snd_pcm_direct_open_secondary_client(snd_pcm_t **spcmp, snd_pcm_direct_t *dm
 	int ret;
 	snd_pcm_t *spcm;
 
-	ret = snd_pcm_hw_open_fd(spcmp, client_name, dmix->hw_fd, 0, 0);
+	ret = snd_pcm_hw_open_fd(spcmp, client_name, dmix->hw_fd, 0);
 	if (ret < 0) {
 		SNDERR("unable to open hardware");
 		return ret;
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 30cd5d0f..f0efcde3 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1410,15 +1410,13 @@ static const snd_pcm_fast_ops_t snd_pcm_hw_fast_ops_timer = {
  * \param pcmp Returns created PCM handle
  * \param name Name of PCM
  * \param fd File descriptor
- * \param mmap_emulation Obsoleted parameter
  * \param sync_ptr_ioctl Boolean flag for sync_ptr ioctl
  * \retval zero on success otherwise a negative error code
  * \warning Using of this function might be dangerous in the sense
  *          of compatibility reasons. The prototype might be freely
  *          changed in future.
  */
-int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name,
-		       int fd, int mmap_emulation ATTRIBUTE_UNUSED,
+int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name, int fd,
 		       int sync_ptr_ioctl)
 {
 	int ver, mode;
@@ -1615,7 +1613,7 @@ int snd_pcm_hw_open(snd_pcm_t **pcmp, const char *name,
 		}
 	}
 	snd_ctl_close(ctl);
-	return snd_pcm_hw_open_fd(pcmp, name, fd, 0, sync_ptr_ioctl);
+	return snd_pcm_hw_open_fd(pcmp, name, fd, sync_ptr_ioctl);
        _err:
 	snd_ctl_close(ctl);
 	return ret;
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index e4f65218..7600daa3 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -935,7 +935,8 @@ snd_pcm_open_slave(snd_pcm_t **pcmp, snd_config_t *root,
 
 #define snd_pcm_conf_generic_id(id) _snd_conf_generic_id(id)
 
-int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name, int fd, int mmap_emulation, int sync_ptr_ioctl);
+int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name, int fd,
+		       int sync_ptr_ioctl);
 int __snd_pcm_mmap_emul_open(snd_pcm_t **pcmp, const char *name,
 			     snd_pcm_t *slave, int close_slave);
 
-- 
2.11.0
