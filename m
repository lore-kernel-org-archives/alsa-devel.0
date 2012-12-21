From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCHv2 9/9] ALSA: CA0132: Fix potential init errors
	and update module description
Date: Thu, 20 Dec 2012 18:53:41 -0800
Message-ID: <1356058421-2683-10-git-send-email-ian_minett@creativelabs.com>
References: <1356058421-2683-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1356058421-2683-1-git-send-email-ian_minett@creativelabs.com>
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

Handle a potential dma_engine alloc error and fix the possible use of an 
uninitialized status variable in dspxfr_one_seg(). Also correct the initial
sampling rate for Mic 1.
Update the module description.

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4c9b95e..2b026e2 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2223,7 +2223,7 @@ static int dspxfr_one_seg(struct hda_codec *codec,
 			unsigned int port_map_mask,
 			bool ovly)
 {
-	int status;
+	int status = 0;
 	bool comm_dma_setup_done = false;
 	const unsigned int *data;
 	unsigned int chip_addx;
@@ -2416,8 +2416,10 @@ static int dspxfr_image(struct hda_codec *codec,
 		return -EINVAL;
 
 	dma_engine = kzalloc(sizeof(*dma_engine), GFP_KERNEL);
-	if (!dma_engine)
-		return -ENOMEM;
+	if (!dma_engine) {
+		status = -ENOMEM;
+		goto exit;
+	}
 
 	dma_engine->dmab = kzalloc(sizeof(*dma_engine->dmab), GFP_KERNEL);
 	if (!dma_engine->dmab) {
@@ -4340,8 +4342,8 @@ static void ca0132_set_dsp_msr(struct hda_codec *codec, bool is96k)
 	chipio_set_control_flag(codec, CONTROL_FLAG_ADC_B_96KHZ, is96k);
 	chipio_set_control_flag(codec, CONTROL_FLAG_ADC_C_96KHZ, is96k);
 
-	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_16_000);
-	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_16_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
+	chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
 	chipio_set_conn_rate(codec, MEM_CONNID_WUH, SR_48_000);
 }
 
@@ -4685,7 +4687,7 @@ static struct hda_codec_preset snd_hda_preset_ca0132[] = {
 MODULE_ALIAS("snd-hda-codec-id:11020011");
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Creative CA0132, CA0132 HD-audio codec");
+MODULE_DESCRIPTION("Creative Sound Core3D codec");
 
 static struct hda_codec_preset_list ca0132_list = {
 	.preset = snd_hda_preset_ca0132,
-- 
1.7.4.1
