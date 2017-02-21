From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: x86: hdmi: select CONFIG_SND_PCM
Date: Tue, 21 Feb 2017 23:02:37 +0100
Message-ID: <20170221220255.242105-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CD01266AA9
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 23:03:15 +0100 (CET)
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

The newly added driver uses the PCM helpers and fails to link if they are disabled:

sound/built-in.o: In function `hdmi_lpe_audio_runtime_suspend':
intel_hdmi_audio.c:(.text+0x15906): undefined reference to `snd_pcm_suspend'
sound/built-in.o: In function `had_pcm_hw_params':
intel_hdmi_audio.c:(.text+0x15ac7): undefined reference to `snd_pcm_lib_malloc_pages'
sound/built-in.o: In function `had_pcm_open':
intel_hdmi_audio.c:(.text+0x15d49): undefined reference to `snd_pcm_hw_constraint_integer'

This uses a Kconfig 'select' statement to make sure they are enabled.

Fixes: 5dab11d89777 ("ALSA: x86: hdmi: Add audio support for BYT and CHT")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
index 30d066e4885e..84c8f8fc597c 100644
--- a/sound/x86/Kconfig
+++ b/sound/x86/Kconfig
@@ -9,6 +9,7 @@ if SND_X86
 config HDMI_LPE_AUDIO
 	tristate "HDMI audio without HDaudio on Intel Atom platforms"
 	depends on DRM_I915
+	select SND_PCM
 	help
 	 Choose this option to support HDMI LPE Audio mode
 
-- 
2.9.0
