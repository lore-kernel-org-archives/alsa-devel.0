From: Barry Song <Baohua.Song@csr.com>
Subject: [PATCH 3/3] ASoC: hdmi-codec: let the driver support HDMI sink
Date: Wed, 17 Jul 2013 14:12:16 +0800
Message-ID: <1374041536-27643-3-git-send-email-Baohua.Song@csr.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: broonie@kernel.org
Cc: Rongjun Ying <Rongjun.Ying@csr.com>, alsa-devel@alsa-project.org, Workgroup.Linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

Devices like mobilephones, computers are typically used as
HDMI sources, but devices like TV, navigators will be HDMI
sinks.

for auto scenerios, In-Vehicle Infotainment(IVI) can be HDMI
sink to display movies from mobilephones.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 sound/soc/codecs/hdmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/hdmi.c b/sound/soc/codecs/hdmi.c
index 78c7b15..0fdcaf9 100644
--- a/sound/soc/codecs/hdmi.c
+++ b/sound/soc/codecs/hdmi.c
@@ -37,6 +37,17 @@ static struct snd_soc_dai_driver hdmi_codec_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE |
 			SNDRV_PCM_FMTBIT_S24_LE,
 	},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_32000 |
+			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+			SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_LE,
+	},
+
 };
 
 static int hdmi_codec_probe(struct platform_device *pdev)
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
