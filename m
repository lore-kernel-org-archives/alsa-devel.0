From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 01/31] ALSA: hdspm - Add missing defines for
	RME AIO and RayDAT
Date: Fri,  5 Jul 2013 11:27:53 +0200
Message-ID: <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The driver did not support all possible configurations. These defines
will be used by later commits to add the missing functionality.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index bd50193..a0fc961 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -258,6 +258,25 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 
 #define HDSPM_wclk_sel (1<<30)
 
+/* additional control register bits for AIO*/
+#define HDSPM_c0_Wck48				0x20 /* also RayDAT */
+#define HDSPM_c0_Input0				0x1000
+#define HDSPM_c0_Input1				0x2000
+#define HDSPM_c0_Spdif_Opt			0x4000
+#define HDSPM_c0_Pro				0x8000
+#define HDSPM_c0_clr_tms			0x10000
+#define HDSPM_c0_AEB1				0x20000
+#define HDSPM_c0_AEB2				0x40000
+#define HDSPM_c0_LineOut			0x80000
+#define HDSPM_c0_AD_GAIN0			0x100000
+#define HDSPM_c0_AD_GAIN1			0x200000
+#define HDSPM_c0_DA_GAIN0			0x400000
+#define HDSPM_c0_DA_GAIN1			0x800000
+#define HDSPM_c0_PH_GAIN0			0x1000000
+#define HDSPM_c0_PH_GAIN1			0x2000000
+#define HDSPM_c0_Sym6db				0x4000000
+
+
 /* --- bit helper defines */
 #define HDSPM_LatencyMask    (HDSPM_Latency0|HDSPM_Latency1|HDSPM_Latency2)
 #define HDSPM_FrequencyMask  (HDSPM_Frequency0|HDSPM_Frequency1|\
-- 
1.8.3.1
