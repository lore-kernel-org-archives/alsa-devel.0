From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 4/5] pcm: add support for new STATUS_EXT
	ioctl
Date: Fri, 20 Feb 2015 18:28:13 -0600
Message-ID: <1424478494-5135-5-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1424478494-5135-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A0E0926147D
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 01:28:42 +0100 (CET)
In-Reply-To: <1424478494-5135-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

use STATUS_EXT ioctl if PCM protocol is > 2.0.12
All audio timestamp configuration will be ignored with an
older protocol.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 src/pcm/pcm_hw.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index c34b766..232b197 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -510,10 +510,18 @@ static int snd_pcm_hw_status(snd_pcm_t *pcm, snd_pcm_status_t * status)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
 	int fd = hw->fd, err;
-	if (ioctl(fd, SNDRV_PCM_IOCTL_STATUS, status) < 0) {
-		err = -errno;
-		SYSMSG("SNDRV_PCM_IOCTL_STATUS failed (%i)", err);
-		return err;
+	if (SNDRV_PROTOCOL_VERSION(2, 0, 13) > hw->version) {
+		if (ioctl(fd, SNDRV_PCM_IOCTL_STATUS, status) < 0) {
+			err = -errno;
+			SYSMSG("SNDRV_PCM_IOCTL_STATUS failed (%i)", err);
+			return err;
+		}
+	} else {
+		if (ioctl(fd, SNDRV_PCM_IOCTL_STATUS_EXT, status) < 0) {
+			err = -errno;
+			SYSMSG("SNDRV_PCM_IOCTL_STATUS_EXT failed (%i)", err);
+			return err;
+		}
 	}
 	if (SNDRV_PROTOCOL_VERSION(2, 0, 5) > hw->version) {
 		status->tstamp.tv_nsec *= 1000L;
-- 
1.9.1
