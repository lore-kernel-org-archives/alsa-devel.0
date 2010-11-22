From: ramesh.babu@intel.com
Subject: [PATCH 5/5] [RFC]intel_hdmi_audio: Kconfig and Makefile
Date: Mon, 22 Nov 2010 19:09:46 +0530
Message-ID: <1290433186-31628-5-git-send-email-ramesh.babu@intel.com>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 42748103A06
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:34:30 +0100 (CET)
In-Reply-To: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>, Ramesh Babu K V <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu K V <ramesh.babu@intel.com>

This patch adds Kconfig and Makefile.  For compilation, this
driver is dependent on client driver (platform display driver).

Change-Id: I786b82b7a8cd9136e81a21e076e394199572cd66
Signed-off-by: Ramesh Babu K V <ramesh.babu@intel.com>
Signed-off-by: Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>
---
 sound/drivers/Kconfig                 |   10 ++++++++++
 sound/drivers/Makefile                |    1 +
 sound/drivers/intel_mid_hdmi/Makefile |    2 ++
 3 files changed, 13 insertions(+), 0 deletions(-)
 create mode 100644 sound/drivers/intel_mid_hdmi/Makefile

diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 84714a6..e11a607 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -182,4 +182,14 @@ config SND_AC97_POWER_SAVE_DEFAULT
 	  The default time-out value in seconds for AC97 automatic
 	  power-save mode.  0 means to disable the power-save mode.
 
+config SND_INTELMID_HDMI_AUDIO
+	tristate "Intel MID based HDMI AUDIO driver"
+	depends on MDFD_HDMI
+	default n
+	help
+	   Intel MID HDMI Audio Driver (HAD) enables audio playback through
+	   HDMI interface on Intel Medfield MID platform.  This is an ALSA
+	   driver.  This driver programs HDMI audio sub-system registers
+	   according to the HDMI 13.a spec.
+
 endif	# SND_DRIVERS
diff --git a/sound/drivers/Makefile b/sound/drivers/Makefile
index d4a07f9..fdf9add 100644
--- a/sound/drivers/Makefile
+++ b/sound/drivers/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_SND_PORTMAN2X4) += snd-portman2x4.o
 obj-$(CONFIG_SND_ML403_AC97CR) += snd-ml403-ac97cr.o
 
 obj-$(CONFIG_SND) += opl3/ opl4/ mpu401/ vx/ pcsp/
+obj-$(CONFIG_SND_INTELMID_HDMI_AUDIO) 	+= intel_mid_hdmi/
diff --git a/sound/drivers/intel_mid_hdmi/Makefile b/sound/drivers/intel_mid_hdmi/Makefile
new file mode 100644
index 0000000..a53e4f0
--- /dev/null
+++ b/sound/drivers/intel_mid_hdmi/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_SND_INTELMID_HDMI_AUDIO)	+= intel_mid_had.o
+intel_mid_had-objs := intel_mid_hdmi_audio.o intel_mid_hdmi_audio_if.o
-- 
1.6.2.5
