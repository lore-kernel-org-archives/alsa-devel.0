From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: dapm: update function comments
Date: Thu,  7 Jun 2018 00:07:36 +0800
Message-ID: <20180606160736.169077-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 166232671EE
 for <alsa-devel@alsa-project.org>; Wed,  6 Jun 2018 18:07:49 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id a12-v6so3383774pfi.3
 for <alsa-devel@alsa-project.org>; Wed, 06 Jun 2018 09:07:49 -0700 (PDT)
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
Cc: tzungbi@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

snd_soc_dapm_put_volsw() and snd_soc_dapm_put_enum_double() returns
0 if the value is unchanged and 1 if changed. Both 0 and 1 indicate
a success.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2d9709104ec5..9843086dc1ed 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3178,7 +3178,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_volsw);
  *
  * Callback to set the value of a dapm mixer control.
  *
- * Returns 0 for success.
+ * Returns either 0 or 1 for success: 1 if changed, 0 if unchanged.
  */
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
@@ -3311,7 +3311,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_double);
  *
  * Callback to set the value of a dapm enumerated double mixer control.
  *
- * Returns 0 for success.
+ * Returns either 0 or 1 for success: 1 if changed, 0 if unchanged.
  */
 int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
-- 
2.18.0.rc1.242.g61856ae69a-goog
