From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH] ALSA: x86: Remove CONFIG_SND_X86 as unnecessary
Date: Tue, 21 Mar 2017 16:28:07 +1100
Message-ID: <CAFXWsS_uOqZa0p2vn0QiF-Hn945LTp9wtmx6z7--uOcDiLzQOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B6592670DA
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 06:28:07 +0100 (CET)
Received: by mail-wr0-f196.google.com with SMTP id g10so20968411wrg.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 22:28:07 -0700 (PDT)
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

Create a specific menu for the CONFIG_HDMI_LPE_AUDIO setting.
Add additional narrative to further explain the function of the
CONFIG_HDMI_LPE_AUDIO setting.
Remove subsequently unnecessary CONFIG_SND_X86 setting.

Signed-off-by: Ian W Morrison <linuxium@linuxium.com.au>
---
 sound/x86/Kconfig | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
index 84c8f8fc..a89d769 100644
--- a/sound/x86/Kconfig
+++ b/sound/x86/Kconfig
@@ -1,10 +1,5 @@
-menuconfig SND_X86
-       tristate "X86 sound devices"
-       depends on X86
-       ---help---
-         X86 sound devices that don't fall under SoC or PCI categories
-
-if SND_X86
+menu "HDMI LPE for SoC audio support"
+       comment "Required for HDMI audio support on Intel Baytrail and
Cherrytrail"

 config HDMI_LPE_AUDIO
        tristate "HDMI audio without HDaudio on Intel Atom platforms"
@@ -13,4 +8,4 @@ config HDMI_LPE_AUDIO
        help
         Choose this option to support HDMI LPE Audio mode

-endif  # SND_X86
+endmenu
-- 
1.9.1
