From: Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH] ASoC: dapm: Fix typos in comment
Date: Wed, 27 Sep 2017 22:35:01 +0800
Message-ID: <1506522901-10552-1-git-send-email-dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id C501F2671E3
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 16:35:08 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id j16so9388568pga.2
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 07:35:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peng Donglin <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcef67a..0867eaa 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4167,7 +4167,7 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
  * @dapm: DAPM context
  * @pin: pin name
  *
- * Enables input/output pin and its parents or children widgets iff there is
+ * Enables input/output pin and its parents or children widgets if there is
  * a valid audio route and active audio stream.
  *
  * Requires external locking.
@@ -4187,7 +4187,7 @@ int snd_soc_dapm_enable_pin_unlocked(struct snd_soc_dapm_context *dapm,
  * @dapm: DAPM context
  * @pin: pin name
  *
- * Enables input/output pin and its parents or children widgets iff there is
+ * Enables input/output pin and its parents or children widgets if there is
  * a valid audio route and active audio stream.
  *
  * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
-- 
1.9.1
