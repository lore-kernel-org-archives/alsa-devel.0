Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E26FCA5FD4
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:55:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E9B46027A;
	Fri,  2 Oct 2026 13:55:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E9B46027A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790942136;
	bh=3ou2V5R3l2JpJxQU/1Z9MtQegy8o+BlVEMz4BPgHQTA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=akRx5Ik7Zz0iQmxEGYyny4C8hSe5Ts3GTaE1MkdObgKrYIjZCnxGVJDPFKkWR1T2/
	 ZT3Ndb/mSS7O4ysUFgD5HR4jSPlQw38v5XLbCST3jlPesirlU0oJ5r7hxouCj9ZVai
	 RiJ8PLHXfbkRLhpd1h1uIFWsH7OUXA5QoptPkPmo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09082F805FB; Fri,  2 Oct 2026 13:55:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B1D82F80602;
	Fri,  2 Oct 2026 13:55:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51131F805BA; Fri,  2 Oct 2026 13:54:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790942089;
	b=W2MOauCdGSJbzEdxNVrsIO9z1I13UeUxq/8wI+joc+gRsIiU3coN4sYeGGJEqC6TDAf5
	 9nQQ4kELNPTsQkcle/LFv7ZnN1cbuGwLBcu3pBerHcRktZpPXSBzRlRWMbcNWhISjYzMW
	 Ze69Vnp4bW+u/Ww7sGUdSyGxf7ikG64WUi0y/VZU5+sP3xWxaOx/AEnUlNZ2JKz7n/b/k
	 X2RQBJrUtJJ3Yxeo9EHe5Evdz1zuwXyuBhDZNtA+3y/gew7i1lCOmNyyaMPOJUuBbblL1
	 0I/ESfGGjtTGvZ6gIqRrbXKLfng/5pJgpbSIdTzvQnQcHsheGmajFken2qvfgtsw8Sw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790942089;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id;
	bh=3ou2V5R3l2JpJxQU/1Z9MtQegy8o+BlVEMz4BPgHQTA=;
	b=TkDSAM+iZPt7vaSz2FWP+Uht2M1w0119srVT0B3KPuf51V7QwCbzfi0al+MwdpOMKsuh
	 IciyanqOOyHL1w2IXdITEmImWZjwMCeBfarMML0IQ3GZkn7ruYhI9046MSW1cmWxBXY5F
	 fyet88JPaL8+9snXeW/zadPlmR+J9PoFvO+Gq52p1cwPu4EAWKnRB+6YqDV1wk6pMXkqQ
	 6f4JmLxJsYInQom5v7UuBWFf18B7pD35K893Gxh8UR6uRKSw5Eq5kHbi6AWYATsSqRGR9
	 el9Xvk2klE0NHnBgGnhFnZ9xeFrT4r0TY2I1HrWn95ox9sMDTzekrTt/XJZcbunMJzw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="Cv6/hoil";
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DDFEFF80424
	for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2026 13:54:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDFEFF80424
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Cv6/hoil
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 594BD423BD;
	Fri,  2 Oct 2026 11:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4E41F000FF;
	Fri,  2 Oct 2026 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790942084;
	bh=n3dXzyS03OM7KjG4rehn3p0h3qVqlpSUvqBo0MWFO2o=;
	h=From:To:Cc:Subject:Date;
	b=Cv6/hoilPBC6jndKnMz1eokhD06WiIJljRQHNHeX2sGvcTz4G50fxa0WIdWiuRlGI
	 LKrrqG4GPYK3ng3PtMTnwSHdad6BbRg4yR7JR3QpJfDHd4B1eFOxCiZfvTbDjhc7gF
	 nA81E3X1Ejeh2LVBxNPIltUX+WxiyKyAXk4mKrcULVs11e0TKI4/0ybzfjy8WRJ07X
	 k8mZY7yuPfn/8kaIq0sQUUdM8evXQ+/IQ9zOduXfsveaIH39LitlHe9/akrVuXhNig
	 q7OiNCnnyGrPT23VMahg5wbc+HdtGZuu8BukFLeyjOVR9A3zLQCALdGCG8cUz/nvhT
	 taml3z25IEUjw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id DD6341AC57CB; Fri, 02 Oct 2026 12:54:38 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.3-rc5
Date: Fri, 02 Oct 2026 12:54:27 +0100
Message-Id: <20261002115438.DD6341AC57CB@finisterre.sirena.org.uk>
Message-ID-Hash: JPMDOMXKGLZJ7BZJ27DXVR3633AWCDQ5
X-Message-ID-Hash: JPMDOMXKGLZJ7BZJ27DXVR3633AWCDQ5
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JPMDOMXKGLZJ7BZJ27DXVR3633AWCDQ5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e:

  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-rc5

for you to fetch changes up to 923ff8155ef6e83b73b852300d50f2053b969552:

  ASoC: rt712: avoid duplicate reset in io_init (2026-10-01 13:52:06 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.4

A bigger collection of fixes than usual due to your vacation but nothing
hugely remarkable here, just fairly standard quirks and driver specific
bugfixes.

----------------------------------------------------------------
Alexander Koch (2):
      ASoC: codecs: ak4619: Add optional powerdown GPIO
      ASoC: dt-bindings: asahi-kasei,ak4619: Add powerdown GPIO

Andrey Golovko (3):
      ASoC: tas2783-sdw: make multi-byte MBQ registers reachable
      ASoC: tas2783-sdw: do not cache read-only Controls
      ASoC: tas2783-sdw: stop describing the Latency and XU ID/Version Controls

Andy Shevchenko (8):
      ASoC: stm32: spdifrx: Drop mention of the deprecated and unused call
      ASoC: sprd: Replace dma_request_slave_channel() by dma_request_chan()
      ASoC: soc-generic-dmaengine-pcm: Replace dma_request_slave_channel() by dma_request_chan()
      ASoC: pxa: Replace dma_request_slave_channel() by dma_request_chan()
      ASoC: fsl_asrc: Replace dma_request_slave_channel() by dma_request_chan()
      gpib: fmh_gpib: Replace dma_request_slave_channel() by dma_request_chan()
      dmaengine: Remove deprecated dma_request_slave_channel()
      ASoC: sprd: Shadow errors from dma_request_chan()

Arnd Bergmann (2):
      ASoC: rt766: fix HID dependency for SND_SOC_SDCA_HID
      ASoC: amd: acp: add EFI dependency for selecting TAS2783

Baojun Xu (1):
      ASoC: tas2783-sdw: add firmware download status check

Bard Liao (8):
      ASoC: SOF: get nhlt from all topologies
      ALSA: intel-nhlt: lower intel_nhlt_ssp_device_type log level
      ASoC: Intel: sof-function-topology-lib: create common helpers
      ASoC: Intel: sof-function-topology-lib: skip non-exist file in best_effort mode
      ASoC: Intel: sof-function-topology-lib: add I2S support for sof_sdw_get_tplg_files
      ASoC: Intel: sof-function-topology-lib: add get_function_topology for I2S machines
      ASoC: soc-acpi-intel-ptl-match: I2S machines: use function topology
      ASoC: Intel: sof-function-topology-lib: fix sscanf type

Bill Wendling (1):
      firmware: cs_dsp: Annotate struct cs_dsp_coeff_ctl with __counted_by_ptr

Cezary Rojewski (6):
      ASoC: Intel: avs: Use list_count_nodes() to simplify the code
      ASoC: codecs: hda: Use list_count_nodes() to simplify the code
      ASoC: Intel: avs: Remove topology-loading wrappers
      ASoC: codecs: rt5514: Fix the pm_ops constant name
      ASoC: codecs: rt286: Revert delay value for jack setup
      ASoC: codecs: rt274: Fix format setting for 44100 rate

Chancel Liu (32):
      ASoC: fsl_mqs: Add DAPM output widgets for MQS_L/MQS_R pins
      ASoC: wm8962: Fix regulator notifier and beep leaks on card re-bind
      ASoC: wm8995: Register regulator notifiers from the bus probe
      ASoC: tlv320aic31xx: Register regulator notifier from the I2C probe
      ASoC: tlv320aic3x: Register regulator notifier from the bus probe
      ASoC: cs42l52: Fix beep input device leak on card re-bind
      ASoC: cs42l56: Fix beep input device leak on card re-bind
      ASoC: simple-card-utils: Add simple_util_remove_jack()
      ASoC: simple-card: Free jack GPIOs on card remove
      ASoC: audio-graph-card: Free jack GPIOs on card remove
      ASoC: audio-graph-card2: Free jack GPIOs on card remove
      ASoC: codecs: cpcap: Fix devm resource leaks across card bind/unbind
      ASoC: codecs: da7218: Fix devm resource leaks across card bind/unbind
      ASoC: codecs: tlv320aic32x4: Fix clock leak from runtime callbacks
      ASoC: codecs: twl4030: Acquire board params and hs_extmute GPIO in the platform probe
      ASoC: codecs: es8316: Move mclk acquisition to the i2c probe
      ASoC: codecs: es8323: Move mclk acquisition to the i2c probe
      ASoC: codecs: es8311: Move mclk acquisition to the i2c probe
      ASoC: codecs: es8328: Move clk acquisition to the bus probe
      ASoC: codecs: rt5640: Move mclk acquisition to the i2c probe
      ASoC: codecs: rt5616: Move mclk acquisition to the i2c probe
      ASoC: codecs: rt5514: Move clk acquisition to the i2c probe
      ASoC: codecs: rt5682s: Move mclk acquisition to the i2c probe
      ASoC: codecs: max98090: Move mclk acquisition to the i2c probe
      ASoC: codecs: max98095: Move mclk acquisition to the i2c probe
      ASoC: codecs: wm8985: Move regulator acquisition to the bus probe
      ASoC: codecs: wm8955: Move regulator acquisition to the i2c probe
      ASoC: codecs: es8389: Move regulator and mclk acquisition to the i2c probe
      ASoC: codecs: rt5677-spi: Free the DSP context on component remove
      ASoC: codecs: rt1011: Free the bq/drc coefficient arrays on component remove
      ASoC: codecs: rt5645: Free the hardware EQ parameters on component remove
      ASoC: codecs: rt5514-spi: Free the DSP context on component remove

Charles Keepax (2):
      ASoC: soc-ops: Clarify kernel doc for snd_soc_info_volsw_xs()
      ASoC: SDCA: Remove redundant comment

Christian Marangi (6):
      ASoC: dt-bindings: Add Airoha AN7581 AFE Sound card
      ASoC: dt-bindings: Add Airoha AN7581 AFE with WM8960 Codec schema
      ASoC: mediatek: common: permit to provide dedicated regmap for irq
      ASoC: airoha: Add AFE driver for Airoha AN7581
      ASoC: airoha: Add machine driver for Airoha AN7581
      ASoC: airoha: Fix sparse warning for AN7581 AFE PCM

David Cemin (1):
      ASoC: sdw_utils: clear stale RT711 device reference on exit

David Heidelberg (6):
      ASoC: wcd-mbhc-v2: Fix incorrect properties names and typos
      ASoC: qcom: sdm845: Demystify TDM masks a bit
      ASoC: qcom: sdm845: use DSP_A format for TDM codec DAIs
      ASoC: qcom: sdm845: Use per-speaker RX masks for TDM slot assignment
      ASoC: qcom: sdm845: Set codec dai and component sysclk during startup
      ASoC: cs35l36: Implement set_tdm_slot to program RX and TX slots

Diogo Ivo (1):
      ASoC: dt-bindings: realtek,rt5677: Add MCLK1 clock property

Eduard Bostina (1):
      ASoC: dt-bindings: Convert TI DA830 EVM audio to DT schema

Geert Uytterhoeven (3):
      ASoC: codecs: lpass: Make sure clk_init_data is fully initialized
      ASoC: codecs: wcd934x: Make sure clk_init_data is fully initialized
      ASoC: tlv320aic32x4: Make sure clk_init_data is fully initialized

Guangshuo Li (1):
      ASoC: Intel: atom: Fix platform device leak on probe failure

Hemanth Selam (4):
      regmap: fix typo "asynchrnous" in comment
      ASoC: codecs: fix typos in comments
      firmware: cirrus: fix typo "upto" in comment
      ASoC: fix typos in comments

Hongyang Zhao (5):
      ASoC: dt-bindings: es8316: Document jack detect inversion
      ASoC: dt-bindings: qcom,sm8250: Add RubikPi 3 sound card
      ASoC: qcom: common: Add generic headset jack helpers
      ASoC: qcom: sc8280xp: Add per-DAI board configuration
      ASoC: qcom: sc8280xp: Add RubikPi 3 sound card support

Jack Yu (1):
      ASoC: rt1320: make SRAM registers readable to stop being cached

James Calligeros (2):
      ASoC: tas2764: Initialise SDZ GPIO low
      ASoC: tas2770: Initialise SDZ GPIO low

Jiangshan Yi (2):
      ASoC: codecs: max98363: fix uninitialized stream_config->type
      ASoC: codecs: rt1017-sdca-sdw: fix uninitialized stream_config->type

Junjie Cao (1):
      ASoC: rt712-sdca-dmic: fix drvdata type in the gain controls

Karl Asseily (4):
      dt-bindings: vendor-prefixes: add ESS Technology
      ASoC: dt-bindings: add ESS Technology ES9039Q2M
      ASoC: es9039q2m: add ESS Technology ES9039Q2M codec driver
      MAINTAINERS: add entry for the ES9039Q2M codec driver

Kees Cook (4):
      ASoC: rockchip: rk3399_gru_sound: Allocate dai_link with ARRAY_SIZE()
      ASoC: codecs: wm8904: Add const to drc_texts allocation type
      ASoC: codecs: wm8958: Add const to enum texts allocation types
      ASoC: SOF: topology: Add const to tplg_files allocation type

Khanh Le (1):
      ASoC: ak4619: Add suspend and resume callbacks

Krzysztof Kozlowski (2):
      ASoC: dt-bindings: imx-audmux: Replace tabs with spaces
      ASoC: dt-bindings: Use consistent indentation in the example

Kuninori Morimoto (81):
      ASoC: soc-card: don't use card->dai_link[] in for_each_card_prelinks()
      ASoC: soc-core: make fmt_{single/multiple}_name() non static
      ASoC: soc-dai: move snd_soc_add_dai_controls()
      ASoC: soc-dai: move snd_soc_dai_name_get()
      ASoC: soc-dai: move snd_soc_is_match_dai_args()
      ASoC: soc-dai: move snd_soc_is_matching_dai()
      ASoC: soc-dai: move snd_soc_{un}register_dai()
      ASoC: soc-dai: move soc_pcm_set_dai_params()
      ASoC: soc-dai: move soc_pcm_{apply/params/update}_symmetry()
      ASoC: soc-dai: move snd_soc_dai_get_pcm_stream() to soc-dai.c
      ASoC: soc-dai: move snd_soc_dai_{get/set}_widget() to soc-dai.c
      ASoC: soc-dai: move snd_soc_dai_dma_data_{get/set}() to soc-dai.c
      ASoC: soc-dai: move snd_soc_dai_tdm_mask_{get/set}() to soc-dai.c
      ASoC: soc-dai: move snd_soc_dai_stream_active() to soc-dai.c
      ASoC: soc-dai: move snd_soc_dai_{set/get}_stream() to soc-dai.c
      ASoC: codecs: 88pm860x: use .auto_selectable_formats
      ASoC: codecs: ab8500: use .auto_selectable_formats
      ASoC: codecs: adau*: use .auto_selectable_formats
      ASoC: codecs: ak4*: use .auto_selectable_formats
      ASoC: codecs: ak5*: use .auto_selectable_formats
      ASoC: codecs: alc56*: use .auto_selectable_formats
      ASoC: codecs: arizona: use .auto_selectable_formats
      ASoC: codecs: cpcap: use .auto_selectable_formats
      ASoC: codecs: cs35l*: use .auto_selectable_formats
      ASoC: codecs: cs42*: use .auto_selectable_formats
      ASoC: codecs: cs5*: use .auto_selectable_formats
      ASoC: codecs: cx2072x: use .auto_selectable_formats
      ASoC: codecs: da*: use .auto_selectable_formats
      ASoC: codecs: es*: use .auto_selectable_formats
      ASoC: codecs: inno_rk3036: use .auto_selectable_formats
      ASoC: codecs: isabelle: use .auto_selectable_formats
      ASoC: codecs: lm49453: use .auto_selectable_formats
      ASoC: codecs: max*: use .auto_selectable_formats
      ASoC: codecs: mc13783: use .auto_selectable_formats
      ASoC: codecs: ml26124: use .auto_selectable_formats
      ASoC: codecs: nau*: use .auto_selectable_formats
      ASoC: codecs: ntp8*: use .auto_selectable_formats
      ASoC: codecs: rk33*: use .auto_selectable_formats
      ASoC: codecs: rtq912*: use .auto_selectable_formats
      ASoC: codecs: rt*: use .auto_selectable_formats
      ASoC: codecs: sgtl5000: use .auto_selectable_formats
      ASoC: codecs: si476x: use .auto_selectable_formats
      ASoC: codecs: sma130*: use .auto_selectable_formats
      ASoC: codecs: src4xxx: use .auto_selectable_formats
      ASoC: codecs: ssm*: use .auto_selectable_formats
      ASoC: codecs: sta*: use .auto_selectable_formats
      ASoC: codecs: tas*: use .auto_selectable_formats
      ASoC: codecs: tfa9879: use .auto_selectable_formats
      ASoC: codecs: tlv320*: use .auto_selectable_formats
      ASoC: codecs: tscs454: use .auto_selectable_formats
      ASoC: codecs: twl4030: use .auto_selectable_formats
      ASoC: codecs: uda13*: use .auto_selectable_formats
      ASoC: codecs: wm*: use .auto_selectable_formats
      ASoC: codecs: zl38060: use .auto_selectable_formats
      ASoC: dwc: use .auto_selectable_formats
      ASoC: hisilicon: use .auto_selectable_formats
      ASoC: img: use .auto_selectable_formats
      ASoC: jz4740: use .auto_selectable_formats
      ASoC: kirkwood: use .auto_selectable_formats
      ASoC: loongson: use .auto_selectable_formats
      ASoC: mxs: use .auto_selectable_formats
      ASoC: pxa: use .auto_selectable_formats
      ASoC: renesas: use .auto_selectable_formats
      ASoC: rockchip: use .auto_selectable_formats
      ASoC: sti: use .auto_selectable_formats
      ASoC: stm: use .auto_selectable_formats
      ASoC: sunxi: use .auto_selectable_formats
      ASoC: tegra: use .auto_selectable_formats
      ASoC: ti: use .auto_selectable_formats
      ASoC: uniphier: use .auto_selectable_formats
      ASoC: ux500: use .auto_selectable_formats
      ASoC: xtensa: use .auto_selectable_formats
      ASoC: soc-dai: use snd_soc_dai_stream_active()
      ASoC: soc-dai: add snd_soc_dai_id()
      ASoC: soc-dai: add snd_soc_dai_to_component()
      ASoC: soc-dai: add snd_soc_dai_to_driver()
      ASoC: soc-dai: add snd_soc_dai_{to/from}_list()
      ASoC: soc-dai: add snd_soc_dai_get_symmetric_xxx()
      ASoC: soc-dai: add snd_soc_dai_{set/to}_priv()
      ASoC: soc-dai: add snd_soc_dai_get_bclk[_ratio]()
      ASoC: soc-dai: rename snd_soc_dai_action() to snd_soc_dai_active_update()

Linus Walleij (4):
      ASoC: dt-bindings: sound: Prepare Ux500 audio graph links
      ASoC: dt-bindings: ux500: Remove MOP500 sound card binding
      ASoC: ab8500: Skip digital microphone support on AB8505
      ASoC: ux500: Remove the MOP500 machine driver

Ma Ke (1):
      ASoC: wcd9335: Fix device reference leak in wcd9335_slim_status()

Maciej Strozek (2):
      ASoC: SDCA: Improve scanning the SWFT during FDL
      ASoC: SDCA: Check return value on a missing FDL_Set_Index Range

Mark Brown (40):
      Merge remote-tracking branch 'asoc/for-7.2' into asoc-linus
      ASoC: samsung: Improve probe error handling
      ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
      ASoC: Make sure clk_init_data is fully initialized
      regmap: Allow a base register to be specified for the RAM regmap
      regmap: Test rbtree and maple caches for very high register numbers
      ASoC: add Senary SN624x SoundWire SDCA support
      regmap: irq: Free the irqdomain we create
      ASoC: Introduces MDSYNC support for CS35L45
      ASoC: SDCA: SimpleJack support and small cleanup
      ASoC: mediatek: mt8186: Fix clock error handling
      ASoC: mediatek: mt6797: Fix error handling
      ASoC: codecs: lpass-macros: switch regcache to REGCACHE_MAPLE
      ASoC: tas2783-sdw: fix the read-only Control handling
      ASoC: soc-dai: move snd_soc_xx() to soc-dai.c
      ASoC: codec: use .auto_selectable_formats
      ASoC: use .auto_selectable_formats
      ASoC: codecs: Fix resource leaks on card re-bind
      ASoC: Use devm_of_reserved_mem_device_init()
      ASoC: generic: Free jack GPIOs on card remove
      ASoC: codecs: ES8326: Modify the configuration and add kcontrol
      ASoC: codecs: nau8360: Fix DSP routing and deadlock issues
      ASoC: SOF: amd: SoundWire and PDM support and fixes for ACP7.B/7.F
      ASoC: mediatek: mt8189: Improve error handling
      ASoC: add ESS Technology ES9039Q2M codec driver
      ASoC: Add support for Airoha AN7581
      ASoC et alia: Convert to use dma_request_chan()
      ALSA/ASoC: Intel: add I2S function topology support
      Merge remote-tracking branch 'regmap/for-7.4' into regmap-next
      ASoC: codecs: Fix resource leaks across card bind/unbind
      ASoC: qcom: Add QAIF AIF MI2S and TDM DAI support
      ASoC: codecs: propagate component resume cache sync failures
      ASoC: mediatek: mt8188: Improve error handling
      ASoC: mediatek: mt8183: Fix clock error handling
      ASoC: amd: Fix borrowed ACPI codec device references
      ASoC: add new DAI functions
      ASoC: mediatek: mt8192: Improve error handling
      ASoC: fsl_asrc/fsl_easrc: expose per-pair/context DAIs and fix DMA race
      ASoC: codecs: ak4619: Add PDN pin handling
      ASoC: Qualcomm Tambora (WCD9378) SDCA codec

Mohammad Rafi Shaik (3):
      ASoC: dt-bindings: qcom: add QAIF AIF MI2S and TDM dai ids
      ASoC: qcom: qdsp6: lpass-ports: add support for QAIF AIF MI2S and TDM dais
      ASoC: qcom: sc8280xp: Handle AIF MI2S and TDM interfaces

Mukesh Ojha (11):
      ASoC: mediatek: mt8192: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8196: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8183: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8189: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8173: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8188: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
      ASoC: SOF: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
      ASoC: SOF: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
      ASoC: sprd: Use devm_of_reserved_mem_device_init()

Myeonghun Pak (1):
      ASoC: fsl_xcvr: free IRQ before canceling reset work

Neo Chang (8):
      ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
      ASoC: codecs: nau8360: Add support for NAU83G60 amplifier
      ASoC: codecs: nau8360: Fix static declarations and endianness
      ASoC: codecs: nau8360: Fix kernel-doc issues
      ASoC: codecs: nau8360: Add default PEQ band number for DSP init
      ASoC: codecs: nau8360: Fix misleading return in nau8360_message_to_dsp()
      ASoC: codecs: nau8360: Block DSP path selection when firmware load fails
      ASoC: codecs: nau8360: Fix AB-BA deadlock in mux update

Oder Chiou (2):
      ASoC: rt721: Use the function_status check to avoid duplicate presets
      ASoC: rt721: Add support for the RT721_U and RT718 codec variants

Peng Fan (2):
      ASoC: use regmap_assign_bits() for conditional set/clear
      ASoC: soc-generic-dmaengine-pcm: use dmaengine_get_dma_device() for DMA device

Pengpeng Hou (23):
      ASoC: report component resume callback errors
      ASoC: es8326: report resume restore errors
      ASoC: es8375: report resume restore errors
      ASoC: es8389: report resume restore errors
      ASoC: fs210x: report register restore errors
      ASoC: codecs: sma1307: validate setting firmware layout
      ASoC: sta32x: make power restoration transactional
      ASoC: nau8822: keep regcache offline while supplies are off
      ASoC: rt1015: make control calibration failures observable
      ASoC: adau17x1: return cache sync errors from resume
      ASoC: ak4642: return cache sync errors from resume
      ASoC: es8316: return cache sync errors from resume
      ASoC: es8323: return cache sync errors from resume
      ASoC: nau8540: return cache sync errors from resume
      ASoC: rt1011: return cache sync errors from resume
      ASoC: rt1016: return cache sync errors from resume
      ASoC: rt1305: return cache sync errors from resume
      ASoC: rt1308: return cache sync errors from resume
      ASoC: rt1318: return cache sync errors from resume
      ASoC: rt5616: return cache sync errors from resume
      ASoC: rt5659: return cache sync errors from resume
      ASoC: rt5660: return cache sync errors from resume
      ASoC: rt5665: return cache sync errors from resume

Peter Robinson (1):
      ASoC: pcm5102a: Add support for optional reset gpio

Qianghua Wang (3):
      ASoC: codecs: add SN624x SDCA SoundWire driver
      ASoC: sdw_utils: add Senary SN624x helpers and codec_info
      ASoC: Intel: soc-acpi: add SN624x entries for ARL/LNL/MTL/PTL

Ricardo Rivera-Matos (2):
      ASoC: dt-bindings: cs35l45: Adds SYNC properties
      ASoC: cs35l45: Adds support for SYNC bus

Richard Fitzgerald (1):
      ASoC: cs35l56: Add KUnit tests for regmap defaults table

Rob Herring (Arm) (6):
      ASoC: ak4642: Drop "clocks" property presence check
      ASoC: twl4030: Fix "ti,hs_extmute" property type
      ASoC: sta3xx: Fix "st,drop-compensation-ns" size
      ASoC: dt-bindings: mediatek: Fix MT7622 clock count
      ASoC: dt-bindings: hi6210-i2s: Allow graph ports
      ASoC: dt-bindings: Fix TAS2563 address constraints

Rosen Penev (4):
      ASoC: uniphier: aio-dma: pass chip to irq handler
      ASoC: tegra: ADX: convert map to flexible array
      ASoC: xilinx: formatter_pcm: use more devm in probe
      ASoC: fsl: mpc5200: gate AC97 driver on PPC_MPC52xx

Runyu Xiao (1):
      ASoC: pcm6240: do not free an unrequested IRQ

Seiji Adachi (1):
      ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to quirks

Shenghao Ding (4):
      ASoC: tas2781: add support for TAS2573 DSP functionality
      ASoC: tas2781: Add register decoded info to I/O error logs
      ASoC: tas2781: Add TAS2573 calibration support
      ASoC: tas2781: Refactor register error log with unified macro

Shengjiu Wang (6):
      ASoC: fsl_asrc: use regmap_write_bits to update clock source registers
      ASoC: dt-bindings: fsl,imx-asrc: update port binding to support multiple paths
      ASoC: dt-bindings: fsl,easrc: add ports binding for multiple conversion paths
      ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
      ASoC: fsl_asrc: expose individual DAIs per conversion path
      ASoC: fsl_easrc: expose individual DAIs per conversion path

Shuming Fan (5):
      ASoC: rt1320: avoid re-initialize in advanced mode
      ASoC: rt712: add GPIOs for LED control
      ASoC: sdw_utils: Add rt766/rt767 support
      ASoC: rt766: avoid re-initialize the blind write
      ASoC: rt712: avoid duplicate reset in io_init

Slavin Liu (1):
      ASoC: fsl_asrc: check the second front-end DMA channel

Srinivas Kandagatla (15):
      ASoC: SDCA: register SDCA_FUNCTION_TYPE_SIMPLE_JACK in class function driver
      ASoC: SDCA: make find_sdca_control_reset() return void
      ASoC: codecs: lpass-wsa-macro: use v2.5 Compander1 addresses on v2.5+
      ASoC: codecs: lpass-{rx,wsa}-macro: sort reg_defaults before regmap init
      ASoC: codecs: lpass-wsa-macro: switch cache to REGCACHE_MAPLE
      ASoC: codecs: lpass-rx-macro: switch cache to REGCACHE_MAPLE
      ASoC: codecs: lpass-tx-macro: switch cache to REGCACHE_MAPLE
      ASoC: codecs: lpass-va-macro: switch cache to REGCACHE_MAPLE
      ASoC: SDCA: allow building without ACPI
      ASoC: SDCA: export PM helpers keyed on sdca_class_drv
      ASoC: SDCA: expose class SoundWire probe/remove as library
      ASoC: SDCA: add class_ops with populate_function
      ASoC: SDCA: class_function: xlate sound-dai cell by entity index
      ASoC: dt-bindings: qcom: add Tambora WCD9378 SDCA codec
      ASoC: codecs: add Qualcomm Tambora (WCD9378) SDCA codec

Syed Saba Kareem (2):
      ASoC: amd: acp: enable TAS2783 and add RT712-VB SoundWire machine
      ASoC: amd: acp: fix TAS2783 SoundWire codec unmet dependencies

Vijendar Mukunda (11):
      ASoC: SOF: amd: return -EINVAL for unknown PCI revision in acp7x suspend
      ASoC: SOF: amd: fix amd_sof_acp_remove() teardown ordering
      ASoC: SOF: amd: fix amd_sof_acp_probe() error unwind ordering
      ASoC: SOF: amd: add ACP7.B/7.F PDM controller scan and pdata propagation
      ASoC: SOF: amd: update SoundWire specific acp descriptor fields for ACP7.B/7.F
      ASoC: SOF: amd: enable SoundWire build for ACP7.B/7.F
      ASoC: SOF: amd: wire SoundWire probe and remove into ACP7.B/7.F paths
      ASoC: SOF: amd: add ACP7.B/7.F clock-stop detection in check_acp_sdw_enable_status
      ASoC: SOF: amd: add ACP7.B/7.F SoundWire IO IRQ handling
      ASoC: SOF: amd: enable SoundWire host wake interrupt in acp_init
      ASoC: SOF: amd: add SoundWire PM ops for ACP7.B/7.F

Wentao Liang (6):
      ASoC: wm8994: Fix runtime PM imbalance in wm8994_component_probe()
      ASoC: arizona-jack: Fix runtime PM imbalance in arizona_start_hpdet_acc_id()
      ASoC: audio-graph-card2: Fix use-after-free in audio_graph2_link_c2c()
      ASoC: codecs: wm8994: Fix runtime PM leak in wm8994_mic_detect()
      ASoC: ti: davinci-mcasp: Fix runtime PM imbalance in __davinci_mcasp_set_clkdiv()
      ASoC: codecs: wcd9335: Fix SLIM interface device leak in wcd9335_slim_status()

Yibo Tan (2):
      ASoC: amd: acp-es8336: Use an owned codec device reference
      ASoC: amd: acp3x-es83xx: Keep an owned codec device reference

Zain Aboobacker (2):
      ASoC: dt-bindings: foursemi,fs2105s: Fix typo
      ASoC: codecs: nau8825: fix typos in comments

Zhang Yi (2):
      ASoC: codecs: ES8326: Add private members about HPF
      ASoC: codecs: ES8326: Adjust the standby configuration

bui duc phuc (65):
      ASoC: samsung: aries_wm8994: Preserve gpiod_to_irq() error codes
      ASoC: samsung: aries_wm8994: Drop redundant probe error messages
      ASoC: samsung: pcm: Use dev_err_probe() for error handling
      ASoC: samsung: pcm: Drop redundant probe error messages
      ASoC: samsung: spdif: Drop redundant probe error messages
      ASoC: samsung: tm2_wm5110: Drop redundant probe error messages
      ASoC: mediatek: mt8173: Fix clock error handling
      ASoC: mediatek: mt8173: Use dev_err_probe() for error handling
      ASoC: mediatek: mt8173: Drop redundant probe error messages
      ASoC: mediatek: mt2701: Use devm_clk_get_optional() for audio_mrgif_pd
      ASoC: mediatek: mt2701: Use dev_err_probe() for error handling
      ASoC: mediatek: mt2701: Drop redundant probe error messages
      ASoC: mediatek: mt7986: Drop redundant probe error messages
      ASoC: mediatek: mt8186: Fix APLL mux setting error handling
      ASoC: mediatek: mt8186: Fix clock handling in mux disable path
      ASoC: mediatek: mt8186: Fix AFE clock error handling
      ASoC: mediatek: mt8186: Fix APLL enable error handling
      ASoC: mediatek: mt8186: Fix MCK error handling
      ASoC: mediatek: mt8186: Fix gpio rollback on adda dl/ul partial failure
      ASoC: mediatek: mt8186: Handle regcache sync failure
      ASoC: mediatek: mt8186: Drop redundant probe error messages
      ASoC: mediatek: mt6797: fix wrong unwind order and error code in enable_clock
      ASoC: mediatek: mt6797: Use dev_err_probe() for error handling
      ASoC: mediatek: mt6797: Drop redundant probe error messages
      ASoC: codecs: pcm6240: Return 0 explicitly on success
      ASoC: mediatek: mt8189: Propagate APLL enable errors
      ASoC: mediatek: mt8189: Propagate MCK enable errors
      ASoC: mediatek: mt8189: Validate MCK ID
      ASoC: mediatek: mt8189: Propagate reg_rw clock errors
      ASoC: mediatek: mt8189: Use dev_err_probe() for clock errors
      ASoC: mediatek: mt8189: Propagate runtime resume errors
      ASoC: mediatek: mt8189: Remove redundant error message
      ASoC: mediatek: mt8189: Propagate APLL errors
      ASoC: mediatek: mt8189: Propagate MCLK errors
      ASoC: mediatek: mt8189: Validate sysclk frequency
      ASoC: mediatek: mt8189: Propagate TDM clock errors
      ASoC: mediatek: mt8189: Validate TDM MCLK frequency
      ASoC: mediatek: mt8188: mt8188-afe-clk: Propagate clock initialization errors
      ASoC: mediatek: mt8188: mt8188-afe-clk: Handle tuner clock enable errors
      ASoC: mediatek: mt8188: mt8188-afe-clk: Propagate regmap update errors
      ASoC: mediatek: mt8188: mt8188-afe-clk: Handle clock enable errors
      ASoC: mediatek: mt8188: mt8188-afe-pcm: Handle runtime resume errors
      ASoC: mediatek: mt8188: mt8188-afe-pcm: Drop redundant probe error messages
      ASoC: mediatek: mt8188: fix clk leak on error in audsys_clk_register
      ASoC: fsl_asrc_m2m: fix pm_runtime usage counter leak on error
      ASoC: mediatek: mt8183: Fix wrong clock cleanup on clk_set_parent() failure
      ASoC: mediatek: mt8183: Fix clock handling in mux disable path
      ASoC: mediatek: mt8183: Fix APLL enable error handling
      ASoC: mediatek: mt8183: Use dev_err_probe() for error handling
      ASoC: mediatek: mt8183: Drop redundant probe error messages
      ASoC: mediatek: mt8192: fix APLL mux error handling
      ASoC: mediatek: mt8192: fix AFE clock error handling
      ASoC: mediatek: mt8192: fix error handling in APLL enable functions
      ASoC: mediatek: mt8192: fix MCK clock error handling
      ASoC: mediatek: mt8192: switch to devm_clk_get_optional()
      ASoC: mediatek: mt8192: Use dev_err_probe() in mt8192_init_clock()
      ASoC: mediatek: mt8192: Propagate errors in mt8192_afe_gpio_request()
      ASoC: mediatek: mt8192: Use dev_err_probe() for devm_pinctrl_get()
      ASoC: mediatek: mt8192: check return values in mt8192_afe_gpio_init()
      ASoC: mediatek: mt8192: Handle regcache_sync() failure in runtime resume
      ASoC: mediatek: mt8192: Remove redundant error message
      ASoC: mediatek: mt8192: Propagate mt8192_afe_gpio_request() errors in ADDA DAI
      ASoC: mediatek: mt8192: Propagate errors in TDM DAI DAPM event handlers
      ASoC: mediatek: mt8192: Propagate errors in I2S DAI DAPM event handlers
      ASoC: mediatek: mt8192-mt6359: Fix error handling in MTKAIF calibration

Ștefan Ghețu (3):
      ASoC: SOF: imx8: remove unused regmap field from imx8m_chip_data
      ASoC: SOF: imx8: check imx_sc_pm_cpu_start() return value
      ASoC: SOF: imx: Prevent stack OOB read in DSP panic dump

 .../devicetree/bindings/sound/adi,adau1372.yaml    |   10 +-
 .../devicetree/bindings/sound/adi,adau7118.yaml    |   22 +-
 .../bindings/sound/airoha,an7581-afe.yaml          |   41 +
 .../bindings/sound/airoha,an7581-wm8960.yaml       |   71 +
 .../bindings/sound/amlogic,gx-sound-card.yaml      |   20 +-
 .../bindings/sound/asahi-kasei,ak4619.yaml         |   16 +-
 .../bindings/sound/audio-graph-port.yaml           |   10 +-
 .../devicetree/bindings/sound/cirrus,cs35l45.yaml  |   60 +-
 .../devicetree/bindings/sound/cirrus,cs4270.yaml   |   12 +-
 .../devicetree/bindings/sound/cirrus,cs42l42.yaml  |   48 +-
 .../devicetree/bindings/sound/cirrus,cs42l84.yaml  |   20 +-
 .../devicetree/bindings/sound/cirrus,cs42xx8.yaml  |   60 +-
 .../bindings/sound/davinci-evm-audio.txt           |   49 -
 .../devicetree/bindings/sound/dialog,da7219.yaml   |   80 +-
 .../bindings/sound/esstech,es9039q2m.yaml          |   94 +
 .../devicetree/bindings/sound/everest,es8316.yaml  |    5 +
 .../bindings/sound/foursemi,fs2105s.yaml           |    2 +-
 .../devicetree/bindings/sound/fsl,easrc.yaml       |   45 +
 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |   45 +-
 .../devicetree/bindings/sound/fsl,sai.yaml         |   14 +-
 .../bindings/sound/hisilicon,hi6210-i2s.yaml       |    4 +
 .../devicetree/bindings/sound/imx-audio-card.yaml  |    4 +-
 .../devicetree/bindings/sound/imx-audmux.yaml      |    8 +-
 .../bindings/sound/invensense,ics43432.yaml        |    8 +-
 .../bindings/sound/loongson,ls-audio-card.yaml     |    4 +-
 .../bindings/sound/mediatek,mt2701-audio.yaml      |   10 +-
 .../bindings/sound/mediatek,mt8173-afe-pcm.yaml    |   22 +-
 .../bindings/sound/mediatek,mt8183-audio.yaml      |   82 +-
 .../sound/mt8186-mt6366-da7219-max98357.yaml       |   36 +-
 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml        |   36 +-
 .../sound/mt8192-mt6359-rt1015-rt5682.yaml         |   46 +-
 .../devicetree/bindings/sound/mt8195-mt6359.yaml   |   50 +-
 .../devicetree/bindings/sound/nuvoton,nau8360.yaml |  115 +
 .../bindings/sound/qcom,q6apm-lpass-dais.yaml      |   12 +-
 .../bindings/sound/qcom,q6dsp-lpass-ports.yaml     |   16 +-
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |    1 +
 .../bindings/sound/qcom,wcd9378-sdw.yaml           |  105 +
 .../devicetree/bindings/sound/realtek,rt5677.yaml  |   10 +
 .../devicetree/bindings/sound/renesas,rsnd.yaml    |   16 +-
 .../devicetree/bindings/sound/renesas,rz-ssi.yaml  |   32 +-
 .../bindings/sound/stericsson,ux500-msp-i2s.yaml   |   96 +
 .../bindings/sound/ti,da830-evm-audio.yaml         |   83 +
 .../devicetree/bindings/sound/ti,tas2781.yaml      |    4 +-
 .../devicetree/bindings/sound/ti,tas5805m.yaml     |   10 +-
 .../bindings/sound/ti,tlv320dac3100.yaml           |    2 +-
 .../devicetree/bindings/sound/ti,tpa6130a2.yaml    |    2 +-
 .../devicetree/bindings/sound/ux500-mop500.txt     |   39 -
 .../devicetree/bindings/sound/ux500-msp.txt        |   42 -
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |   18 +
 drivers/base/regmap/internal.h                     |    1 +
 drivers/base/regmap/regmap-irq.c                   |    2 +-
 drivers/base/regmap/regmap-kunit.c                 |   98 +-
 drivers/base/regmap/regmap-ram.c                   |   26 +-
 drivers/base/regmap/regmap-raw-ram.c               |   21 +-
 drivers/base/regmap/regmap.c                       |    2 +-
 drivers/firmware/cirrus/cs_dsp.c                   |    2 +-
 drivers/gpib/fmh_gpib/fmh_gpib.c                   |   10 +-
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h |   52 +
 include/linux/dmaengine.h                          |    9 -
 include/linux/firmware/cirrus/cs_dsp.h             |    2 +-
 include/sound/sdca.h                               |   23 +-
 include/sound/sdca_class.h                         |   70 +
 include/sound/simple_card_utils.h                  |    2 +
 include/sound/soc-component.h                      |   14 +-
 include/sound/soc-dai.h                            |  189 +-
 include/sound/soc.h                                |   16 +-
 include/sound/soc_sdw_utils.h                      |   20 +
 include/sound/tas2781-dsp.h                        |   13 +
 include/sound/tas2781.h                            |   31 +
 sound/hda/core/intel-nhlt.c                        |    4 +-
 sound/soc/amd/acp-es8336.c                         |    5 +-
 sound/soc/amd/acp/Kconfig                          |    3 +-
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c      |   14 +-
 sound/soc/amd/acp/amd-acp70-acpi-match.c           |   20 +
 sound/soc/amd/acp/soc_amd_sdw_common.h             |   13 +
 sound/soc/amd/yc/acp6x-mach.c                      |    7 +
 sound/soc/atmel/atmel-pcm-dma.c                    |    2 +-
 sound/soc/bcm/cygnus-ssp.h                         |    2 +-
 sound/soc/codecs/88pm860x-codec.c                  |    6 +
 sound/soc/codecs/Kconfig                           |   53 +-
 sound/soc/codecs/Makefile                          |    8 +
 sound/soc/codecs/ab8500-codec.c                    |  157 +-
 sound/soc/codecs/adau1372.c                        |   12 +
 sound/soc/codecs/adau1373.c                        |   12 +
 sound/soc/codecs/adau1701.c                        |   15 +-
 sound/soc/codecs/adau17x1.c                        |   17 +-
 sound/soc/codecs/adau1977.c                        |   13 +
 sound/soc/codecs/adau7118.c                        |   12 +
 sound/soc/codecs/ak4104.c                          |    7 +
 sound/soc/codecs/ak4118.c                          |    7 +
 sound/soc/codecs/ak4458.c                          |    9 +
 sound/soc/codecs/ak4535.c                          |    6 +
 sound/soc/codecs/ak4619.c                          |   32 +
 sound/soc/codecs/ak4642.c                          |   14 +-
 sound/soc/codecs/ak4671.c                          |    7 +
 sound/soc/codecs/ak5386.c                          |    6 +
 sound/soc/codecs/ak5558.c                          |    7 +
 sound/soc/codecs/alc5623.c                         |   11 +
 sound/soc/codecs/alc5632.c                         |   13 +
 sound/soc/codecs/arizona-jack.c                    |    1 +
 sound/soc/codecs/arizona.c                         |   23 +
 sound/soc/codecs/cpcap.c                           |   89 +-
 sound/soc/codecs/cs35l33.c                         |    8 +-
 sound/soc/codecs/cs35l34.c                         |    2 +-
 sound/soc/codecs/cs35l35.c                         |    7 +
 sound/soc/codecs/cs35l36.c                         |   56 +
 sound/soc/codecs/cs35l41.c                         |   10 +
 sound/soc/codecs/cs35l45-tables.c                  |    4 +
 sound/soc/codecs/cs35l45.c                         |   97 +-
 sound/soc/codecs/cs35l45.h                         |   23 +
 sound/soc/codecs/cs35l56-shared-test.c             |   56 +
 sound/soc/codecs/cs35l56.c                         |   10 +
 sound/soc/codecs/cs40l50-codec.c                   |    9 +
 sound/soc/codecs/cs4234.c                          |    9 +
 sound/soc/codecs/cs4265.c                          |   12 +
 sound/soc/codecs/cs4270.c                          |    6 +
 sound/soc/codecs/cs4271.c                          |    6 +
 sound/soc/codecs/cs42l42.c                         |   11 +-
 sound/soc/codecs/cs42l43.c                         |   12 +
 sound/soc/codecs/cs42l51.c                         |    7 +
 sound/soc/codecs/cs42l52.c                         |   22 +-
 sound/soc/codecs/cs42l56.c                         |   17 +-
 sound/soc/codecs/cs42l73.c                         |   11 +-
 sound/soc/codecs/cs42l84.c                         |    6 +
 sound/soc/codecs/cs42xx8.c                         |    8 +
 sound/soc/codecs/cs43130.c                         |   14 +
 sound/soc/codecs/cs4341.c                          |    8 +
 sound/soc/codecs/cs4349.c                          |   12 +
 sound/soc/codecs/cs48l32.c                         |   23 +
 sound/soc/codecs/cs530x.c                          |    9 +
 sound/soc/codecs/cs53l30.c                         |    8 +
 sound/soc/codecs/cx20442.c                         |    2 +-
 sound/soc/codecs/cx2072x.c                         |   12 +
 sound/soc/codecs/da7210.c                          |    9 +-
 sound/soc/codecs/da7218.c                          |  141 +-
 sound/soc/codecs/da7219.c                          |   12 +
 sound/soc/codecs/da732x.c                          |   17 +
 sound/soc/codecs/da9055.c                          |    8 +
 sound/soc/codecs/es7134.c                          |    6 +
 sound/soc/codecs/es7241.c                          |    7 +
 sound/soc/codecs/es8311.c                          |   27 +-
 sound/soc/codecs/es8316.c                          |   27 +-
 sound/soc/codecs/es8323.c                          |   32 +-
 sound/soc/codecs/es8326.c                          |  177 +-
 sound/soc/codecs/es8326.h                          |    4 +
 sound/soc/codecs/es8328.c                          |   20 +-
 sound/soc/codecs/es8375.c                          |   30 +-
 sound/soc/codecs/es8389.c                          |   65 +-
 sound/soc/codecs/es9039q2m.c                       | 2008 +++++++++++++++++
 sound/soc/codecs/fs210x.c                          |    5 +-
 sound/soc/codecs/hda.c                             |    7 +-
 sound/soc/codecs/hdac_hda.c                        |    2 +-
 sound/soc/codecs/hdac_hdmi.c                       |    2 +-
 sound/soc/codecs/inno_rk3036.c                     |   12 +
 sound/soc/codecs/isabelle.c                        |   13 +
 sound/soc/codecs/lm49453.c                         |   15 +
 sound/soc/codecs/lpass-rx-macro.c                  |    6 +-
 sound/soc/codecs/lpass-tx-macro.c                  |    4 +-
 sound/soc/codecs/lpass-va-macro.c                  |    4 +-
 sound/soc/codecs/lpass-wsa-macro.c                 |   48 +-
 sound/soc/codecs/max98088.c                        |   12 +
 sound/soc/codecs/max98090.c                        |   35 +-
 sound/soc/codecs/max98095.c                        |   24 +-
 sound/soc/codecs/max98363.c                        |    2 +-
 sound/soc/codecs/max98371.c                        |    7 +
 sound/soc/codecs/max98373-i2c.c                    |   10 +
 sound/soc/codecs/max98388.c                        |   10 +
 sound/soc/codecs/max98390.c                        |   10 +
 sound/soc/codecs/max98396.c                        |   12 +
 sound/soc/codecs/max9850.c                         |   11 +
 sound/soc/codecs/max98520.c                        |   10 +
 sound/soc/codecs/max9860.c                         |   23 +
 sound/soc/codecs/max9867.c                         |   10 +
 sound/soc/codecs/max98925.c                        |    8 +
 sound/soc/codecs/max98926.c                        |    8 +
 sound/soc/codecs/max98927.c                        |   14 +-
 sound/soc/codecs/mc13783.c                         |   12 +
 sound/soc/codecs/ml26124.c                         |    6 +
 sound/soc/codecs/mt6359.c                          |    8 +-
 sound/soc/codecs/nau8325.c                         |   11 +
 sound/soc/codecs/nau8360-dsp.c                     |  634 ++++++
 sound/soc/codecs/nau8360-dsp.h                     |  122 ++
 sound/soc/codecs/nau8360.c                         | 2309 ++++++++++++++++++++
 sound/soc/codecs/nau8360.h                         |  917 ++++++++
 sound/soc/codecs/nau8540.c                         |   15 +-
 sound/soc/codecs/nau8810.c                         |   12 +
 sound/soc/codecs/nau8821.c                         |   11 +
 sound/soc/codecs/nau8822.c                         |   27 +-
 sound/soc/codecs/nau8824.c                         |   11 +
 sound/soc/codecs/nau8825.c                         |   29 +-
 sound/soc/codecs/ntp8835.c                         |    7 +
 sound/soc/codecs/ntp8918.c                         |    7 +
 sound/soc/codecs/pcm5102a.c                        |   30 +-
 sound/soc/codecs/pcm6240.c                         |    8 +-
 sound/soc/codecs/rk3308_codec.c                    |   11 +
 sound/soc/codecs/rk3328_codec.c                    |    9 +
 sound/soc/codecs/rt1011.c                          |   44 +-
 sound/soc/codecs/rt1015.c                          |   91 +-
 sound/soc/codecs/rt1016.c                          |   14 +-
 sound/soc/codecs/rt1017-sdca-sdw.c                 |   27 +-
 sound/soc/codecs/rt1019.c                          |   10 +
 sound/soc/codecs/rt1305.c                          |   14 +-
 sound/soc/codecs/rt1308.c                          |   14 +-
 sound/soc/codecs/rt1318.c                          |   13 +-
 sound/soc/codecs/rt1320-sdw.c                      |   12 +-
 sound/soc/codecs/rt274.c                           |   12 +-
 sound/soc/codecs/rt286.c                           |   10 +-
 sound/soc/codecs/rt298.c                           |    8 +
 sound/soc/codecs/rt5514-spi.c                      |   37 +-
 sound/soc/codecs/rt5514.c                          |   39 +-
 sound/soc/codecs/rt5616.c                          |   23 +-
 sound/soc/codecs/rt5631.c                          |   10 +
 sound/soc/codecs/rt5631.h                          |    8 +-
 sound/soc/codecs/rt5640.c                          |   22 +-
 sound/soc/codecs/rt5645.c                          |   23 +-
 sound/soc/codecs/rt5651.c                          |   12 +-
 sound/soc/codecs/rt5659.c                          |   14 +-
 sound/soc/codecs/rt5660.c                          |   14 +-
 sound/soc/codecs/rt5663.c                          |   10 +
 sound/soc/codecs/rt5665.c                          |   14 +-
 sound/soc/codecs/rt5668.c                          |   22 +
 sound/soc/codecs/rt5670.c                          |   12 +-
 sound/soc/codecs/rt5677-spi.c                      |   21 +-
 sound/soc/codecs/rt5677.c                          |   10 +
 sound/soc/codecs/rt5682.c                          |   22 +
 sound/soc/codecs/rt5682s.c                         |   34 +-
 sound/soc/codecs/rt712-sdca-dmic.c                 |    4 +-
 sound/soc/codecs/rt712-sdca-sdw.c                  |    1 +
 sound/soc/codecs/rt712-sdca-sdw.h                  |    3 +
 sound/soc/codecs/rt712-sdca.c                      |  141 +-
 sound/soc/codecs/rt712-sdca.h                      |    6 +
 sound/soc/codecs/rt721-sdca-sdw.c                  |   15 +
 sound/soc/codecs/rt721-sdca.c                      |  500 +++--
 sound/soc/codecs/rt721-sdca.h                      |   17 +
 sound/soc/codecs/rt766-sdca.c                      |    2 +-
 sound/soc/codecs/rt9120.c                          |    9 +
 sound/soc/codecs/rt9123.c                          |   13 +
 sound/soc/codecs/rtq9124.c                         |    9 +
 sound/soc/codecs/rtq9128.c                         |    9 +
 sound/soc/codecs/sgtl5000.c                        |   11 +
 sound/soc/codecs/si476x.c                          |   18 +
 sound/soc/codecs/sma1303.c                         |   13 +
 sound/soc/codecs/sma1307.c                         |   27 +-
 sound/soc/codecs/sn624x-sdca-sdw.c                 | 1888 ++++++++++++++++
 sound/soc/codecs/sn624x-sdca.h                     |  152 ++
 sound/soc/codecs/src4xxx.c                         |    8 +
 sound/soc/codecs/ssm2518.c                         |   13 +
 sound/soc/codecs/ssm2602.c                         |   13 +
 sound/soc/codecs/ssm3515.c                         |   10 +
 sound/soc/codecs/ssm4567.c                         |   13 +
 sound/soc/codecs/sta32x.c                          |  116 +-
 sound/soc/codecs/sta350.c                          |   15 +-
 sound/soc/codecs/sta529.c                          |    7 +
 sound/soc/codecs/tas2552.c                         |   14 +
 sound/soc/codecs/tas2562.c                         |   10 +
 sound/soc/codecs/tas2764.c                         |   14 +-
 sound/soc/codecs/tas2770.c                         |   14 +-
 sound/soc/codecs/tas2780.c                         |   10 +
 sound/soc/codecs/tas2781-comlib-i2c.c              |    4 +-
 sound/soc/codecs/tas2781-comlib.c                  |   10 +-
 sound/soc/codecs/tas2781-fmwlib.c                  |   40 +-
 sound/soc/codecs/tas2781-i2c.c                     |  320 ++-
 sound/soc/codecs/tas2783-sdw.c                     |  218 +-
 sound/soc/codecs/tas2783.h                         |    4 +-
 sound/soc/codecs/tas5086.c                         |    7 +
 sound/soc/codecs/tas571x.c                         |    7 +
 sound/soc/codecs/tas5720.c                         |    9 +
 sound/soc/codecs/tas6424.c                         |    9 +
 sound/soc/codecs/tfa9879.c                         |    9 +
 sound/soc/codecs/tlv320adc3xxx.c                   |   14 +
 sound/soc/codecs/tlv320adcx140.c                   |   12 +
 sound/soc/codecs/tlv320aic23.c                     |    9 +
 sound/soc/codecs/tlv320aic26.c                     |    8 +
 sound/soc/codecs/tlv320aic31xx.c                   |   41 +-
 sound/soc/codecs/tlv320aic32x4-clk.c               |    2 +-
 sound/soc/codecs/tlv320aic32x4.c                   |  102 +-
 sound/soc/codecs/tlv320aic3x.c                     |   42 +-
 sound/soc/codecs/tlv320dac33.c                     |   10 +-
 sound/soc/codecs/tscs454.c                         |   15 +
 sound/soc/codecs/twl4030.c                         |   80 +-
 sound/soc/codecs/uda1334.c                         |    6 +
 sound/soc/codecs/uda1342.c                         |    7 +
 sound/soc/codecs/uda1380.c                         |   11 +
 sound/soc/codecs/wcd-mbhc-v2.c                     |    8 +-
 sound/soc/codecs/wcd9335.c                         |   25 +-
 sound/soc/codecs/wcd934x.c                         |    2 +-
 sound/soc/codecs/wcd9378-sdca.c                    | 1080 +++++++++
 sound/soc/codecs/wcd9378-sdca.h                    |   20 +
 sound/soc/codecs/wcd9378-sdw.c                     |   51 +
 sound/soc/codecs/wm2200.c                          |   10 +
 sound/soc/codecs/wm5100.c                          |   10 +
 sound/soc/codecs/wm8350.c                          |   24 +
 sound/soc/codecs/wm8400.c                          |    9 +
 sound/soc/codecs/wm8510.c                          |   12 +
 sound/soc/codecs/wm8523.c                          |   13 +
 sound/soc/codecs/wm8524.c                          |    6 +
 sound/soc/codecs/wm8580.c                          |   20 +
 sound/soc/codecs/wm8711.c                          |   13 +
 sound/soc/codecs/wm8728.c                          |    9 +
 sound/soc/codecs/wm8731.c                          |   13 +
 sound/soc/codecs/wm8737.c                          |   11 +
 sound/soc/codecs/wm8741.c                          |   13 +
 sound/soc/codecs/wm8750.c                          |   13 +
 sound/soc/codecs/wm8753.c                          |   20 +
 sound/soc/codecs/wm8770.c                          |   11 +
 sound/soc/codecs/wm8776.c                          |   13 +
 sound/soc/codecs/wm8804.c                          |   15 +-
 sound/soc/codecs/wm8900.c                          |   18 +
 sound/soc/codecs/wm8903.c                          |   18 +
 sound/soc/codecs/wm8904.c                          |   20 +-
 sound/soc/codecs/wm8940.c                          |   13 +
 sound/soc/codecs/wm8955.c                          |   42 +-
 sound/soc/codecs/wm8958-dsp2.c                     |    8 +-
 sound/soc/codecs/wm8960.c                          |   13 +
 sound/soc/codecs/wm8961.c                          |   18 +
 sound/soc/codecs/wm8962.c                          |   74 +-
 sound/soc/codecs/wm8971.c                          |   13 +
 sound/soc/codecs/wm8974.c                          |   17 +
 sound/soc/codecs/wm8978.c                          |   12 +
 sound/soc/codecs/wm8983.c                          |   12 +
 sound/soc/codecs/wm8985.c                          |   53 +-
 sound/soc/codecs/wm8988.c                          |   13 +
 sound/soc/codecs/wm8990.c                          |    9 +
 sound/soc/codecs/wm8991.c                          |    9 +
 sound/soc/codecs/wm8993.c                          |   18 +
 sound/soc/codecs/wm8994.c                          |   23 +
 sound/soc/codecs/wm8995.c                          |   61 +-
 sound/soc/codecs/wm8996.c                          |   14 +-
 sound/soc/codecs/wm9081.c                          |   18 +
 sound/soc/codecs/wm9713.c                          |   13 +
 sound/soc/codecs/wm_hubs.c                         |    2 +-
 sound/soc/codecs/zl38060.c                         |    6 +
 sound/soc/dwc/dwc-i2s.c                            |    9 +
 sound/soc/fsl/Kconfig                              |    2 +-
 sound/soc/fsl/fsl_asrc.c                           |  110 +-
 sound/soc/fsl/fsl_asrc_common.h                    |    7 +-
 sound/soc/fsl/fsl_asrc_dma.c                       |   38 +-
 sound/soc/fsl/fsl_asrc_m2m.c                       |   17 +-
 sound/soc/fsl/fsl_easrc.c                          |  125 +-
 sound/soc/fsl/fsl_mqs.c                            |   14 +
 sound/soc/fsl/fsl_xcvr.c                           |   26 +-
 sound/soc/generic/audio-graph-card.c               |    1 +
 sound/soc/generic/audio-graph-card2.c              |    4 +-
 sound/soc/generic/simple-card-utils.c              |   23 +-
 sound/soc/generic/simple-card.c                    |   13 +-
 sound/soc/hisilicon/hi6210-i2s.c                   |    7 +
 sound/soc/img/img-i2s-in.c                         |   12 +-
 sound/soc/img/img-i2s-out.c                        |   13 +-
 sound/soc/img/img-parallel-out.c                   |    8 +-
 sound/soc/intel/atom/sst-mfld-dsp.h                |    2 +-
 sound/soc/intel/atom/sst/sst.h                     |    2 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |   14 +-
 sound/soc/intel/avs/boards/hdaudio.c               |    8 +-
 sound/soc/intel/avs/pcm.c                          |   11 +-
 sound/soc/intel/avs/topology.c                     |   25 -
 sound/soc/intel/avs/topology.h                     |    3 -
 sound/soc/intel/boards/Kconfig                     |    1 +
 sound/soc/intel/boards/sof_cirrus_common.c         |    2 +-
 sound/soc/intel/common/soc-acpi-intel-arl-match.c  |   71 +
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c  |   71 +
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c  |   71 +
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  |   85 +
 sound/soc/intel/common/sof-function-topology-lib.c |  281 ++-
 sound/soc/intel/common/sof-function-topology-lib.h |    3 +
 sound/soc/jz4740/jz4740-i2s.c                      |    7 +
 sound/soc/kirkwood/kirkwood-i2s.c                  |    7 +
 sound/soc/loongson/loongson_i2s.c                  |    6 +
 sound/soc/mediatek/Kconfig                         |   27 +-
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/an7581/Makefile                 |    9 +
 sound/soc/mediatek/an7581/an7581-afe-common.h      |   49 +
 sound/soc/mediatek/an7581/an7581-afe-pcm.c         |  515 +++++
 sound/soc/mediatek/an7581/an7581-dai-etdm.c        |  433 ++++
 sound/soc/mediatek/an7581/an7581-reg.h             |  114 +
 sound/soc/mediatek/an7581/an7581-wm8960.c          |  161 ++
 sound/soc/mediatek/common/mtk-afe-fe-dai.c         |   14 +-
 sound/soc/mediatek/common/mtk-base-afe.h           |    2 +
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |   61 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |    4 +-
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |    4 +-
 sound/soc/mediatek/mt2701/mt2701-wm8960.c          |    4 +-
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c         |   23 +-
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         |    8 +-
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c         |    8 +-
 sound/soc/mediatek/mt7986/mt7986-dai-etdm.c        |    2 +-
 sound/soc/mediatek/mt7986/mt7986-wm8960.c          |    4 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |   26 +-
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c         |   31 +-
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         |   21 +-
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c         |   95 +-
 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c        |    6 +-
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c         |   23 +-
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c         |  115 +-
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c         |   36 +-
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c      |   12 +-
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c        |    5 +-
 sound/soc/mediatek/mt8188/mt8188-dai-dmic.c        |   10 +-
 sound/soc/mediatek/mt8189/mt8189-afe-clk.c         |  134 +-
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c         |   61 +-
 sound/soc/mediatek/mt8189/mt8189-dai-i2s.c         |   18 +-
 sound/soc/mediatek/mt8189/mt8189-dai-tdm.c         |   19 +-
 sound/soc/mediatek/mt8192/mt8192-afe-clk.c         |  163 +-
 sound/soc/mediatek/mt8192/mt8192-afe-gpio.c        |   94 +-
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c         |   23 +-
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c        |   44 +-
 sound/soc/mediatek/mt8192/mt8192-dai-i2s.c         |   20 +-
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c         |   18 +-
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  |   37 +-
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c         |    2 +-
 sound/soc/mediatek/mt8196/mt8196-afe-pcm.c         |   14 +-
 sound/soc/mxs/mxs-saif.c                           |   10 +
 sound/soc/pxa/mmp-sspa.c                           |    6 +
 sound/soc/pxa/pxa-ssp.c                            |   11 +
 sound/soc/pxa/pxa2xx-i2s.c                         |    6 +
 sound/soc/pxa/pxa2xx-pcm-lib.c                     |    9 +-
 sound/soc/qcom/common.c                            |   61 +-
 sound/soc/qcom/common.h                            |    5 +-
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c            |    2 +
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |    2 +-
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c           |   54 +
 sound/soc/qcom/sc8280xp.c                          |  132 +-
 sound/soc/qcom/sdm845.c                            |   49 +-
 sound/soc/renesas/rz-ssi.c                         |    9 +
 sound/soc/renesas/siu_dai.c                        |    6 +
 sound/soc/renesas/ssi.c                            |   13 +
 sound/soc/rockchip/rk3399_gru_sound.c              |    4 +-
 sound/soc/rockchip/rockchip_i2s.c                  |   25 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c              |   27 +-
 sound/soc/rockchip/rockchip_pdm.c                  |   14 +-
 sound/soc/rockchip/rockchip_sai.c                  |   31 +-
 sound/soc/samsung/aries_wm8994.c                   |   14 +-
 sound/soc/samsung/pcm.c                            |   19 +-
 sound/soc/samsung/spdif.c                          |    8 +-
 sound/soc/samsung/tm2_wm5110.c                     |   12 +-
 sound/soc/sdca/Kconfig                             |    6 +-
 sound/soc/sdca/sdca_asoc.c                         |    4 +-
 sound/soc/sdca/sdca_class.c                        |  148 +-
 sound/soc/sdca/sdca_class.h                        |   35 -
 sound/soc/sdca/sdca_class_function.c               |   50 +-
 sound/soc/sdca/sdca_device.c                       |    4 +
 sound/soc/sdca/sdca_fdl.c                          |   18 +-
 sound/soc/sdca/sdca_functions.c                    |   15 +-
 sound/soc/sdw_utils/Makefile                       |    4 +-
 sound/soc/sdw_utils/soc_sdw_rt711.c                |    1 +
 sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c           |    6 +
 sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c  |    8 +
 sound/soc/sdw_utils/soc_sdw_senary_amp.c           |   80 +
 sound/soc/sdw_utils/soc_sdw_senary_dmic.c          |   49 +
 sound/soc/sdw_utils/soc_sdw_senary_sdca.c          |   63 +
 .../sdw_utils/soc_sdw_senary_sdca_jack_common.c    |  197 ++
 sound/soc/sdw_utils/soc_sdw_utils.c                |  384 ++++
 sound/soc/soc-component.c                          |    8 +-
 sound/soc/soc-compress.c                           |    5 +-
 sound/soc/soc-core.c                               |  175 +-
 sound/soc/soc-dai.c                                |  418 +++-
 sound/soc/soc-dapm.c                               |    9 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   10 +-
 sound/soc/soc-internal.h                           |   39 +
 sound/soc/soc-ops.c                                |    4 +-
 sound/soc/soc-pcm.c                                |  144 +-
 sound/soc/sof/amd/Kconfig                          |    1 +
 sound/soc/sof/amd/acp-common.c                     |   17 +
 sound/soc/sof/amd/acp-dsp-offset.h                 |   17 +
 sound/soc/sof/amd/acp.c                            |  389 +++-
 sound/soc/sof/amd/acp.h                            |   16 +
 sound/soc/sof/amd/acp7x.h                          |   37 +
 sound/soc/sof/amd/pci-acp7x.c                      |    2 +
 sound/soc/sof/imx/imx-common.c                     |    1 +
 sound/soc/sof/imx/imx8.c                           |   26 +-
 sound/soc/sof/intel/apl.c                          |    1 +
 sound/soc/sof/intel/cnl.c                          |    1 +
 sound/soc/sof/intel/hda-dai.c                      |   26 +-
 sound/soc/sof/intel/icl.c                          |    1 +
 sound/soc/sof/intel/mtl.c                          |    1 +
 sound/soc/sof/intel/skl.c                          |    1 +
 sound/soc/sof/intel/tgl.c                          |    1 +
 sound/soc/sof/ipc4-priv.h                          |   10 +-
 sound/soc/sof/ipc4-topology.c                      |   63 +-
 sound/soc/sof/mediatek/mt8186/mt8186.c             |    2 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c             |    2 +-
 sound/soc/sof/topology.c                           |    3 +-
 sound/soc/sprd/sprd-pcm-compress.c                 |    7 +-
 sound/soc/sprd/sprd-pcm-dma.c                      |   10 +-
 sound/soc/sti/uniperif_player.c                    |   29 +-
 sound/soc/sti/uniperif_reader.c                    |   27 +-
 sound/soc/stm/stm32_i2s.c                          |   12 +
 sound/soc/stm/stm32_sai_sub.c                      |   15 +
 sound/soc/stm/stm32_spdifrx.c                      |    2 +-
 sound/soc/sunxi/sun4i-i2s.c                        |   13 +
 sound/soc/sunxi/sun8i-codec.c                      |   13 +
 sound/soc/tegra/tegra20_i2s.c                      |   10 +
 sound/soc/tegra/tegra210_adx.c                     |   12 +-
 sound/soc/tegra/tegra210_adx.h                     |    2 +-
 sound/soc/tegra/tegra210_i2s.c                     |   13 +
 sound/soc/tegra/tegra30_i2s.c                      |   10 +
 sound/soc/ti/davinci-i2s.c                         |   16 +-
 sound/soc/ti/davinci-mcasp.c                       |   17 +-
 sound/soc/ti/omap-mcbsp.c                          |   14 +-
 sound/soc/uniphier/aio-cpu.c                       |    9 +
 sound/soc/uniphier/aio-dma.c                       |    5 +-
 sound/soc/uniphier/aio.h                           |    2 +-
 sound/soc/ux500/Kconfig                            |   23 +-
 sound/soc/ux500/Makefile                           |    3 -
 sound/soc/ux500/mop500.c                           |  167 --
 sound/soc/ux500/mop500_ab8500.c                    |  437 ----
 sound/soc/ux500/mop500_ab8500.h                    |   17 -
 sound/soc/ux500/ux500_msp_dai.c                    |   33 +-
 sound/soc/ux500/ux500_msp_i2s.c                    |    2 +-
 sound/soc/xilinx/xlnx_formatter_pcm.c              |   79 +-
 sound/soc/xtensa/xtfpga-i2s.c                      |   12 +-
 511 files changed, 21071 insertions(+), 3641 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/airoha,an7581-afe.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/airoha,an7581-wm8960.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/esstech,es9039q2m.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9378-sdw.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/stericsson,ux500-msp-i2s.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,da830-evm-audio.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ux500-mop500.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/ux500-msp.txt
 create mode 100644 include/sound/sdca_class.h
 create mode 100644 sound/soc/codecs/es9039q2m.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.h
 create mode 100644 sound/soc/codecs/nau8360.c
 create mode 100644 sound/soc/codecs/nau8360.h
 create mode 100644 sound/soc/codecs/sn624x-sdca-sdw.c
 create mode 100644 sound/soc/codecs/sn624x-sdca.h
 create mode 100644 sound/soc/codecs/wcd9378-sdca.c
 create mode 100644 sound/soc/codecs/wcd9378-sdca.h
 create mode 100644 sound/soc/codecs/wcd9378-sdw.c
 create mode 100644 sound/soc/mediatek/an7581/Makefile
 create mode 100644 sound/soc/mediatek/an7581/an7581-afe-common.h
 create mode 100644 sound/soc/mediatek/an7581/an7581-afe-pcm.c
 create mode 100644 sound/soc/mediatek/an7581/an7581-dai-etdm.c
 create mode 100644 sound/soc/mediatek/an7581/an7581-reg.h
 create mode 100644 sound/soc/mediatek/an7581/an7581-wm8960.c
 delete mode 100644 sound/soc/sdca/sdca_class.h
 create mode 100644 sound/soc/sdw_utils/soc_sdw_senary_amp.c
 create mode 100644 sound/soc/sdw_utils/soc_sdw_senary_dmic.c
 create mode 100644 sound/soc/sdw_utils/soc_sdw_senary_sdca.c
 create mode 100644 sound/soc/sdw_utils/soc_sdw_senary_sdca_jack_common.c
 create mode 100644 sound/soc/soc-internal.h
 create mode 100644 sound/soc/sof/amd/acp7x.h
 delete mode 100644 sound/soc/ux500/mop500.c
 delete mode 100644 sound/soc/ux500/mop500_ab8500.c
 delete mode 100644 sound/soc/ux500/mop500_ab8500.h
