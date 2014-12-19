From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 07/10] ALSA: core: pass audio tstamp config
	from userspace
Date: Fri, 19 Dec 2014 11:25:10 -0600
Message-ID: <1419009913-3686-8-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1419009913-3686-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 59B1B264FBA
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 18:25:47 +0100 (CET)
In-Reply-To: <1419009913-3686-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

Let userspace select audio timestamp config, ignore and zero all
other fields

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/pcm_native.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ae2a93a..8f8aab0 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -756,8 +756,16 @@ static int snd_pcm_status_user(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_status status;
 	int res;
-	
+	u32  audio_tstamp_data;
+	u32  __user *_audio_tstamp_data;
+
+	/* get audio_tstamp_data from user, ignore rest of status structure */
+	_audio_tstamp_data = (u32 __user *)(&_status->audio_tstamp_data);
+	if (get_user(audio_tstamp_data, _audio_tstamp_data))
+		return -EFAULT;
 	memset(&status, 0, sizeof(status));
+	status.audio_tstamp_data = audio_tstamp_data;
+
 	res = snd_pcm_status(substream, &status);
 	if (res < 0)
 		return res;
-- 
1.9.1
