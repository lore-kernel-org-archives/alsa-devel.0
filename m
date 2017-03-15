From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH] ALSA: x86: Select CONFIG_HDMI_LPE_AUDIO as
	default
Date: Wed, 15 Mar 2017 17:34:18 +1100
Message-ID: <CAFXWsS8PkZ7pRLMqC7zABYS_CKxJ4=6TUGeGsvCYepMMjo+0qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B9B8266EF1
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 07:34:19 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id u132so3023577wmg.1
 for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2017 23:34:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The upstream kernel builds for distributions such as Ubuntu which now
includes binary packages for v4.11 mainline kernel release candidates are
promoted as a way of testing upstream kernels to to confirm that upstream
has fixed a specific issue (see
https://wiki.ubuntu.com/Kernel/MainlineBuilds).

Unfortunately the long awaited patch for providing HDMI audio support for
Bay Trail and Cherry Trail devices does not include this support through a
module built by default.

By defining the default of the two associated CONFIG settings (SND_X86 and
HDMI_LPE_AUDIO) as a module, upstream kernel builds would automatically
provide the much desired HDMI audio support by default.

This patch uses a Kconfig 'default' statement to include the driver as
default.

Signed-off-by: Ian W Morrison <linuxium@linuxium.com.au>
---
 sound/x86/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
index 84c8f8fc..439850c 100644
--- a/sound/x86/Kconfig
+++ b/sound/x86/Kconfig
@@ -1,6 +1,7 @@
 menuconfig SND_X86
        tristate "X86 sound devices"
        depends on X86
+       default m
        ---help---
          X86 sound devices that don't fall under SoC or PCI categories

@@ -9,6 +10,7 @@ if SND_X86
 config HDMI_LPE_AUDIO
        tristate "HDMI audio without HDaudio on Intel Atom platforms"
        depends on DRM_I915
+       default m
        select SND_PCM
        help
         Choose this option to support HDMI LPE Audio mode
-- 
1.9.1
