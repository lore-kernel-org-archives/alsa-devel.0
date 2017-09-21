From: <jukka.hynninen@vaisala.com>
Subject: ASoC: pll/clkdiv issue with simple-card driver &
	WM8510/Atmel SSC
Date: Thu, 21 Sep 2017 12:20:35 +0000
Message-ID: <fb010881d59b49349649e06191c1cca5@HEL-EXCH-02.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com
 [193.143.230.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B3A2266819
 for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2017 14:22:26 +0200 (CEST)
Content-Language: en-US
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
List-Id: alsa-devel@alsa-project.org

Hi all,

We're looking into using the generic simple-card.c driver to glue together WM8510 codec driver and Atmel SSC platform driver without a specific machine code.

It turned out that the DTS configuration below fails to set the codec PLL and clkdiv values. In fact, wm8510_set_dai_pll() and wm8510_set_dai_clkdiv() get never called.

After adding following lines (omitting determination of myboard_* values) into wm8510_pcm_hw_params(), the audio starts working properly:

                           wm8510_set_dai_clkdiv(dai, WM8510_BCLKDIV, myboard_bclk_div);
                           wm8510_set_dai_pll(dai, 0, 0, 12000000, myboard_pll_out);
                           wm8510_set_dai_clkdiv(dai, WM8510_MCLKDIV, myboard_mclk_div);

What is actually the missing part? Did we forget to configure something in DTS?

Or is this a limitation of simple-card driver? If so, what would be the proper way to implement the missing features?

We're using Linux v4.14-rc1. The codec clock comes from a constantly running 12 MHz oscillator, and the codec is the clock and frame master.

DTS configuration is as follows:

	ahb {
		apb {
			ssc0: ssc@fff9c000 {
				#sound-dai-cells = <0>;
				status = "okay";
				dmas =	<&dma 1 AT91_DMA_CFG_PER_ID(5)>,
					<&dma 1 AT91_DMA_CFG_PER_ID(6)>;
				dma-names = "tx", "rx";
				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
			};

			spi0: spi@fffa4000{
				status = "okay";
				cs-gpios = <&pioB 3 0>, <&pioA 28 0>, <0>, <0>;

				audio_codec: wm8510@1 {
					#sound-dai-cells = <0>;
					compatible = "wlf,wm8510";
					spi-max-frequency = <2000000>;
					reg = <1>;
				};
		};
	};

                           sound {
                                                      compatible = "simple-audio-card";
                                                      simple-audio-card,name = "wm8510_WID";
                                                      simple-audio-card,format = "i2s";
                                                      simple-audio-card,routing = "Mono Out", "MONOOUT";

                                                      simple-audio-card,codec {
                                                                                  sound-dai = <&audio_codec>;
                                                                                  system-clock-frequency = <12000000>;
                                                                                  bitclock-master;
                                                                                  frame-master;
                                                      };

                                                      simple-audio-card,cpu {
                                                                                  sound-dai = <&ssc0>;
                                                      };
                           };

-Jukka
