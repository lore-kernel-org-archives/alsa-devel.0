From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 7/7] ALSA: CA0132: Update sample rate and
	module description
Date: Fri, 7 Dec 2012 21:36:03 -0800
Message-ID: <1354944963-4654-8-git-send-email-ian_minett@creativelabs.com>
References: <1354944963-4654-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1354944963-4654-1-git-send-email-ian_minett@creativelabs.com>
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
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

Also, handle potential dma_engine alloc error.

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 21380f1..7ada5e6 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2399,8 +2399,11 @@ static int dspxfr_image(struct hda_codec *codec,
 		return -EINVAL;
 
 	dma_engine = kzalloc(sizeof(*dma_engine), GFP_KERNEL);
-	if (!dma_engine)
-		return -ENOMEM;
+	if (!dma_engine) {
+		status = -ENOMEM;
+		goto exit;
+	}
+	memset((void *)dma_engine, 0, sizeof(*dma_engine));
 
 	dma_engine->dmab = kzalloc(sizeof(*dma_engine->dmab), GFP_KERNEL);
 	if (!dma_engine->dmab) {
@@ -4289,8 +4292,8 @@ static void ca0132_set_dsp_msr(struct hda_codec *codec, bool is96k)
 	chipio_set_control_flag(codec, CONTROL_FLAG_ADC_B_96KHZ, is96k);
 	chipio_set_control_flag(codec, CONTROL_FLAG_ADC_C_96KHZ, is96k);
 
-	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_16_000);
-	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_16_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
 	chipio_set_conn_rate(codec, MEM_CONNID_WUH, SR_48_000);
 }
 
@@ -4635,7 +4638,7 @@ static struct hda_codec_preset snd_hda_preset_ca0132[] = {
 MODULE_ALIAS("snd-hda-codec-id:11020011");
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Creative CA0132, CA0132 HD-audio codec");
+MODULE_DESCRIPTION("Creative Sound Core3D codec");
 
 static struct hda_codec_preset_list ca0132_list = {
 	.preset = snd_hda_preset_ca0132,
-- 
1.7.4.1
