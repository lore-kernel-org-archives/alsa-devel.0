From: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Subject: [PATCH 5/6] ALSA: hda/ca0132: Restore PCM Analog
	Mic-In2
Date: Fri, 15 Jun 2018 21:56:19 -0400
Message-ID: <20180616015620.26663-6-alastair.bridgewater@gmail.com>
References: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit 009b8f979bf8cb5f7ec6d3dd7683585122ed10f8 conditionalized
adding the "CA0132 Analog Mic-In2" PCM with a comment to the
effect that, "desktops don't use this ADC", but the test was set
up such that the ADC was only created for desktops.  Invert the
test.

Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 71487b82eef5..cef22c60d7ee 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5966,7 +5966,7 @@ static int ca0132_build_pcms(struct hda_codec *codec)
 	info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adcs[0];
 
 	/* With the DSP enabled, desktops don't use this ADC. */
-	if (spec->use_alt_functions) {
+	if (!spec->use_alt_functions) {
 		info = snd_hda_codec_pcm_new(codec, "CA0132 Analog Mic-In2");
 		if (!info)
 			return -ENOMEM;
-- 
2.16.1
