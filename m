From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: [PATCH] ASoC: hdmi-codec: Fix hdmi_of_xlate_dai_name when
 #sound-dai-cells = <0>
Date: Thu, 27 Oct 2016 12:42:48 +0100
Message-ID: <1477568568.2908.14.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If a DAI specifies "#sound-dai-cells = <0>" in device-tree then
hdmi_of_xlate_dai_name() will be called with zero args, which it isn't
implemented to cope with. The resulting use of an uninitialised variable
for the id will usually result in an error like:

  asoc-simple-card sound: parse error -11
  asoc-simple-card: probe of sound failed with error -11

Fix this by using and id of zero if no arg is provided.

Fixes: 9731f82d6016 ("ASoC: hdmi-codec: enable multi probe for same device")

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

Jyri, FYI, I believe this issue broke your commit df0bd1e8f3c508 ("ARM: dts:
am335x-boneblack: Add HDMI audio support")

 sound/soc/codecs/hdmi-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index b904492..6661ace 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -364,7 +364,7 @@ static int hdmi_of_xlate_dai_name(struct snd_soc_component *component,
 				  struct of_phandle_args *args,
 				  const char **dai_name)
 {
-	int id = args->args[0];
+	int id = args->args_count ? args->args[0] : 0;
 
 	if (id < ARRAY_SIZE(hdmi_dai_name)) {
 		*dai_name = hdmi_dai_name[id];
-- 
2.1.4
