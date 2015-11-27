From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Expand the list of available
	firmwares" to the asoc tree
Date: Fri, 27 Nov 2015 12:55:44 +0000
Message-ID: <E1a2IYy-0005s1-9F@debutante>
References: <1448546512-14035-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5C39261B2A
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2015 13:55:51 +0100 (CET)
In-Reply-To: <1448546512-14035-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Expand the list of available firmwares

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 04d1300fd3f5c070a9abe391860d29dfcda89c87 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 26 Nov 2015 14:01:52 +0000
Subject: [PATCH] ASoC: wm_adsp: Expand the list of available firmwares

Expand the list of available firmware names to include a good selection
of generic uses for the DSP cores.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 49 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 0bb415a28723..905ae993440b 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -201,27 +201,48 @@ static void wm_adsp_buf_free(struct list_head *list)
 	}
 }
 
-#define WM_ADSP_NUM_FW 4
-
-#define WM_ADSP_FW_MBC_VSS 0
-#define WM_ADSP_FW_TX      1
-#define WM_ADSP_FW_TX_SPK  2
-#define WM_ADSP_FW_RX_ANC  3
+#define WM_ADSP_FW_MBC_VSS  0
+#define WM_ADSP_FW_HIFI     1
+#define WM_ADSP_FW_TX       2
+#define WM_ADSP_FW_TX_SPK   3
+#define WM_ADSP_FW_RX       4
+#define WM_ADSP_FW_RX_ANC   5
+#define WM_ADSP_FW_CTRL     6
+#define WM_ADSP_FW_ASR      7
+#define WM_ADSP_FW_TRACE    8
+#define WM_ADSP_FW_SPK_PROT 9
+#define WM_ADSP_FW_MISC     10
+
+#define WM_ADSP_NUM_FW      11
 
 static const char *wm_adsp_fw_text[WM_ADSP_NUM_FW] = {
-	[WM_ADSP_FW_MBC_VSS] = "MBC/VSS",
-	[WM_ADSP_FW_TX] =      "Tx",
-	[WM_ADSP_FW_TX_SPK] =  "Tx Speaker",
-	[WM_ADSP_FW_RX_ANC] =  "Rx ANC",
+	[WM_ADSP_FW_MBC_VSS] =  "MBC/VSS",
+	[WM_ADSP_FW_HIFI] =     "MasterHiFi",
+	[WM_ADSP_FW_TX] =       "Tx",
+	[WM_ADSP_FW_TX_SPK] =   "Tx Speaker",
+	[WM_ADSP_FW_RX] =       "Rx",
+	[WM_ADSP_FW_RX_ANC] =   "Rx ANC",
+	[WM_ADSP_FW_CTRL] =     "Voice Ctrl",
+	[WM_ADSP_FW_ASR] =      "ASR Assist",
+	[WM_ADSP_FW_TRACE] =    "Dbg Trace",
+	[WM_ADSP_FW_SPK_PROT] = "Protection",
+	[WM_ADSP_FW_MISC] =     "Misc",
 };
 
 static struct {
 	const char *file;
 } wm_adsp_fw[WM_ADSP_NUM_FW] = {
-	[WM_ADSP_FW_MBC_VSS] = { .file = "mbc-vss" },
-	[WM_ADSP_FW_TX] =      { .file = "tx" },
-	[WM_ADSP_FW_TX_SPK] =  { .file = "tx-spk" },
-	[WM_ADSP_FW_RX_ANC] =  { .file = "rx-anc" },
+	[WM_ADSP_FW_MBC_VSS] =  { .file = "mbc-vss" },
+	[WM_ADSP_FW_HIFI] =     { .file = "hifi" },
+	[WM_ADSP_FW_TX] =       { .file = "tx" },
+	[WM_ADSP_FW_TX_SPK] =   { .file = "tx-spk" },
+	[WM_ADSP_FW_RX] =       { .file = "rx" },
+	[WM_ADSP_FW_RX_ANC] =   { .file = "rx-anc" },
+	[WM_ADSP_FW_CTRL] =     { .file = "ctrl" },
+	[WM_ADSP_FW_ASR] =      { .file = "asr" },
+	[WM_ADSP_FW_TRACE] =    { .file = "trace" },
+	[WM_ADSP_FW_SPK_PROT] = { .file = "spk-prot" },
+	[WM_ADSP_FW_MISC] =     { .file = "misc" },
 };
 
 struct wm_coeff_ctl_ops {
-- 
2.6.2
