From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: pcm: Define dummy snd_pcm_suspend()
	for CONFIG_PM=n
Date: Sun,  5 Feb 2017 09:04:58 +0100
Message-ID: <20170205080458.15927-4-tiwai@suse.de>
References: <20170205080458.15927-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 81A79266CF6
 for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2017 09:05:00 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B944FABD9
 for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2017 08:04:59 +0000 (UTC)
In-Reply-To: <20170205080458.15927-1-tiwai@suse.de>
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

... so that the driver can avoid ifdef's for the dead PM callbacks.
The compiler should optimize them out in anyway.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index af1fb37c6b26..361749e60799 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -570,6 +570,15 @@ int snd_pcm_stop_xrun(struct snd_pcm_substream *substream);
 #ifdef CONFIG_PM
 int snd_pcm_suspend(struct snd_pcm_substream *substream);
 int snd_pcm_suspend_all(struct snd_pcm *pcm);
+#else
+static inline int snd_pcm_suspend(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+static inline int snd_pcm_suspend_all(struct snd_pcm *pcm)
+{
+	return 0;
+}
 #endif
 int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg);
 int snd_pcm_open_substream(struct snd_pcm *pcm, int stream, struct file *file,
-- 
2.11.0
