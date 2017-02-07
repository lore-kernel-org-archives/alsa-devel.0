From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: x86: mark hdmi suspend/resume functions
	as __maybe_unused
Date: Tue,  7 Feb 2017 14:38:51 +0100
Message-ID: <20170207133918.1085873-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 88AB7267023
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 14:39:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

The two functions are unused when CONFIG_PM_SLEEP is disabled:

sound/x86/intel_hdmi_audio.c:1633:12: error: 'hdmi_lpe_audio_resume' defined but not used [-Werror=unused-function]
sound/x86/intel_hdmi_audio.c:1622:12: error: 'hdmi_lpe_audio_suspend' defined but not used [-Werror=unused-function]

Marking them as __maybe_unused avoids the warning without introducing an
ugly #ifdef.

Fixes: 182cdf23dbf6 ("ALSA: x86: Implement runtime PM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/x86/intel_hdmi_audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 8978dc9bf579..0d19a4994bac 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1619,7 +1619,7 @@ static int hdmi_lpe_audio_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int hdmi_lpe_audio_suspend(struct device *dev)
+static int __maybe_unused hdmi_lpe_audio_suspend(struct device *dev)
 {
 	struct snd_intelhad *ctx = dev_get_drvdata(dev);
 	int err;
@@ -1630,7 +1630,7 @@ static int hdmi_lpe_audio_suspend(struct device *dev)
 	return err;
 }
 
-static int hdmi_lpe_audio_resume(struct device *dev)
+static int __maybe_unused hdmi_lpe_audio_resume(struct device *dev)
 {
 	struct snd_intelhad *ctx = dev_get_drvdata(dev);
 
-- 
2.9.0
