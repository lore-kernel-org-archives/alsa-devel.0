From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] omap-abe-twl6040: Device tree support
Date: Tue,  8 May 2012 15:15:10 +0300
Message-ID: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 3228E243BD
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 14:15:14 +0200 (CEST)
Received: by lbbgj10 with SMTP id gj10so4273701lbb.9
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 05:15:12 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The following series adds device tree support for OMAP4+ based boards with
twl6040 codec.
The first three patch is for preparing the driver to be used with DT based
probing.

The dts structure used for this machine driver uses some of the features already
available in the core (thanks to the Tegra DT support).
The DAPM routing information is coming from dts.
The DAI link configuration also comes via DTS.
In order to handle the different number of PCMs (dai links) the dts file has to
tell the number of links (abe-twl6040,number-of-links) and has to contain the
same number of dai link phandle configuration in the form of:
dai-linkX,codec = <phandle to codec>;
dai-linkX,dai = <phandle to CPU dai>;

Where X is a number from 1...

In this way the driver can enumerate and fix up the dai link structure.

As an example of the dts section (SDP4430):

sound { /* ASoC */
	compatible = "ti,abe-twl6040";
	abe-twl6040,model = "SDP4430";

	abe-twl6040,jack_detection = <1>;
	abe-twl6040,mclk_freq = <38400000>;

	/* Number of DAI link connections */
	abe-twl6040,number-of-links = <2>;

	dai-link1,codec = <&twl6040_codec>;
	dai-link1,dai = <&mcpdm>;

	dai-link2,codec = <&dmic_codec>;
	dai-link2,dai = <&dmic>;

	/* Audio routing */
	abe-twl6040,audio-routing =
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

 .../devicetree/bindings/sound/omap-abe-twl6040.txt |   57 ++++++
 sound/soc/omap/omap-abe-twl6040.c                  |  199 ++++++++++++++-----
 2 files changed, 203 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt

-- 
1.7.8.6
