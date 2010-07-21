From: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Subject: [PATCH 1/3] sound/oss: Remove dead CONFIG_SOFTOSS*
Date: Wed, 21 Jul 2010 14:35:17 +0200
Message-ID: <73dd840e90ee81c76a765e4aa3ed3b90a88b2e2e.1279708102.git.qy03fugy@stud.informatik.uni-erlangen.de>
References: <cover.1279708102.git.qy03fugy@stud.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1279708102.git.qy03fugy@stud.informatik.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Julia Lawall <julia@diku.dk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: vamos-dev@i4.informatik.uni-erlangen.de
List-Id: alsa-devel@alsa-project.org

CONFIG_SOFTOSS* doesn't exist in Kconfig or somewhere
else, therefore removing all references for it from the source code.

Signed-off-by: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
---
 sound/oss/vidc.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/oss/vidc.c b/sound/oss/vidc.c
index ac39a53..f0e0caa 100644
--- a/sound/oss/vidc.c
+++ b/sound/oss/vidc.c
@@ -491,9 +491,6 @@ static void __init attach_vidc(struct address_info *hw_config)
 	vidc_adev = adev;
 	vidc_mixer_set(SOUND_MIXER_VOLUME, (85 | 85 << 8));
 
-#if defined(CONFIG_SOUND_SOFTOSS) || defined(CONFIG_SOUND_SOFTOSS_MODULE)
-	softoss_dev = adev;
-#endif
 	return;
 
 irq_failed:
-- 
1.7.0.4
