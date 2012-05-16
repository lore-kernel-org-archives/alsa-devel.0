From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/4] omap-abe-twl6040: Device tree support
Date: Wed, 16 May 2012 14:57:01 +0300
Message-ID: <1337169425-9449-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71]) by alsa0.perex.cz (Postfix) with ESMTP id 7BDFB245A3
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2012 13:57:23 +0200 (CEST)
Received: by lbom4 with SMTP id m4so530947lbo.2
	for <alsa-devel@alsa-project.org>; Wed, 16 May 2012 04:57:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: devicetree-discuss@lists.ozlabs.org, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,

Changes since v1:
- Binding docukentation updated with available pins and connectors
- dts section for abe-twl6040 sound configuration has been changed

Instead of dai link pairs only the nodes probed via DT have phandle:
ti,mcpdm; ti,dmic, ti,twl6040.
The driver in turn is responsible to handle the provided information.
To provide dai link pairs (cpu dai - codec) we would need Linux (ASoC) specific
nodes in DT for the dmic codec and twl6040 ASoC codec driver.

If the DT section have ti,dmic phandle the ASoC machine driver will register the
device to load the ASoC dmic-codec runtime.

Example dts section for audio support (SDP4430):
sound {
	compatible = "ti,abe-twl6040";
	ti,model = "SDP4430";

	ti,jack-detection = <1>;
	ti,mclk-freq = <38400000>;

	ti,mcpdm = <&mcpdm>;
	ti,dmic = <&dmic>;

	ti,twl6040 = <&twl6040>;

	/* Audio routing */
	ti,audio-routing =
		"Headset Stereophone", "HSOL",
		"Headset Stereophone", "HSOR",
		"Earphone Spk", "EP",
		"Ext Spk", "HFL",
		"Ext Spk", "HFR",
		"Line Out", "AUXL",
		"Line Out", "AUXR",
		"Vibrator", "VIBRAL",
		"Vibrator", "VIBRAR",
		"HSMIC", "Headset Mic",
		"Headset Mic", "Headset Mic Bias",
		"MAINMIC", "Main Handset Mic",
		"Main Handset Mic", "Main Mic Bias",
		"SUBMIC", "Sub Handset Mic",
		"Sub Handset Mic", "Main Mic Bias",
		"AFML", "Line In",
		"AFMR", "Line In",
		"DMic", "Digital Mic",
		"Digital Mic", "Digital Mic1 Bias";
};


Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: omap-abe-twl6040: Keep only one snd_soc_dai_link structure
  ASoC: omap-abe-twl6040: Move Digital Mic widget into dapm table
  ASoC: omap-abe-twl6040: Introduce driver data for runtime parameters
  ASoC: omap-abe-twl6040: Add device tree support

 .../devicetree/bindings/sound/omap-abe-twl6040.txt |   91 +++++++++
 sound/soc/omap/omap-abe-twl6040.c                  |  195 ++++++++++++++------
 2 files changed, 230 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt

-- 
1.7.8.6
