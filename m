From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/3] ALSA: hdsp - Correct HDSP_VERSION_BIT
	constant, thus partly fixing RPM detection
Date: Thu, 27 Oct 2011 21:57:53 +0200
Message-ID: <1319745474-31542-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1319745474-31542-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1319745474-31542-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HDSP_VERSION_BIT has to be ORed with HDSP_S_LOAD. This fixes the detection
of at least some RME RPM boxes.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 1c6d1e1..f742202 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -151,7 +151,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11.bin");
 #define HDSP_PROGRAM	        0x020
 #define HDSP_CONFIG_MODE_0	0x040
 #define HDSP_CONFIG_MODE_1	0x080
-#define HDSP_VERSION_BIT	0x100
+#define HDSP_VERSION_BIT	(0x100 | HDSP_S_LOAD)
 #define HDSP_BIGENDIAN_MODE     0x200
 #define HDSP_RD_MULTIPLE        0x400
 #define HDSP_9652_ENABLE_MIXER  0x800
-- 
1.7.7.1
