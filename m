From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/4] ALSA: Add RME MADI FX Kconfig entries
Date: Sat,  8 Aug 2015 18:23:35 +0200
Message-ID: <1439051017-15401-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <5537C5FF.6070607@spectralbird.de>
 <1439051017-15401-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1439051017-15401-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, Adrian Knoth <aknoth@google.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Adrian Knoth <aknoth@google.com>

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index edfc1b8..9b62479 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -607,6 +607,27 @@ config SND_HDSPM
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-hdspm.
 
+config SND_MADIFX
+	tristate "RME Hammerfall DSP MADI FX"
+	select SND_HWDEP
+	select SND_RAWMIDI
+	select SND_PCM
+	help
+	  Say Y here to include support for RME Hammerfall DSP MADI FX
+	  soundcards.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-madifx.
+
+if SND_MADIFX
+config SND_MADIFX_BROKEN
+	bool "Include broken WIP code"
+	help
+	  This option is intended for developers, most people should say N
+	  here. It enables work-in-progress code that's not yet usable from
+	  userspace.
+endif # SND_MADIFX_BROKEN
+
 config SND_ICE1712
 	tristate "ICEnsemble ICE1712 (Envy24)"
 	select SND_MPU401_UART
-- 
2.1.0
