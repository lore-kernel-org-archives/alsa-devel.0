From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 0/7] Let Atmel use simple-audio-card
Date: Tue, 30 Jan 2018 12:06:04 +0100
Message-ID: <20180130110604.GA18123@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A7032671F2
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 12:06:07 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23994711AbeA3LGFKK3M0 (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Tue, 30 Jan 2018 12:06:05 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Alexandre,

following patchset is sent as a bare minimum I need to use
MAX9867 codec in master mode on AT91SAM9G20 based board.

Codec's MCLK is driven by PCK0 and SSC is wired as follows:
RK0 <-- BCLK
RF0 <-- LRCLK
TD0 --> SDIN
RD0 <-- SDOUT

Following DT framgment was used:

	i2c-gpio-0 {
		codec: max9867@18 {
			compatible = "maxim,max9867";
			reg = <0x18>;
			#sound-dai-cells = <0>;
		};
	};

	sound {
		compatible = "simple-audio-card";

		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_pck0_as_mck>;

		simple-audio-card,name = "simear4-max9867";
		simple-audio-card,format = "i2s";
		simple-audio-card,bitclock-master = <&codec_dai>;
		simple-audio-card,frame-master = <&codec_dai>;
		simple-audio-card,routing =
				"LINE_IN", "Line In Jack",
				"Speaker", "HPOUT";
		simple-audio-card,widgets =
				"Line", "Line In Jack",
				"Speaker", "Speaker";

		cpu_dai: simple-audio-card,cpu {
			sound-dai = <&ssc0>;
		};

		codec_dai: simple-audio-card,codec {
			sound-dai = <&codec>;
			clocks = <&pck0>;
			clock-frequency = <12384000>;
		};
	};

&ssc0 {
	status = "okay";
	pinctrl-0 = <&pinctrl_board_ssc0_tx &pinctrl_ssc0_rx>;
	atmel,clk-from-rk-pin;
	#sound-dai-cells = <0>;
};


Codec code itself seems to be unused since it was merged and I'm
wondering whenever it worked at all. A comment from codec author
would help a lot, just to be sure I did not break anything.

By no means this code is ready to be merged (only except those patches
with commit log and after carefull consideration :)), I'm posting it as
a base for discussion.

Thank you,
	ladis

Ladislav Michl (7):
  ASoC: atmel: Remove redundant dev_err() call in probe function
  ASoC: atmel_ssc_dai: Fix TCMR settings in I2S slave mode
  ASoC: simple_card_utils: Set clock frequency
  ASoC: max9867: Show Kconfig entry
  ASoC: max9867: Calculate LRCLK divider
  ASoC: max9867: Fix BSEL value in master mode.
  ASoC: max9867: Take chip out of shutdown

 sound/soc/atmel/atmel-classd.c        |   7 +--
 sound/soc/atmel/atmel-pdmic.c         |   7 +--
 sound/soc/atmel/atmel_ssc_dai.c       |   2 +-
 sound/soc/codecs/Kconfig              |   3 +-
 sound/soc/codecs/max9867.c            | 110 +++-------------------------------
 sound/soc/generic/simple-card-utils.c |   4 ++
 6 files changed, 19 insertions(+), 114 deletions(-)

-- 
2.15.1
