From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/4] sound: oss: vidc: Remove softoss_dev
	declaration
Date: Thu, 11 Dec 2014 14:19:11 +0200
Message-ID: <1418300353-13243-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1418300353-13243-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AB5F264FBA
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 13:19:21 +0100 (CET)
In-Reply-To: <1418300353-13243-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

int softoss_dev is not defined anywhere.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/oss/vidc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/oss/vidc.c b/sound/oss/vidc.c
index 92ca5bee1860..d81f76f72c8c 100644
--- a/sound/oss/vidc.c
+++ b/sound/oss/vidc.c
@@ -82,7 +82,6 @@ static unsigned int	vidc_audio_volume_l;	/* left PCM vol, 0 - 65536 */
 static unsigned int	vidc_audio_volume_r;	/* right PCM vol, 0 - 65536 */
 
 extern void	vidc_update_filler(int bits, int channels);
-extern int	softoss_dev;
 
 static void
 vidc_mixer_set(int mdev, unsigned int level)
-- 
2.1.3
