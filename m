From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH v2] ALSA: x86: Select CONFIG_HDMI_LPE_AUDIO as
	default
Date: Mon, 20 Mar 2017 18:42:32 +1100
Message-ID: <CAFXWsS9-pEX0pF5=94_VK8xSF6sXC9991zbrnWByYB+++ve59Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 429B7266CC6
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 08:42:33 +0100 (CET)
Received: by mail-wr0-f194.google.com with SMTP id u108so16818307wrb.2
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 00:42:33 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The upstream kernel builds for distributions such as Ubuntu which now
includes binary packages for v4.11 mainline kernel release candidates are
promoted as a way of testing upstream kernels to to confirm that upstream
has fixed a specific issue (see https://wiki.ubuntu.com/
Kernel/MainlineBuilds).

Unfortunately the long awaited patch for providing HDMI audio support for
Bay Trail and Cherry Trail devices does not include this support through a
module built by default.

Through including by default of the two associated CONFIG settings (SND_X86
and HDMI_LPE_AUDIO), upstream kernel builds would automatically provide the
much desired HDMI audio support by default.

This patch uses a Kconfig 'default' statement to include the driver as
default.

Changes in version 2: CONFIG_SND_X86 now a bool and changed default m to
default y

Signed-off-by: Ian W Morrison <linuxium@linuxium.com.au>
---
 sound/x86/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
index 84c8f8fc..cac2270 100644
--- a/sound/x86/Kconfig
+++ b/sound/x86/Kconfig
@@ -1,6 +1,7 @@
 menuconfig SND_X86
-       tristate "X86 sound devices"
+       bool "X86 sound devices"
        depends on X86
+       default y
        ---help---
          X86 sound devices that don't fall under SoC or PCI categories

@@ -9,6 +10,7 @@ if SND_X86
 config HDMI_LPE_AUDIO
        tristate "HDMI audio without HDaudio on Intel Atom platforms"
        depends on DRM_I915
+       default y
        select SND_PCM
        help
         Choose this option to support HDMI LPE Audio mode
-- 
1.9.1
