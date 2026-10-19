Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921E606A319
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=C5SF48N9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8/ZYNh4
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 216CE601DB;
	Wed, 21 Oct 2026 19:14:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 216CE601DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792602856;
	bh=+SKq63Guyldzs7t8VXQXs3IcbLjtcD1wEisPW80SzMk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=C5SF48N9LPF3cbTvmhVIxN/j56iyKwfEe7FitymDWl2nNTGNBBRauepO9c2MSorqJ
	 /iy8mEXZGW5lcbqJjTC4lub1R1VqGhhz/SJpXuj1XfmUY2oq5UTJukKCSSN2SuNliW
	 /yBKl7ATO8ofpQUaXICHdqktlichR0XPIbSrEb/A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33EC5F80605; Wed, 21 Oct 2026 19:13:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F1207F805FF;
	Wed, 21 Oct 2026 19:13:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 19F4FF805F2; Wed, 21 Oct 2026 19:13:43 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PP_MIME_FAKE_ASCII_TEXT,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 408CFF80020
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 19:13:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 408CFF80020
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=k8/ZYNh4
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E620414C9;
	Mon, 19 Oct 2026 17:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16531F000C4;
	Mon, 19 Oct 2026 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430118;
	bh=nNfD5F6oUUnqrcmfRY3QUMt0PUqC20Z858HJ+LbkJYU=;
	h=From:To:Cc:Subject:Date;
	b=k8/ZYNh4U3ZV4sYV3fM1Yt51PvJbgQ8wtIonsXdT2/EEBkEDk11PyERS3/z/q9FW3
	 ZDUqzniQdEPaHUXqebmd5Bs6StWYuurvpcOrrggjpTQawtxkAJ4I4rwBvHPL6adZnf
	 AId6IbKwsU/U72i5+/zSE8qHg6ROAOdG8VwB7KYaq7wxzlLiMe6ggqvow6qvoZa7z8
	 IDK6CtcN6078OPy/lEcjORRbbaQih/GLq6at4WQwHHaQHVJG62TcByeali7rgU/2Gu
	 xVv9o/atPQ/wX8yhEDbuoZTRj1PVVOFsjpGnLD9qF8G0kVc6z+0Bla5E1Cf5wyis/C
	 +QrvVuJhjk3jA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 805171AC57D0; Mon, 19 Oct 2026 18:15:15 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v7.4
Date: Mon, 19 Oct 2026 18:14:57 +0100
Message-Id: <20261019171515.805171AC57D0@finisterre.sirena.org.uk>
Message-ID-Hash: JGOG2JCV73NEPC7YZKYDCZM4AYS67RDG
X-Message-ID-Hash: JGOG2JCV73NEPC7YZKYDCZM4AYS67RDG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JGOG2JCV73NEPC7YZKYDCZM4AYS67RDG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

The following changes since commit 2a31b5378c6db9c4a8d399e5d10d32cd4b732bef:

  ASoC: amd: yc: disable MSI on resume (2026-10-13 14:32:22 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v7.4

for you to fetch changes up to 73be2ee656f2722d498504259b9f1fdef8419431:

  ASoC: codecs: Fix more control definitions that write another control's bits (2026-10-18 13:22:10 +0100)

----------------------------------------------------------------
ASoC: Updates for v7.4

There's an awful lot of cleanup work in this pull request, lots from Bui
Duc Phuc, Pengpeng Hou, HyeongJun An and Chancel Liu cleaning up detail
issues in drivers in addition to Mormoto-san's ongoing framework work.
This time Morimoto-san's work included enabling auto_selectable_formats
so there's less manual configuration required for DAI links.

There's also been a huge amount of upstreaming activity from Qualcomm,
some pain there but hopefully enough has now landed for things to be
smoother in future.

 - Use auto_selectable_formats in most drivers to reduce the amount of
   manual configuration required for DAI links.
 - Support for compressed audio on SOF IPC4 systems.
 - Support for AMD ACP 7.B and 7.F, AmLogic A9 and T7, Airoha AN7581,
   ESS Technology ES9039Q2M, Intel Cherry Trail with RT5688, Nuvoton
   NAU83G60, nVidia systems with WM8994, Qualcomm QAIF, Senary I2S, WCD9378
   and various platforms, Realtek RT766 and RT767, Senary SN624x

I also mistakenly merged some SPI changes in here then applied more
patches on top before I noticed (it looks like this was b4's base
selection logic picking a bad base for some ASoC work), highlights there
are:

 - Improvements for spidev_test to cover additional use cases, plus be a
   bit easier to use.
 - Push more Tegra210 QSPI handling into interrupt context for
   performance improvements.
 - Support for Qualcomm QPIC SNAND v2 and RealTek RTD1625 NOR.
 - Documentation clarifications.
 - Fixes for some runtime PM and error handling issues.
 - Support for R-Car Gen5.

(this should also be going in via my SPI pull request)

----------------------------------------------------------------
Ajay Kumar Nandam (4):
      ASoC: qcom: q6apm: clear g_apm on driver removal
      ASoC: qcom: qdsp6: generalize GPR service domain
      ASoC: dt-bindings: qcom,q6apm-dai: add memory-region and relax iommus
      ASoC: qcom: q6apm-dai: add SCM buffer assignment for mDSP platforms

Alexander Koch (2):
      ASoC: codecs: ak4619: Add optional powerdown GPIO
      ASoC: dt-bindings: asahi-kasei,ak4619: Add powerdown GPIO

Amadeusz Sławiński (8):
      ASoC: soc-link: Correct stream stop operations in snd_soc_link_trigger
      ASoC: ops: Fix return value in snd_soc_limit_volume()
      ASoC: soc-topology-test: Check return value of kunit_device_register()
      ASoC: soc-card-test: Check return value of kunit_device_register()
      ASoC: soc-ac97: Fix error handling in snd_soc_new_ac97_component()
      ASoC: soc-ac97: Fix debug message
      ASoC: soc-component: Fix return type of snd_soc_pcm_component_pointer()
      ASoC: soc-dapm: Remove widget from cache on removal

Andrew Gaylard (1):
      spi: sunplus: handle signal interruption in transfer wait

Andrey Golovko (3):
      ASoC: tas2783-sdw: make multi-byte MBQ registers reachable
      ASoC: tas2783-sdw: do not cache read-only Controls
      ASoC: tas2783-sdw: stop describing the Latency and XU ID/Version Controls

Andy Shevchenko (11):
      spi: Fix tab and space mixture in Kconfig
      spi: Drop redundant dependency on SPI_MASTER
      spi: Fix the section ordering in accordance with the comment
      ASoC: stm32: spdifrx: Drop mention of the deprecated and unused call
      ASoC: sprd: Replace dma_request_slave_channel() by dma_request_chan()
      ASoC: soc-generic-dmaengine-pcm: Replace dma_request_slave_channel() by dma_request_chan()
      ASoC: pxa: Replace dma_request_slave_channel() by dma_request_chan()
      ASoC: fsl_asrc: Replace dma_request_slave_channel() by dma_request_chan()
      gpib: fmh_gpib: Replace dma_request_slave_channel() by dma_request_chan()
      dmaengine: Remove deprecated dma_request_slave_channel()
      ASoC: sprd: Shadow errors from dma_request_chan()

Arnd Bergmann (1):
      ASoC: amd: acp: add EFI dependency for selecting TAS2783

Art O Cathain (1):
      ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265

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

Cezary Rojewski (16):
      ASoC: Intel: avs: Use list_count_nodes() to simplify the code
      ASoC: codecs: hda: Use list_count_nodes() to simplify the code
      ASoC: Intel: avs: Remove topology-loading wrappers
      ASoC: codecs: rt5514: Fix the pm_ops constant name
      ASoC: codecs: rt286: Revert delay value for jack setup
      ASoC: codecs: rt274: Fix format setting for 44100 rate
      ASoC: core: Add component constructor
      ASoC: core: Rename and export soc_component_add()
      ASoC: dmaengine: Switch to snd_snd_component_new()
      ASoC: topology-test: Switch to snd_snd_component_new()
      ASoC: Intel: catpt: Switch to snd_snd_component_new()
      ASoC: Intel: avs: Switch to snd_snd_component_new()
      ASoC: core: Remove unused component-register members
      ASoC: Intel: avs: Unprepare a stream when recovery occurs
      ASoC: Intel: avs: Verify sizes of configs coming from topology
      ASoC: Intel: avs: Prevent module info underflow

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

Changhuang Liang (3):
      spi: dw: Convert the Tx done delay from SCK cycles to time
      spi: dw: Support DMA with a single channel
      spi: dw: Add DMA support for enhanced memory operations

Charles Keepax (2):
      ASoC: soc-ops: Clarify kernel doc for snd_soc_info_volsw_xs()
      ASoC: SDCA: Remove redundant comment

Christian Marangi (6):
      ASoC: dt-bindings: Add Airoha AN7581 AFE Sound card
      ASoC: airoha: Add AFE driver for Airoha AN7581
      ASoC: dt-bindings: Add Airoha AN7581 AFE with WM8960 Codec schema
      ASoC: airoha: Add machine driver for Airoha AN7581
      ASoC: mediatek: common: permit to provide dedicated regmap for irq
      ASoC: airoha: Fix sparse warning for AN7581 AFE PCM

Colin Ian King (1):
      ASoC: tas2781: Fix spelling mistake "config" -> "config"

Dan Carpenter (1):
      ASoC: codecs: aw88261: small cleanup in aw88261_set_tdm_slot()

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

Fan Wu (1):
      ASoC: amd: ps: fix snd_acp63_remove() teardown ordering

Federico Amedeo Izzo (1):
      ASoC: codecs: aw88261: expose hardware mute control

Felix Gu (5):
      spi: omap2-mcspi: Remove unbalanced pm_runtime_put_sync() calls
      spi: ingenic: release tx DMA channel when rx request fails
      spi: mtk-nor: fix runtime PM usage count leak in probe error path
      spi: ar934x: Convert to devm_spi_register_controller()
      spi: mxic: fix ps_clk leak in runtime resume

Francesco Valla (3):
      spi: virtio: drop duplicate completion init
      spi: virtio: fix max frequency setting
      spi: virtio: drop unused field from private data

Frank Li (3):
      spi: ingenic: remove dmaengine_desc_free()
      spi: use dmaengine public API instead of raw ops
      spi: use dmaengine_get_dma_device() instead of chan->device->dev

Frieder Schrempf (3):
      spi: dt-bindings: Clarify what rx-sample-delay-ns describes
      spi: Parse the rx-sample-delay-ns peripheral property in the core
      spi: dw: Use the rx-sample-delay-ns value parsed by the core

Gabor Juhos (7):
      spi: spi-qpic-snand: remove interim 'dev_data' variable from qcom_spi_probe()
      spi: spi-qpic-snand: remove unnecessary cast to '__le32 *'
      spi: spi-qpic-snand: add qcom_spi_config_page_read() helper
      spi: spi-qpic-snand: drop ecceng_to_qspi() macro
      spi: spi-qpic-snand: fix read location register usage in qcom_spi_config_cw_read()
      spi: spi-qpic-snand: remove 'ecc_buf_cfg' member of struct 'qpic_ecc'
      spi: spi-qpic-snand: set 'qpic_version2' flag

Geert Uytterhoeven (4):
      ASoC: codecs: lpass: Make sure clk_init_data is fully initialized
      ASoC: codecs: wcd934x: Make sure clk_init_data is fully initialized
      ASoC: tlv320aic32x4: Make sure clk_init_data is fully initialized
      spi: sh-msiof: Add support for R-Car Gen5

Guangshuo Li (1):
      ASoC: Intel: atom: Fix platform device leak on probe failure

Han Gao (2):
      spi: sg2044-nor: Return transfer errors
      spi: sg2044-nor: Honor SPI clock limits

Haotian Zhang (1):
      ASoC: rockchip: fix device node reference leak in rk3288_hdmi_analog

Harendra Gautam (10):
      ASoC: dt-bindings: qcom,shikra-qaif-cpu: Add binding
      ASoC: qcom: Add QAIF shared data structures and variant interface
      ASoC: qcom: Add QAIF hardware register map
      ASoC: qcom: Add QAIF CPU DAI ops, regmap, DT parsing and platform init
      ASoC: soc-core: Add snd_soc_of_xlate_dai_name() generic helper
      ASoC: qcom: Switch lpass-cpu and qaif-cpu to snd_soc_of_xlate_dai_name()
      ASoC: qcom: Add QAIF PCM operations
      ASoC: qcom: Add QAIF IRQ handling and platform register
      ASoC: qcom: Add Shikra QAIF support
      MAINTAINERS: Add Qualcomm QAIF driver entry

Hemanth Selam (5):
      regmap: fix typo "asynchrnous" in comment
      spi: fix typos in comments
      ASoC: codecs: fix typos in comments
      firmware: cirrus: fix typo "upto" in comment
      ASoC: fix typos in comments

Hongyan Xu (1):
      ASoC: mt6359-accdet: manage private workqueues with devres

Hongyang Zhao (5):
      ASoC: dt-bindings: es8316: Document jack detect inversion
      ASoC: dt-bindings: qcom,sm8250: Add RubikPi 3 sound card
      ASoC: qcom: common: Add generic headset jack helpers
      ASoC: qcom: sc8280xp: Add per-DAI board configuration
      ASoC: qcom: sc8280xp: Add RubikPi 3 sound card support

HyeongJun An (20):
      ASoC: codecs: wm8990: Fix definition of right input PGA controls
      ASoC: codecs: wm8990: Fix definition of LOMIX AINLMUX Bypass Volume control
      ASoC: codecs: wm8991: Fix definition of right input PGA controls
      ASoC: codecs: wm8991: Fix definition of LOMIX AINLMUX Bypass Volume control
      ASoC: codecs: wm8983: Fix definition of ADC 128x Oversampling control
      ASoC: codecs: wm8985: Fix definition of ADC 128x Oversampling control
      ASoC: codecs: wm8994: Fix definition of WM8958 noise gate hold time controls
      ASoC: codecs: wm8955: Fix definition of Treble Cutoff control
      ASoC: codecs: wm_hubs: Fix definition of MIXINR to MIXOUTR volume control
      ASoC: codecs: wm8737: Fix definition of zero cross switches
      ASoC: codecs: wm5100: Fix definition of EQ3 Band 1 Volume control
      ASoC: codecs: wm8750: Fix definition of ALC Capture NG Type control
      ASoC: codecs: wm8510: Fix definition of ADC Inversion Switch control
      ASoC: codecs: da732x: Fix definition of ADC2 EQ Overall Volume control
      ASoC: codecs: tlv320adc3xxx: Fix definition of AGC Target Level control
      ASoC: codecs: sta32x: Fix definition of Ch2 and Ch3 Volume Bypass controls
      ASoC: codecs: sta350: Fix definition of Ch2 and Ch3 Volume Bypass controls
      ASoC: codecs: sta32x: Fix definition of limiter threshold controls
      ASoC: codecs: sta350: Fix definition of limiter threshold controls
      ASoC: tlv320aic32x4: Fix definition of TAS2505 HP Driver Gain Volume control

Jack Yu (3):
      ASoC: rt1320: make SRAM registers readable to stop being cached
      ASoC: rt721-sdca: Adjust blindwrite flow to fix type detection issue
      ASoC: rt721-sdca: Fix inconsistent indenting in jack detect handler

James Calligeros (2):
      ASoC: tas2764: Initialise SDZ GPIO low
      ASoC: tas2770: Initialise SDZ GPIO low

Jesse Jeronimus (1):
      Documentation: devres: Remove non-existent SPI register helpers

Jiale Yao (6):
      ASoC: rt5682-sdw: always cancel jack work on remove
      ASoC: rt711-sdw: always cancel jack work on remove
      ASoC: rt711-sdca: always cancel jack work on remove
      ASoC: rt712-sdca: always cancel jack work on remove
      ASoC: rt721-sdca: always cancel jack work on remove
      ASoC: rt722-sdca: always cancel jack work on remove

Jiawen Liu (1):
      spi: rockchip-sfc: disable runtime PM in remove

Jisheng Zhang (1):
      spi: dw: use DW_SPI_ISR directly

Johan Alvarado (2):
      spi: spi-qpic-snand: publish the ECC context to snandc->qspi
      spi: spi-qpic-snand: drop the redundant ECC context handling

Jonas Jelonek (1):
      spi: realtek-rtl: add support for second CS

Jonas Rebmann (8):
      spi: spidev_test: include tools/include
      spi: spidev_test: clarify usage for --size
      spi: spidev_test: make size argument mandatory for --size
      spi: spidev_test: allow zero-length transfers
      spi: spidev_test: abort when -I is selected without -S
      spi: spidev_test: always compare loopback data
      spi: spidev_test: send predictable data
      spi: spidev_test: rewrite unescape() to stay in bounds

Joonhoe Kim (1):
      ASoC: codecs: wcd939x: read the SoundWire port switches per channel

Junjie Cao (1):
      ASoC: rt712-sdca-dmic: fix drvdata type in the gain controls

Jyan Chou (2):
      spi: dt-bindings: Add Realtek RTD1625 SPI NOR support
      spi: spi-mem: Add Realtek SPI NOR flash controller driver

Karl Asseily (4):
      dt-bindings: vendor-prefixes: add ESS Technology
      ASoC: dt-bindings: add ESS Technology ES9039Q2M
      ASoC: es9039q2m: add ESS Technology ES9039Q2M codec driver
      MAINTAINERS: add entry for the ES9039Q2M codec driver

Karl Mehltretter (3):
      spi: docs: Use the multi-lane mode constants in examples
      spi: Fix the return value in spi_new_ancillary_device() kernel-doc
      ASoC: codecs: es8375: use devm_clk_get_optional() for mclk

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

Kuninori Morimoto (96):
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
      ASoC: codecs: twl4030: tidyup twl4030_soc_probe()
      ASoC: codecs: cpcap: tidyup cpcap_soc_probe()
      ASoC: soc-component: tidyup be_hw_params_fixup() define position
      ASoC: soc-component: replace bool member to bit field
      ASoC: soc-component: move snd_soc_add_component_controls()
      ASoC: soc-component: move snd_soc_component_fixup_controls()
      ASoC: soc-component: move soc_component_to_node() to soc-component.c
      ASoC: soc-component: move snd_soc_is_matching_component() to soc-component.c
      ASoC: soc-component: move soc_{probe/remove}_component() to soc-component.c
      ASoC: soc-component: move snd_soc_component_to_dapm() to soc-component.c
      ASoC: soc-component: move snd_soc_component_cache_sync() to soc-component.c
      ASoC: soc-component: move snd_soc_component_active() to soc-component.c
      ASoC: soc-component: move component_list to soc-component.c
      ASoC: soc-component: move snd_soc_lookup_component() to soc-component.c
      ASoC: soc-component: rename snd_soc_component_async_complete()

Le Qi (1):
      ASoC: codecs: da7213: Get MCLK in I2C probe

Li Youhong (2):
      spi: ma35d1-qspi: assert reset on probe error paths
      spi: amlogic-spisg: check clk_prepare_enable() return value

Linus Walleij (4):
      ASoC: dt-bindings: sound: Prepare Ux500 audio graph links
      ASoC: dt-bindings: ux500: Remove MOP500 sound card binding
      ASoC: ab8500: Skip digital microphone support on AB8505
      ASoC: ux500: Remove the MOP500 machine driver

Lucas Costa (1):
      spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()

Ma Ke (1):
      ASoC: wcd9335: Fix device reference leak in wcd9335_slim_status()

Maciej Strozek (2):
      ASoC: SDCA: Improve scanning the SWFT during FDL
      ASoC: SDCA: Check return value on a missing FDL_Set_Index Range

Marc Kleine-Budde (5):
      spi: spidev_test: add compare mode
      spi: spidev_test: allow disabling rx or tx buffers
      spi: spidev_test: don't send 0x0 or 0xff
      spi: spidev_test: add option to split message into multiple transfers
      spi: spidev_test: print TX on error

Marco Giunta (2):
      ASoC: aw88399: skip BSTS check when boost converter is bypassed
      ASoC: aw88399: remove bsts_unreliable workaround

Mario Limonciello (1):
      ASoC: amd: acp63: add standalone ES9356 SoundWire machine

Mark Brown (87):
      Merge remote-tracking branch 'asoc/for-7.2' into asoc-linus
      ASoC: samsung: Improve probe error handling
      ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
      spi: Kconfig cleanups
      ASoC: Make sure clk_init_data is fully initialized
      regmap: Allow a base register to be specified for the RAM regmap
      regmap: Test rbtree and maple caches for very high register numbers
      ASoC: add Senary SN624x SoundWire SDCA support
      spi: qcom-geni: Add shutdown and panic notifier support
      spi: add support for Amlogic A9
      ASoC: Introduces MDSYNC support for CS35L45
      spi: ma35d1-qspi: Flag the DTR capability correctly
      ASoC: SDCA: SimpleJack support and small cleanup
      ASoC: mediatek: mt8186: Fix clock error handling
      ASoC: mediatek: mt6797: Fix error handling
      ASoC: codecs: lpass-macros: switch regcache to REGCACHE_MAPLE
      spi: tegra210-quad: Improve interrupt handling for loaded systems
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
      spi: virtio: fix max frequency setting plus minor cleanup
      spi: spi-qpic-snand: fix the stale ECC context pointer
      ASoC: add ESS Technology ES9039Q2M codec driver
      ASoC: Add support for Airoha AN7581
      ASoC et alia: Convert to use dma_request_chan()
      spi: Better specification for rx-sample-delay-ns and core parsing
      spi: sh-msiof: Add support for R-Car X5H
      ALSA/ASoC: Intel: add I2S function topology support
      Merge remote-tracking branch 'regmap/for-7.4' into regmap-next
      ASoC: codecs: Fix resource leaks across card bind/unbind
      ASoC: qcom: Add QAIF AIF MI2S and TDM DAI support
      spi: spidev_test: new features
      ASoC: codecs: propagate component resume cache sync failures
      ASoC: mediatek: mt8188: Improve error handling
      ASoC: mediatek: mt8183: Fix clock error handling
      ASoC: amd: Fix borrowed ACPI codec device references
      ASoC: add new DAI functions
      ASoC: mediatek: mt8192: Improve error handling
      ASoC: fsl_asrc/fsl_easrc: expose per-pair/context DAIs and fix DMA race
      ASoC: codecs: ak4619: Add PDN pin handling
      ASoC: Qualcomm Tambora (WCD9378) SDCA codec
      spi: realtek: Add support for RTD1625 SPI NOR Flash Controller
      Add enhance SPI DMA support for JHB100 SFC
      Merge asoc-linus into asoc-next
      Merge asoc/for-7.4 into asoc-next
      ASoC: aw88399: fix BSTS check using vendor driver logic
      ASoC: rt-sdw: always cancel jack work on remove
      ASoC: qcom: enable audio on stage-2 protected DSPs (mDSP)
      ASoC: cs35l45: Adds support for LDPM feature
      ALSA compress / ASoC compress / SOF: Compressed audio support with IPC4
      ASoC: Intel: Add Yoga Book RT5677 support
      ASoC: mediatek: Handle constraint return value in FE startup
      ASoC: Fixes for the MT8188 sound card
      ASoC: mediatek: Return 0 from FE startup on success
      ASoC: core: Create new components in sane state
      Merge asoc-linus into asoc-next
      Merge asoc/for-7.4 into asoc-next
      ASoC: Fix constraint return value handling
      ASoC: atmel-i2s: fix clock error handling
      ASoC: mediatek: mt8196: Fix clock error handling
      ASoC: tegra: Support auxiliary devices
      ASoC: SOF/amd: ACP7.B support and ASP carveout firmware loading
      ASoC: tegra: Support WM8994 by machine driver
      ASoC: codecs: Fix Wolfson control definitions that write another control's bits
      Merge asoc-linus into asoc-next
      Merge asoc/for-7.4 into asoc-next
      ASoC: SOF/amd: Fixups for ACP7.B support and ASP carveout
      ASoC: qcom: Add QAIF driver for Shikra audio platform
      ASoC: qcom: qdsp6: report the position of a drained buffer
      ASoC: Intel: avs: Fix for recovery procedure and new size-checks
      This series resends the self-contained ASoC changes from the earlier Hawi/Maili LPASS audio submission.
      ASoC: Series of loose fixes
      ASoC: soc-component: move snd_soc_component_xxx() to soc-component.c
      ASoC: mediatek: mt8195: Fix clock error handling
      ASoC: Address remaining PCM constraint issues
      ASoC: codecs: Fix control definitions that write another control's register
      ASoC: Enable soundcard on Motorola Edge 30
      ASoC: qcom: Add Nord audio support
      ASoC: codecs: Fix more control definitions that write another control's bits

Maurizio Casciano (2):
      ASoC: Intel: Add Cherry Trail RT5677 machine driver
      ASoC: Intel: cht: Add Yoga Book RT5677 machine entry

Michael Auer (1):
      ASoC: qcom: sdm845: Disable the quaternary MI2S bit clock on shutdown

Michał Kopeć (4):
      ASoC: mediatek: common: Keep codec references until the card is bound
      ASoC: mediatek: Don't keep a freed topology name in the static card
      ASoC: mediatek: mt8188: Constrain UL8 FE to its back end's capabilities
      ASoC: hdmi-codec: Don't parse an empty ELD on startup

Mingxuan Guo (2):
      firmware: cs_dsp: clear dsp->running on the cs_dsp_run() error path
      firmware: cs_dsp: add a KUnit test for the cs_dsp_run() error path

Miquel Raynal (2):
      spi: spi-mem: Enable DTR transfers using the standard API
      spi: ma35d1-qspi: Allow DTR operations with the regular SPI API

Mizuno Miotsuki (1):
      ASoC: codecs: rk3308: add support for codec revision B

Mohammad Rafi Shaik (8):
      ASoC: dt-bindings: qcom: add QAIF AIF MI2S and TDM dai ids
      ASoC: qcom: qdsp6: lpass-ports: add support for QAIF AIF MI2S and TDM dais
      ASoC: qcom: sc8280xp: Handle AIF MI2S and TDM interfaces
      ASoC: dt-bindings: ti,pcm1681: Document the optional SCK clock
      ASoC: codec: pcm1681: Add optional SCK clock and runtime PM support
      ASoC: codec: pcm1681: Add TDM support
      ASoC: dt-bindings: qcom,sm8250: Add Nord sound card
      ASoC: qcom: sc8280xp: Add Nord sound card support

Mukesh Ojha (11):
      ASoC: mediatek: mt8192: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8196: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8183: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8189: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8173: Use devm_of_reserved_mem_device_init()
      ASoC: SOF: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
      ASoC: SOF: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8188: Use devm_of_reserved_mem_device_init()
      ASoC: sprd: Use devm_of_reserved_mem_device_init()
      ASoC: mediatek: mt8195: Use devm_of_reserved_mem_device_init()

Myeonghun Pak (5):
      ASoC: fsl_xcvr: free IRQ before canceling reset work
      spi: rockchip-sfc: skip DMA cleanup in PIO mode
      ASoC: stm: stm32_i2s: request IRQ after regmap initialization
      ASoC: codecs: rt5682s: disable jack detection work on shutdown
      ASoC: rt5645: Shut down the button timer on removal

Neo Chang (8):
      ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
      ASoC: codecs: nau8360: Add support for NAU83G60 amplifier
      ASoC: codecs: nau8360: Fix static declarations and endianness
      ASoC: codecs: nau8360: Fix kernel-doc issues
      ASoC: codecs: nau8360: Add default PEQ band number for DSP init
      ASoC: codecs: nau8360: Fix misleading return in nau8360_message_to_dsp()
      ASoC: codecs: nau8360: Block DSP path selection when firmware load fails
      ASoC: codecs: nau8360: Fix AB-BA deadlock in mux update

Niranjan H Y (1):
      ASoC: amd: acp-legacy-mach: skip dai link for amp reference stream

Oder Chiou (2):
      ASoC: rt721: Use the function_status check to avoid duplicate presets
      ASoC: rt721: Add support for the RT721_U and RT718 codec variants

Ovidiu Panait (1):
      spi: rspi: Fix DMA mode when the DMA controller is built as a module

Peng Fan (3):
      spi: use dmaengine_get_dma_device() for DMA mapping
      ASoC: use regmap_assign_bits() for conditional set/clear
      ASoC: soc-generic-dmaengine-pcm: use dmaengine_get_dma_device() for DMA device

Pengpeng Hou (24):
      spi: sh-msiof: propagate setup runtime-PM errors
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

Peter Ujfalusi (22):
      ALSA: compress: pin card module while stream is open
      ALSA: compress: register the open file with the card
      ALSA: compress: stop active streams on disconnect
      ALSA: compress: Set the draining state before the drain trigger
      ASoC: soc-compress: Provide a runtime for the compressed FE substream
      ASoC: soc-compress: Implement trigger FE-BE sequencing as with normal PCMs
      ASoC: soc-compress: Stop running dpcm on free
      ASoC: SOF: sof-audio: Fix the pipeline_list population
      ASoC: SOF: ipc4-pcm: Serialize the PCM free with the pipeline triggers
      ASoC: SOF: sof-audio: do not dereference swidget->spipe unconditionally on free
      ASoC: SOF: ipc4: Add definition of module data in init_ext object type
      ASoC: SOF: ipc4-topology: Support init_ext_module_data for process modules
      ASoC: SOF: ipc4-pcm: Make the timestamp info usable outside of ipc4-pcm.c
      ASoC: SOF: ipc4/ipc4-loader: Add SOF_INFO and CODEC_INFO to fw_config_params
      ASoC: SOF: ipc4-pcm: Handle COMPR DRAIN triggers as EOS pipeline state
      ASoC: SOF: ipc4-topology: Set FAST_MODE for host copier in compr mode
      ASoC: SOF: Check that the audio buffer fits into the page table
      ASoC: SOF: Add support for IPC4 compressed
      ASoC: SOF: ipc4: Handle compressed drain done notification from firmware
      ASoC: SOF: Intel: Kconfig: Remove redundant IPC version selects
      ASoC: SOF: Intel: Kconfig: Select compress support for TGL+ platforms
      ASoC: SOF: Intel: Make sure that link and host DMA is coupled after use

Prasad Kumpatla (4):
      ASoC: codecs: wsa885x: Reset registers on teardown for B2B playback
      ASoC: qcom: sc8280xp: add Maili sound card configuration
      ASoC: codecs: wsa885x: Reset registers on teardown for B2B playback
      ASoC: qcom: sc8280xp: add Maili sound card configuration

Praveen Talari (2):
      spi: qcom-geni: Add shutdown callback to quiesce hardware on reboot
      spi: qcom-geni: Add panic notifier to cancel and reset DMA during panic

Priyanka Mani (1):
      ASoC: mediatek: mt8365: Fix out-of-bounds read in get_iir_coef()

Qianghua Wang (3):
      ASoC: codecs: add SN624x SDCA SoundWire driver
      ASoC: sdw_utils: add Senary SN624x helpers and codec_info
      ASoC: Intel: soc-acpi: add SN624x entries for ARL/LNL/MTL/PTL

Randy Dunlap (1):
      spi: spi-master: use literal blocks for commands

Ranjani Sridharan (7):
      ASoC: SOF: compress: Move the IPC agnostic helpers to sof-audio.c
      ASoC: SOF: compress: Rename compress ops with ipc3 prefix
      ASoC: SOF: sof-audio: Expose a couple of functions
      ASoC: SOF: pcm: Modify the signature of a couple of PCM IPC ops
      ASoC: SOF: intel: hda-stream: Clear the current position when releasing stream
      ASoC: SOF: ops: Add new platform-specific ops for compress
      ASoC: SOF: topology: Add support for decoder and encoder widgets

Ricardo Rivera-Matos (4):
      ASoC: dt-bindings: cs35l45: Adds SYNC properties
      ASoC: cs35l45: Adds support for SYNC bus
      ASoC: dt-bindings: cs35l45: Adds LDPM settings
      ASoC: cs35l45: Adds support for LDPM feature

Richard Acayan (1):
      ASoC: dt-bindings: msm8916-digital-codec: Add SDM670 compatible

Richard Fitzgerald (1):
      ASoC: cs35l56: Add KUnit tests for regmap defaults table

Rob Herring (Arm) (6):
      ASoC: ak4642: Drop "clocks" property presence check
      ASoC: twl4030: Fix "ti,hs_extmute" property type
      ASoC: sta3xx: Fix "st,drop-compensation-ns" size
      ASoC: dt-bindings: mediatek: Fix MT7622 clock count
      ASoC: dt-bindings: hi6210-i2s: Allow graph ports
      ASoC: dt-bindings: Fix TAS2563 address constraints

Rosen Penev (5):
      ASoC: uniphier: aio-dma: pass chip to irq handler
      ASoC: tegra: ADX: convert map to flexible array
      spi: orion: yield to scheduler in transfer wait loop
      ASoC: xilinx: formatter_pcm: use more devm in probe
      ASoC: fsl: mpc5200: gate AC97 driver on PPC_MPC52xx

Runyu Xiao (2):
      ASoC: pcm6240: do not free an unrequested IRQ
      ASoC: codecs: wcd937x: request watchdog IRQs without devm

Shawn Guo (2):
      ASoC: dt-bindings: ti,pcm1681: Document the PCM1681 supplies
      ASoC: codec: pcm1681: Enable the PCM1681 supplies

Sheetal (1):
      ASoC: tegra: Fix ASRC Stream6 input threshold control

Shenghao Ding (5):
      ASoC: tas2781: add support for TAS2573 DSP functionality
      ASoC: tas2781: Add register decoded info to I/O error logs
      ASoC: tas2781: Add TAS2573 calibration support
      ASoC: tas2781: Refactor register error log with unified macro
      ASoC: tas2781: Fix TAS2781/TAS5825 PPC version logic conflict

Shengjiu Wang (6):
      ASoC: fsl_asrc: use regmap_write_bits to update clock source registers
      ASoC: dt-bindings: fsl,imx-asrc: update port binding to support multiple paths
      ASoC: dt-bindings: fsl,easrc: add ports binding for multiple conversion paths
      ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
      ASoC: fsl_asrc: expose individual DAIs per conversion path
      ASoC: fsl_easrc: expose individual DAIs per conversion path

Shuming Fan (6):
      ASoC: rt1320: avoid re-initialize in advanced mode
      ASoC: rt712: add GPIOs for LED control
      ASoC: sdw_utils: Add rt766/rt767 support
      ASoC: rt766: avoid re-initialize the blind write
      ASoC: rt712: avoid duplicate reset in io_init
      ASoC: rt766: trigger JD when system reboots

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

Sunny Luo (1):
      spi: amlogic: spisg: Fix the incorrect keep_ss of the last descriptor

Svyatoslav Ryhel (4):
      ASoC: nvidia,tegra-audio-common: Document nvidia,aux-devs property
      ASoC: tegra: Support auxiliary devices
      ASoC: dt-bindings: nvidia,tegra-audio: Document WM8994 CODEC
      ASoC: tegra: Support WM8994 by machine driver

Syed Saba Kareem (1):
      ASoC: amd: acp: fix TAS2783 SoundWire codec unmet dependencies

Thanh Quan (1):
      spi: dt-bindings: renesas,sh-msiof: Add support for R-Car X5H

Thierry Reding (1):
      dt-bindings: ASoC: nvidia,tegra30-ahub: Convert to json-schema

Udaya Kiran Challa (1):
      spi: dt-bindings: microchip,pic32mzda-spi: Convert to DT schema

Val Packett (4):
      ASoC: qcom: qdsp6: q6routing: add Senary MI2S ports
      ASoC: qcom: sm8250: add Senary MI2S RX support
      ASoC: dt-bindings: qcom,sm8250: Add Motorola Edge 30 sound card
      ASoC: qcom: sm8250: Add motorola-dubai soundcard compatible

Vijendar Mukunda (22):
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
      ASoC: SOF: amd: rename acp7x machine table and descriptor to acp7f
      ASoC: SOF: amd: select descriptor per PCI revision in acp7x probe
      ASoC: amd: add I2S machine table for ACP7.B
      ASoC: SOF: amd: add ACP7.B chip descriptor and wire per-revision probe
      ASoC: SOF: amd: Propagate PCI subsystem Vendor and Device IDs
      ASoC: SOF: amd: consolidate local variable declarations
      ASoC: amd: acp: add acp-mach-common.h for shared machine driver types
      ASoC: SOF: amd: propagate pdm_sel to SDW machine driver via mach->pdata
      ASoC: SOF: amd: add ASP carveout firmware loading for ACP7.B/7.F
      ASoC: SOF: amd: fix trailing blank line at EOF in acp_asp_mailbox.c
      ASoC: amd: acp: move ACP7X_PDM_DMIC0/1 to acp-mach-common.h

Viken Dadhaniya (1):
      spi: qcom-geni: rename setup_fifo_params() to setup_spi_params() and make it void

Vishwaroop A (3):
      spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
      spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
      spi: tegra210-quad: Process small PIO transfers in hard IRQ context

Vladyslav Tymoshchuk (3):
      ASoC: qcom: q6apm-dai: wrap the position of a full ring to 0
      ASoC: qcom: q6apm: reset the hw pointer with the fragment queue
      ASoC: qcom: q6asm-dai: wrap the position of a full ring to 0

Wentao Liang (6):
      ASoC: wm8994: Fix runtime PM imbalance in wm8994_component_probe()
      ASoC: arizona-jack: Fix runtime PM imbalance in arizona_start_hpdet_acc_id()
      ASoC: audio-graph-card2: Fix use-after-free in audio_graph2_link_c2c()
      ASoC: codecs: wm8994: Fix runtime PM leak in wm8994_mic_detect()
      ASoC: ti: davinci-mcasp: Fix runtime PM imbalance in __davinci_mcasp_set_clkdiv()
      ASoC: codecs: wcd9335: Fix SLIM interface device leak in wcd9335_slim_status()

Xianwei Zhao (4):
      spi: dt-bindings: amlogic: spisg: Document A9-specific properties
      spi: amlogic: spisg: Fix transfer size limit and timeout handling
      spi: amlogic: spisg: Add support for A9 controller features
      spi: dt-bindings: amlogic,meson-gx-spicc: add T7 compatible

Yibo Tan (2):
      ASoC: amd: acp-es8336: Use an owned codec device reference
      ASoC: amd: acp3x-es83xx: Keep an owned codec device reference

Yuri Zaporozhets (1):
      ASoC: dwc: Use OF match data again for StarFive JH7110

Zachary Huang (1):
      ASoC: es9356: add missing DAI rates and formats

Zain Aboobacker (2):
      ASoC: dt-bindings: foursemi,fs2105s: Fix typo
      ASoC: codecs: nau8825: fix typos in comments

Zhang Heng (2):
      ASoC: amd: yc: Add DMI quirk for MSI Crosshair A17 HX D8WFKG
      ASoC: amd: yc: Add DMI quirk for MSI Alpha 17 C7VF

Zhang Yi (2):
      ASoC: codecs: ES8326: Add private members about HPF
      ASoC: codecs: ES8326: Adjust the standby configuration

Ziyang Huang (1):
      spi: spi-qpic-snand: reject when no enough OOB space

bui duc phuc (143):
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
      ASoC: rockchip: rockchip_sai: Handle runtime PM resume failures in set_fmt
      ASoC: rockchip: rockchip_i2s: Handle runtime PM resume failures in set_fmt
      ASoC: mediatek: common: Handle constraint return value in FE startup
      ASoC: mediatek: mt8188: Handle constraint return value in FE startup
      ASoC: mediatek: mt8189: Handle constraint return value in FE startup
      ASoC: mediatek: mt8365: Handle constraint return value in FE startup
      ASoC: mediatek: common: return 0 from mtk_afe_fe_startup() on success
      ASoC: mediatek: mt8188: return 0 from mt8188_afe_fe_startup() on success
      ASoC: mediatek: mt8189:return 0 from mt8189_fe_startup() on success
      ASoC: mediatek: mt8365: return 0 from mt8365_afe_fe_startup() on success
      ASoC: codecs: rt5645: Simplify optional GPIO error handling
      ASoC: codecs: rt5659: propagate GPIO errors
      ASoC: amd: acp: Fix .close() being skipped on rollback
      ASoC: amd: ps: Fix acp63_pdm_dma_close() being skipped on rollback
      ASoC: amd: ps: Fix acp63_sdw_dma_close() being skipped on rollback
      ASoC: amd: raven: Fix acp3x_dma_close() being skipped on rollback
      ASoC: amd: renoir: Fix acp_pdm_dma_close() being skipped on rollback
      ASoC: amd: vangogh: Fix acp5x_dma_close() being skipped on rollback
      ASoC: amd: yc: Fix acp6x_pdm_dma_close() being skipped on rollback
      ASoC: apple: mca: Ensure the DAI is marked as started on success
      ASoC: atmel: atmel-pcm-pdc: Fix atmel_pcm_close() being skipped on rollback
      ASoC: codecs: cs42l42: Ensure the DAI is marked as started on success
      ASoC: codecs: nau8325: Ensure the DAI is marked as started on success
      ASoC: codecs: nau8540: Ensure the DAI is marked as started on success
      ASoC: codecs: nau8821: Ensure the DAI is marked as started on success
      ASoC: codecs: nau8824: Ensure the DAI is marked as started on success
      ASoC: codecs: nau8825: Ensure the DAI is marked as started on success
      ASoC: codecs: wm8580: Ensure the DAI is marked as started on success
      ASoC: codecs: wm8782: Ensure the DAI is marked as started on success
      ASoC: imx-pcm-rpmsg: Fix imx_rpmsg_pcm_close() being skipped on rollback
      ASoC: intel: atom: Fix .shutdown() being skipped on rollback
      ASoC: renesas: fsi: Ensure the component is marked as opened on success
      ASoC: renesas: msiof: Fix msiof_close() being skipped on rollback
      ASoC: renesas: rz-ssi: Ensure the component is marked as opened on success
      ASoC: rockchip: rk3399_gru_sound: Mark the link as started on success
      ASoC: rockchip: rockchip_max98090: Mark the link as started on success
      ASoC: atmel-i2s: fix MCK generator error handling
      ASoC: atmel-i2s: use optional API for muxclk
      ASoC: atmel-i2s: use optional API for gclk
      ASoC: atmel-i2s: use dev_err_probe() for pclk errors
      ASoC: atmel-i2s: remove redundant error message
      ASoC: mediatek: mt8196: fix APLL mux error handling
      ASoC: mediatek: mt8196: fix APLL enable error handling
      ASoC: mediatek: mt8196: fix MCK error handling
      ASoC: mediatek: mt8196: fix register access clock error handling
      ASoC: mediatek: mt8196: propagate main clock errors
      ASoC: mediatek: mt8196: use dev_err_probe() in mt8196_init_clock()
      ASoC: mediatek: mt8196: fix runtime resume error handling
      ASoC: mediatek: mt8196: remove redundant error message
      ASoC: mediatek: mt8196: propagate I2S clock errors
      ASoC: mediatek: mt8196: propagate TDM clock errors
      ASoC: mediatek: mt8195: Fix tuner clock error handling
      ASoC: mediatek: mt8195: Use dev_err_probe() in mt8195_afe_init_clock()
      ASoC: mediatek: mt8195: Fix register access clock error handling
      ASoC: mediatek: mt8195: Fix timing system clock error handling
      ASoC: mediatek: mt8195: Fix main clock error handling
      ASoC: mediatek: mt8195: Fix paired memif clock error handling
      ASoC: mediatek: mt8195: Fix FE startup error handling
      ASoC: mediatek: mt8195: Check paired MEMIF clock enable in FE trigger
      ASoC: mediatek: mt8195: Fix runtime resume error handling
      ASoC: mediatek: mt8195: Remove redundant error message
      ASoC: mediatek: mt8195: Propagate IRQ lookup errors
      ASoC: mediatek: mt8195: Fix ETDM MCLK error handling
      ASoC: mediatek: mt8195: Fix ETDM startup error handling
      ASoC: mediatek: mt8195: Fix HDMI TX startup error handling
      ASoC: mediatek: mt8195: Fix ETDM probe error handling
      ASoC: mediatek: mt8195: Fix clock parent error handling
      ASoC: amd: Explain component open return value handling
      ASoC: apple: Explain DAI startup return value handling
      ASoC: atmel: Explain component open return value handling
      ASoC: codecs: Explain DAI startup return value handling
      ASoC: imx-pcm-rpmsg: Explain component open return value handling
      ASoC: intel: atom: Explain DAI startup return value handling
      ASoC: renesas: msiof: Explain component open return value handling
      ASoC: renesas: msiof: Remove redundant period constraint
      ASoC: renesas: rz-ssi: Explain component open return value handling
      ASoC: renesas: rz-ssi: Remove redundant component open callback
      ASoC: rockchip: Explain DAI link startup return value handling

Ștefan Ghețu (3):
      ASoC: SOF: imx8: remove unused regmap field from imx8m_chip_data
      ASoC: SOF: imx8: check imx_sc_pm_cpu_start() return value
      ASoC: SOF: imx: Prevent stack OOB read in DSP panic dump

 Documentation/ABI/testing/sysfs-class-spi-master   |    6 +-
 .../devicetree/bindings/sound/adi,adau1372.yaml    |   10 +-
 .../devicetree/bindings/sound/adi,adau7118.yaml    |   22 +-
 .../bindings/sound/airoha,an7581-afe.yaml          |   41 +
 .../bindings/sound/airoha,an7581-wm8960.yaml       |   71 +
 .../bindings/sound/amlogic,gx-sound-card.yaml      |   20 +-
 .../bindings/sound/asahi-kasei,ak4619.yaml         |   16 +-
 .../bindings/sound/audio-graph-port.yaml           |   10 +-
 .../devicetree/bindings/sound/cirrus,cs35l45.yaml  |  146 +-
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
 .../bindings/sound/nvidia,tegra-audio-common.yaml  |    5 +
 .../bindings/sound/nvidia,tegra-audio-wm8994.yaml  |  110 +
 .../bindings/sound/nvidia,tegra30-ahub.txt         |   88 -
 .../bindings/sound/nvidia,tegra30-ahub.yaml        |  289 +++
 .../sound/qcom,msm8916-wcd-digital-codec.yaml      |    1 +
 .../devicetree/bindings/sound/qcom,q6apm-dai.yaml  |   17 +-
 .../bindings/sound/qcom,q6apm-lpass-dais.yaml      |   12 +-
 .../bindings/sound/qcom,q6dsp-lpass-ports.yaml     |   16 +-
 .../bindings/sound/qcom,shikra-qaif-cpu.yaml       |  290 +++
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |    3 +
 .../bindings/sound/qcom,wcd9378-sdw.yaml           |  105 +
 .../devicetree/bindings/sound/realtek,rt5677.yaml  |   10 +
 .../devicetree/bindings/sound/renesas,rsnd.yaml    |   16 +-
 .../devicetree/bindings/sound/renesas,rz-ssi.yaml  |   32 +-
 .../bindings/sound/stericsson,ux500-msp-i2s.yaml   |   96 +
 .../bindings/sound/ti,da830-evm-audio.yaml         |   83 +
 .../devicetree/bindings/sound/ti,pcm1681.yaml      |   16 +
 .../devicetree/bindings/sound/ti,tas2781.yaml      |    4 +-
 .../devicetree/bindings/sound/ti,tas5805m.yaml     |   10 +-
 .../bindings/sound/ti,tlv320dac3100.yaml           |    2 +-
 .../devicetree/bindings/sound/ti,tpa6130a2.yaml    |    2 +-
 .../devicetree/bindings/sound/ux500-mop500.txt     |   39 -
 .../devicetree/bindings/sound/ux500-msp.txt        |   42 -
 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  |   30 +-
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |   13 +-
 .../bindings/spi/microchip,pic32mzda-spi.yaml      |   82 +
 .../bindings/spi/microchip,spi-pic32.txt           |   34 -
 .../bindings/spi/realtek,rtd1625-nor.yaml          |   65 +
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |    9 +-
 .../bindings/spi/spi-peripheral-props.yaml         |    8 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/driver-api/driver-model/devres.rst   |    2 -
 Documentation/spi/multiple-data-lanes.rst          |   10 +-
 MAINTAINERS                                        |   33 +
 drivers/base/regmap/internal.h                     |    1 +
 drivers/base/regmap/regmap-irq.c                   |    2 +-
 drivers/base/regmap/regmap-kunit.c                 |   98 +-
 drivers/base/regmap/regmap-ram.c                   |   26 +-
 drivers/base/regmap/regmap-raw-ram.c               |   21 +-
 drivers/base/regmap/regmap.c                       |    2 +-
 drivers/firmware/cirrus/cs_dsp.c                   |    4 +-
 .../firmware/cirrus/test/cs_dsp_test_callbacks.c   |   35 +
 drivers/gpib/fmh_gpib/fmh_gpib.c                   |   10 +-
 drivers/spi/Kconfig                                |  374 ++--
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-amlogic-spisg.c                    |  116 +-
 drivers/spi/spi-ar934x.c                           |   13 +-
 drivers/spi/spi-at91-usart.c                       |    4 +-
 drivers/spi/spi-atmel.c                            |    4 +-
 drivers/spi/spi-bcm2835.c                          |   29 +-
 drivers/spi/spi-bcm63xx.c                          |    2 +-
 drivers/spi/spi-cadence-quadspi.c                  |    2 +-
 drivers/spi/spi-dw-core.c                          |  118 +-
 drivers/spi/spi-dw-dma.c                           |  290 ++-
 drivers/spi/spi-dw-mmio.c                          |    2 +
 drivers/spi/spi-dw.h                               |    8 +
 drivers/spi/spi-ep93xx.c                           |    8 +-
 drivers/spi/spi-fsl-dspi.c                         |   35 +-
 drivers/spi/spi-geni-qcom.c                        |   93 +-
 drivers/spi/spi-imx.c                              |   12 +-
 drivers/spi/spi-ingenic.c                          |   10 +-
 drivers/spi/spi-ma35d1-qspi.c                      |   27 +-
 drivers/spi/spi-mem.c                              |   14 +-
 drivers/spi/spi-mtk-nor.c                          |    1 +
 drivers/spi/spi-mxic.c                             |    8 +-
 drivers/spi/spi-nxp-xspi.c                         |   16 +-
 drivers/spi/spi-omap2-mcspi.c                      |    4 +-
 drivers/spi/spi-orion.c                            |    9 +
 drivers/spi/spi-pic32.c                            |    2 +-
 drivers/spi/spi-pl022.c                            |   19 +-
 drivers/spi/spi-qpic-snand.c                       |  105 +-
 drivers/spi/spi-realtek-rtl.c                      |   36 +-
 drivers/spi/spi-rockchip-sfc.c                     |   21 +-
 drivers/spi/spi-rspi.c                             |   49 +-
 drivers/spi/spi-rtk-nor.c                          |  624 ++++++
 drivers/spi/spi-s3c64xx.c                          |    2 +-
 drivers/spi/spi-sh-msiof.c                         |   18 +-
 drivers/spi/spi-stm32.c                            |    2 +-
 drivers/spi/spi-sun6i.c                            |    2 +-
 drivers/spi/spi-sunplus-sp7021.c                   |   13 +-
 drivers/spi/spi-tegra210-quad.c                    |  509 ++++-
 drivers/spi/spi-virtio.c                           |   22 +-
 drivers/spi/spi-xilinx.c                           |    2 +-
 drivers/spi/spi.c                                  |   15 +-
 include/dt-bindings/sound/cs35l45.h                |   27 +
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h |   52 +
 include/linux/dmaengine.h                          |    9 -
 include/linux/firmware/cirrus/cs_dsp.h             |    2 +-
 include/linux/spi/spi.h                            |    9 +
 include/sound/aw88399.h                            |    6 +-
 include/sound/compress_driver.h                    |    2 +
 include/sound/sdca.h                               |   23 +-
 include/sound/sdca_class.h                         |   70 +
 include/sound/simple_card_utils.h                  |    2 +
 include/sound/soc-component.h                      |   82 +-
 include/sound/soc-dai.h                            |  189 +-
 include/sound/soc.h                                |   35 +-
 include/sound/soc_sdw_utils.h                      |   20 +
 include/sound/sof/ipc4/header.h                    |   24 +-
 include/sound/tas2781-dsp.h                        |   13 +
 include/sound/tas2781.h                            |   31 +
 sound/core/compress_offload.c                      |  110 +-
 sound/hda/codecs/side-codecs/aw88399_hda.c         |   38 +-
 sound/hda/codecs/side-codecs/aw88399_hda.h         |    1 -
 sound/hda/core/intel-nhlt.c                        |    4 +-
 sound/soc/amd/acp-config.c                         |   29 +-
 sound/soc/amd/acp-es8336.c                         |    5 +-
 sound/soc/amd/acp/Kconfig                          |    5 +-
 sound/soc/amd/acp/acp-mach-common.h                |   29 +
 sound/soc/amd/acp/acp-platform.c                   |    7 +-
 sound/soc/amd/acp/acp-sdw-legacy-mach.c            |   32 +
 sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c      |   14 +-
 sound/soc/amd/acp/amd-acp63-acpi-match.c           |   50 +
 sound/soc/amd/acp/soc_amd_sdw_common.h             |    1 +
 sound/soc/amd/mach-config.h                        |    3 +-
 sound/soc/amd/ps/acp63.h                           |    8 +
 sound/soc/amd/ps/pci-ps.c                          |    2 +
 sound/soc/amd/ps/ps-common.c                       |    2 +
 sound/soc/amd/ps/ps-pdm-dma.c                      |    8 +-
 sound/soc/amd/ps/ps-sdw-dma.c                      |    8 +-
 sound/soc/amd/raven/acp3x-pcm-dma.c                |    8 +-
 sound/soc/amd/renoir/acp3x-pdm-dma.c               |    8 +-
 sound/soc/amd/vangogh/acp5x-pcm-dma.c              |    8 +-
 sound/soc/amd/yc/acp6x-mach.c                      |   14 +
 sound/soc/amd/yc/acp6x-pdm-dma.c                   |    8 +-
 sound/soc/apple/mca.c                              |   16 +-
 sound/soc/atmel/atmel-i2s.c                        |   54 +-
 sound/soc/atmel/atmel-pcm-dma.c                    |    2 +-
 sound/soc/atmel/atmel-pcm-pdc.c                    |    7 +
 sound/soc/bcm/cygnus-ssp.h                         |    2 +-
 sound/soc/codecs/88pm860x-codec.c                  |    6 +
 sound/soc/codecs/Kconfig                           |   49 +
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
 sound/soc/codecs/aw88261.c                         |   39 +-
 sound/soc/codecs/aw88399-lib.c                     |   18 +-
 sound/soc/codecs/cpcap.c                           |   90 +-
 sound/soc/codecs/cs35l33.c                         |    8 +-
 sound/soc/codecs/cs35l34.c                         |    2 +-
 sound/soc/codecs/cs35l35.c                         |    7 +
 sound/soc/codecs/cs35l36.c                         |   56 +
 sound/soc/codecs/cs35l41.c                         |   10 +
 sound/soc/codecs/cs35l45-tables.c                  |   62 +
 sound/soc/codecs/cs35l45.c                         |  177 +-
 sound/soc/codecs/cs35l45.h                         |   53 +
 sound/soc/codecs/cs35l56-shared-test.c             |   56 +
 sound/soc/codecs/cs35l56.c                         |   10 +
 sound/soc/codecs/cs40l50-codec.c                   |    9 +
 sound/soc/codecs/cs4234.c                          |    9 +
 sound/soc/codecs/cs4265.c                          |   12 +
 sound/soc/codecs/cs4270.c                          |    6 +
 sound/soc/codecs/cs4271.c                          |    6 +
 sound/soc/codecs/cs42l42.c                         |   27 +-
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
 sound/soc/codecs/da7213.c                          |   23 +-
 sound/soc/codecs/da7218.c                          |  141 +-
 sound/soc/codecs/da7219.c                          |   12 +
 sound/soc/codecs/da732x.c                          |   19 +-
 sound/soc/codecs/da9055.c                          |    8 +
 sound/soc/codecs/es7134.c                          |    6 +
 sound/soc/codecs/es7241.c                          |    7 +
 sound/soc/codecs/es8311.c                          |   27 +-
 sound/soc/codecs/es8316.c                          |   27 +-
 sound/soc/codecs/es8323.c                          |   32 +-
 sound/soc/codecs/es8326.c                          |  177 +-
 sound/soc/codecs/es8326.h                          |    4 +
 sound/soc/codecs/es8328.c                          |   20 +-
 sound/soc/codecs/es8375.c                          |   32 +-
 sound/soc/codecs/es8389.c                          |   65 +-
 sound/soc/codecs/es9039q2m.c                       | 2008 +++++++++++++++++
 sound/soc/codecs/es9356.c                          |   22 +
 sound/soc/codecs/fs210x.c                          |    5 +-
 sound/soc/codecs/hda.c                             |    7 +-
 sound/soc/codecs/hdac_hda.c                        |    2 +-
 sound/soc/codecs/hdac_hdmi.c                       |    2 +-
 sound/soc/codecs/hdmi-codec.c                      |    8 +-
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
 sound/soc/codecs/mt6359-accdet.c                   |   50 +-
 sound/soc/codecs/mt6359.c                          |    8 +-
 sound/soc/codecs/nau8325.c                         |   27 +-
 sound/soc/codecs/nau8360-dsp.c                     |  634 ++++++
 sound/soc/codecs/nau8360-dsp.h                     |  122 ++
 sound/soc/codecs/nau8360.c                         | 2309 ++++++++++++++++++++
 sound/soc/codecs/nau8360.h                         |  917 ++++++++
 sound/soc/codecs/nau8540.c                         |   31 +-
 sound/soc/codecs/nau8810.c                         |   12 +
 sound/soc/codecs/nau8821.c                         |   27 +-
 sound/soc/codecs/nau8822.c                         |   27 +-
 sound/soc/codecs/nau8824.c                         |   27 +-
 sound/soc/codecs/nau8825.c                         |   45 +-
 sound/soc/codecs/ntp8835.c                         |    7 +
 sound/soc/codecs/ntp8918.c                         |    7 +
 sound/soc/codecs/pcm1681.c                         |  157 +-
 sound/soc/codecs/pcm5102a.c                        |   30 +-
 sound/soc/codecs/pcm6240.c                         |    8 +-
 sound/soc/codecs/rk3308_codec.c                    |  113 +-
 sound/soc/codecs/rk3328_codec.c                    |    9 +
 sound/soc/codecs/rt1011.c                          |   44 +-
 sound/soc/codecs/rt1015.c                          |   91 +-
 sound/soc/codecs/rt1016.c                          |   14 +-
 sound/soc/codecs/rt1019.c                          |   10 +
 sound/soc/codecs/rt1305.c                          |   14 +-
 sound/soc/codecs/rt1308.c                          |   14 +-
 sound/soc/codecs/rt1318.c                          |   13 +-
 sound/soc/codecs/rt1320-sdw.c                      |   12 +-
 sound/soc/codecs/rt274.c                           |    8 +
 sound/soc/codecs/rt286.c                           |    8 +
 sound/soc/codecs/rt298.c                           |    8 +
 sound/soc/codecs/rt5514-spi.c                      |   37 +-
 sound/soc/codecs/rt5514.c                          |   39 +-
 sound/soc/codecs/rt5616.c                          |   23 +-
 sound/soc/codecs/rt5631.c                          |   10 +
 sound/soc/codecs/rt5631.h                          |    8 +-
 sound/soc/codecs/rt5640.c                          |   22 +-
 sound/soc/codecs/rt5645.c                          |   52 +-
 sound/soc/codecs/rt5651.c                          |   12 +-
 sound/soc/codecs/rt5659.c                          |   20 +-
 sound/soc/codecs/rt5660.c                          |   14 +-
 sound/soc/codecs/rt5663.c                          |   10 +
 sound/soc/codecs/rt5665.c                          |   14 +-
 sound/soc/codecs/rt5668.c                          |   22 +
 sound/soc/codecs/rt5670.c                          |   12 +-
 sound/soc/codecs/rt5677-spi.c                      |   21 +-
 sound/soc/codecs/rt5677.c                          |   10 +
 sound/soc/codecs/rt5682-sdw.c                      |    3 +-
 sound/soc/codecs/rt5682.c                          |   22 +
 sound/soc/codecs/rt5682s.c                         |   38 +-
 sound/soc/codecs/rt711-sdca-sdw.c                  |    6 +-
 sound/soc/codecs/rt711-sdw.c                       |    8 +-
 sound/soc/codecs/rt712-sdca-dmic.c                 |    4 +-
 sound/soc/codecs/rt712-sdca-sdw.c                  |    7 +-
 sound/soc/codecs/rt712-sdca-sdw.h                  |    3 +
 sound/soc/codecs/rt712-sdca.c                      |  141 +-
 sound/soc/codecs/rt712-sdca.h                      |    6 +
 sound/soc/codecs/rt721-sdca-sdw.c                  |   61 +-
 sound/soc/codecs/rt721-sdca-sdw.h                  |    7 +
 sound/soc/codecs/rt721-sdca.c                      |  799 +++++--
 sound/soc/codecs/rt721-sdca.h                      |   44 +
 sound/soc/codecs/rt722-sdca-sdw.c                  |    6 +-
 sound/soc/codecs/rt766-sdca.c                      |   10 +-
 sound/soc/codecs/rt766-sdca.h                      |    1 +
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
 sound/soc/codecs/sta32x.c                          |  136 +-
 sound/soc/codecs/sta350.c                          |   35 +-
 sound/soc/codecs/sta529.c                          |    7 +
 sound/soc/codecs/tas2552.c                         |   14 +
 sound/soc/codecs/tas2562.c                         |   10 +
 sound/soc/codecs/tas2764.c                         |   14 +-
 sound/soc/codecs/tas2770.c                         |   14 +-
 sound/soc/codecs/tas2780.c                         |   10 +
 sound/soc/codecs/tas2781-comlib-i2c.c              |    4 +-
 sound/soc/codecs/tas2781-comlib.c                  |   10 +-
 sound/soc/codecs/tas2781-fmwlib.c                  |   46 +-
 sound/soc/codecs/tas2781-i2c.c                     |  320 ++-
 sound/soc/codecs/tas2783-sdw.c                     |  218 +-
 sound/soc/codecs/tas2783.h                         |    4 +-
 sound/soc/codecs/tas5086.c                         |    7 +
 sound/soc/codecs/tas571x.c                         |    7 +
 sound/soc/codecs/tas5720.c                         |    9 +
 sound/soc/codecs/tas6424.c                         |    9 +
 sound/soc/codecs/tfa9879.c                         |    9 +
 sound/soc/codecs/tlv320adc3xxx.c                   |   16 +-
 sound/soc/codecs/tlv320adcx140.c                   |   12 +
 sound/soc/codecs/tlv320aic23.c                     |    9 +
 sound/soc/codecs/tlv320aic26.c                     |    8 +
 sound/soc/codecs/tlv320aic31xx.c                   |   41 +-
 sound/soc/codecs/tlv320aic32x4-clk.c               |    2 +-
 sound/soc/codecs/tlv320aic32x4.c                   |  104 +-
 sound/soc/codecs/tlv320aic32x4.h                   |    1 +
 sound/soc/codecs/tlv320aic3x.c                     |   42 +-
 sound/soc/codecs/tlv320dac33.c                     |   10 +-
 sound/soc/codecs/tscs454.c                         |   15 +
 sound/soc/codecs/twl4030.c                         |   87 +-
 sound/soc/codecs/uda1334.c                         |    6 +
 sound/soc/codecs/uda1342.c                         |    7 +
 sound/soc/codecs/uda1380.c                         |   11 +
 sound/soc/codecs/wcd-mbhc-v2.c                     |    8 +-
 sound/soc/codecs/wcd9335.c                         |   25 +-
 sound/soc/codecs/wcd934x.c                         |    2 +-
 sound/soc/codecs/wcd9378-sdca.c                    | 1080 +++++++++
 sound/soc/codecs/wcd9378-sdca.h                    |   20 +
 sound/soc/codecs/wcd9378-sdw.c                     |   51 +
 sound/soc/codecs/wcd937x.c                         |   44 +-
 sound/soc/codecs/wcd939x.c                         |   10 +-
 sound/soc/codecs/wcd939x.h                         |    1 -
 sound/soc/codecs/wm2200.c                          |   10 +
 sound/soc/codecs/wm5100.c                          |   12 +-
 sound/soc/codecs/wm8350.c                          |   24 +
 sound/soc/codecs/wm8400.c                          |    9 +
 sound/soc/codecs/wm8510.c                          |   14 +-
 sound/soc/codecs/wm8523.c                          |   13 +
 sound/soc/codecs/wm8524.c                          |    6 +
 sound/soc/codecs/wm8580.c                          |   35 +-
 sound/soc/codecs/wm8711.c                          |   13 +
 sound/soc/codecs/wm8728.c                          |    9 +
 sound/soc/codecs/wm8731.c                          |   13 +
 sound/soc/codecs/wm8737.c                          |   19 +-
 sound/soc/codecs/wm8741.c                          |   13 +
 sound/soc/codecs/wm8750.c                          |   15 +-
 sound/soc/codecs/wm8753.c                          |   20 +
 sound/soc/codecs/wm8770.c                          |   11 +
 sound/soc/codecs/wm8776.c                          |   13 +
 sound/soc/codecs/wm8782.c                          |   12 +-
 sound/soc/codecs/wm8804.c                          |   15 +-
 sound/soc/codecs/wm8900.c                          |   18 +
 sound/soc/codecs/wm8903.c                          |   18 +
 sound/soc/codecs/wm8904.c                          |   20 +-
 sound/soc/codecs/wm8940.c                          |   13 +
 sound/soc/codecs/wm8955.c                          |   44 +-
 sound/soc/codecs/wm8958-dsp2.c                     |    8 +-
 sound/soc/codecs/wm8960.c                          |   13 +
 sound/soc/codecs/wm8961.c                          |   18 +
 sound/soc/codecs/wm8962.c                          |   74 +-
 sound/soc/codecs/wm8971.c                          |   13 +
 sound/soc/codecs/wm8974.c                          |   17 +
 sound/soc/codecs/wm8978.c                          |   12 +
 sound/soc/codecs/wm8983.c                          |   14 +-
 sound/soc/codecs/wm8985.c                          |   55 +-
 sound/soc/codecs/wm8988.c                          |   13 +
 sound/soc/codecs/wm8990.c                          |   19 +-
 sound/soc/codecs/wm8991.c                          |   19 +-
 sound/soc/codecs/wm8993.c                          |   18 +
 sound/soc/codecs/wm8994.c                          |   29 +-
 sound/soc/codecs/wm8995.c                          |   61 +-
 sound/soc/codecs/wm8996.c                          |   14 +-
 sound/soc/codecs/wm9081.c                          |   18 +
 sound/soc/codecs/wm9713.c                          |   13 +
 sound/soc/codecs/wm_hubs.c                         |    4 +-
 sound/soc/codecs/wsa885x.c                         |   11 +-
 sound/soc/codecs/zl38060.c                         |    6 +
 sound/soc/dwc/dwc-i2s.c                            |   15 +-
 sound/soc/fsl/Kconfig                              |    2 +-
 sound/soc/fsl/fsl_asrc.c                           |  110 +-
 sound/soc/fsl/fsl_asrc_common.h                    |    7 +-
 sound/soc/fsl/fsl_asrc_dma.c                       |   38 +-
 sound/soc/fsl/fsl_asrc_m2m.c                       |   17 +-
 sound/soc/fsl/fsl_easrc.c                          |  125 +-
 sound/soc/fsl/fsl_mqs.c                            |   14 +
 sound/soc/fsl/fsl_xcvr.c                           |   26 +-
 sound/soc/fsl/imx-pcm-rpmsg.c                      |    8 +-
 sound/soc/generic/audio-graph-card.c               |    1 +
 sound/soc/generic/audio-graph-card2.c              |    4 +-
 sound/soc/generic/simple-card-utils.c              |   23 +-
 sound/soc/generic/simple-card.c                    |   13 +-
 sound/soc/hisilicon/hi6210-i2s.c                   |    7 +
 sound/soc/img/img-i2s-in.c                         |   12 +-
 sound/soc/img/img-i2s-out.c                        |   13 +-
 sound/soc/img/img-parallel-out.c                   |    8 +-
 sound/soc/intel/atom/sst-mfld-dsp.h                |    2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |    7 +-
 sound/soc/intel/atom/sst/sst.h                     |    2 +-
 sound/soc/intel/atom/sst/sst_acpi.c                |   14 +-
 sound/soc/intel/avs/boards/hdaudio.c               |    8 +-
 sound/soc/intel/avs/pcm.c                          |   24 +-
 sound/soc/intel/avs/probes.c                       |   12 +-
 sound/soc/intel/avs/topology.c                     |   31 +-
 sound/soc/intel/avs/topology.h                     |    3 -
 sound/soc/intel/avs/utils.c                        |    6 +-
 sound/soc/intel/boards/Kconfig                     |   15 +
 sound/soc/intel/boards/Makefile                    |    2 +
 sound/soc/intel/boards/cht_rt5677.c                |  654 ++++++
 sound/soc/intel/boards/sof_cirrus_common.c         |    2 +-
 sound/soc/intel/catpt/pcm.c                        |   12 +-
 sound/soc/intel/common/soc-acpi-intel-arl-match.c  |   71 +
 sound/soc/intel/common/soc-acpi-intel-cht-match.c  |    8 +
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
 sound/soc/mediatek/common/mtk-afe-fe-dai.c         |   22 +-
 sound/soc/mediatek/common/mtk-base-afe.h           |    2 +
 sound/soc/mediatek/common/mtk-soundcard-driver.c   |   67 +-
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
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c         |   41 +-
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c      |   12 +-
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c        |    5 +-
 sound/soc/mediatek/mt8188/mt8188-dai-dmic.c        |   10 +-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c          |    3 +
 sound/soc/mediatek/mt8189/mt8189-afe-clk.c         |  134 +-
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c         |   69 +-
 sound/soc/mediatek/mt8189/mt8189-dai-i2s.c         |   18 +-
 sound/soc/mediatek/mt8189/mt8189-dai-tdm.c         |   19 +-
 sound/soc/mediatek/mt8192/mt8192-afe-clk.c         |  163 +-
 sound/soc/mediatek/mt8192/mt8192-afe-gpio.c        |   94 +-
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c         |   23 +-
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c        |   44 +-
 sound/soc/mediatek/mt8192/mt8192-dai-i2s.c         |   20 +-
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c         |   18 +-
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  |   37 +-
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c         |   86 +-
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c         |  109 +-
 sound/soc/mediatek/mt8195/mt8195-dai-adda.c        |    3 +-
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c        |   99 +-
 sound/soc/mediatek/mt8196/mt8196-afe-clk.c         |  145 +-
 sound/soc/mediatek/mt8196/mt8196-afe-pcm.c         |   42 +-
 sound/soc/mediatek/mt8196/mt8196-dai-i2s.c         |   17 +-
 sound/soc/mediatek/mt8196/mt8196-dai-tdm.c         |   16 +-
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c         |    7 +-
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c         |    2 +-
 sound/soc/mxs/mxs-saif.c                           |   10 +
 sound/soc/pxa/mmp-sspa.c                           |    6 +
 sound/soc/pxa/pxa-ssp.c                            |   11 +
 sound/soc/pxa/pxa2xx-i2s.c                         |    6 +
 sound/soc/pxa/pxa2xx-pcm-lib.c                     |    9 +-
 sound/soc/qcom/Kconfig                             |   11 +
 sound/soc/qcom/Makefile                            |    3 +
 sound/soc/qcom/common.c                            |   61 +-
 sound/soc/qcom/common.h                            |    5 +-
 sound/soc/qcom/lpass-cpu.c                         |   23 +-
 sound/soc/qcom/qaif-cpu.c                          |  887 ++++++++
 sound/soc/qcom/qaif-platform.c                     |  885 ++++++++
 sound/soc/qcom/qaif-reg.h                          |  470 ++++
 sound/soc/qcom/qaif-shikra.c                       |  445 ++++
 sound/soc/qcom/qaif.h                              |  292 +++
 sound/soc/qcom/qdsp6/audioreach.c                  |   12 +-
 sound/soc/qcom/qdsp6/audioreach.h                  |   22 +-
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |  329 ++-
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c            |    2 +
 sound/soc/qcom/qdsp6/q6apm.c                       |   10 +-
 sound/soc/qcom/qdsp6/q6apm.h                       |    2 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |    9 +-
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c           |   54 +
 sound/soc/qcom/qdsp6/q6prm.c                       |    2 +
 sound/soc/qcom/qdsp6/q6routing.c                   |   11 +
 sound/soc/qcom/sc8280xp.c                          |  194 +-
 sound/soc/qcom/sdm845.c                            |   68 +-
 sound/soc/qcom/sm8250.c                            |    9 +
 sound/soc/renesas/fsi.c                            |   11 +-
 sound/soc/renesas/rcar/msiof.c                     |   14 +-
 sound/soc/renesas/rz-ssi.c                         |   28 +-
 sound/soc/renesas/siu_dai.c                        |    6 +
 sound/soc/renesas/ssi.c                            |   13 +
 sound/soc/rockchip/rk3288_hdmi_analog.c            |   42 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |   18 +-
 sound/soc/rockchip/rockchip_i2s.c                  |   29 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c              |   27 +-
 sound/soc/rockchip/rockchip_max98090.c             |   15 +-
 sound/soc/rockchip/rockchip_pdm.c                  |   14 +-
 sound/soc/rockchip/rockchip_sai.c                  |   35 +-
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
 sound/soc/soc-ac97.c                               |    6 +-
 sound/soc/soc-card-test.c                          |    7 +-
 sound/soc/soc-component.c                          |  373 +++-
 sound/soc/soc-compress.c                           |  205 +-
 sound/soc/soc-core.c                               |  580 +----
 sound/soc/soc-dai.c                                |  418 +++-
 sound/soc/soc-dapm.c                               |   29 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   28 +-
 sound/soc/soc-internal.h                           |   52 +
 sound/soc/soc-link.c                               |    2 +-
 sound/soc/soc-ops.c                                |   14 +-
 sound/soc/soc-pcm.c                                |  144 +-
 sound/soc/soc-topology-test.c                      |   74 +-
 sound/soc/sof/Makefile                             |    4 +-
 sound/soc/sof/amd/Kconfig                          |    1 +
 sound/soc/sof/amd/Makefile                         |    2 +-
 sound/soc/sof/amd/acp-common.c                     |   34 +
 sound/soc/sof/amd/acp-dsp-offset.h                 |   75 +
 sound/soc/sof/amd/acp-loader.c                     |   64 +
 sound/soc/sof/amd/acp-stream.c                     |    9 -
 sound/soc/sof/amd/acp.c                            |  466 +++-
 sound/soc/sof/amd/acp.h                            |  120 +
 sound/soc/sof/amd/acp7x.c                          |   11 +-
 sound/soc/sof/amd/acp7x.h                          |   37 +
 sound/soc/sof/amd/acp_asp_mailbox.c                |  558 +++++
 sound/soc/sof/amd/pci-acp7x.c                      |   82 +-
 sound/soc/sof/core.c                               |   10 +-
 sound/soc/sof/imx/imx-common.c                     |    1 +
 sound/soc/sof/imx/imx8.c                           |   26 +-
 sound/soc/sof/intel/Kconfig                        |    9 +-
 sound/soc/sof/intel/apl.c                          |    1 +
 sound/soc/sof/intel/cnl.c                          |    1 +
 sound/soc/sof/intel/hda-common-ops.c               |    8 +
 sound/soc/sof/intel/hda-dai.c                      |   26 +-
 sound/soc/sof/intel/hda-pcm.c                      |  142 ++
 sound/soc/sof/intel/hda-stream.c                   |   91 +-
 sound/soc/sof/intel/hda.h                          |   15 +
 sound/soc/sof/intel/icl.c                          |    1 +
 sound/soc/sof/intel/mtl.c                          |    1 +
 sound/soc/sof/intel/skl.c                          |    1 +
 sound/soc/sof/intel/tgl.c                          |    1 +
 sound/soc/sof/{compress.c => ipc3-compress.c}      |  145 +-
 sound/soc/sof/ipc3-dtrace.c                        |    2 +-
 sound/soc/sof/ipc3-pcm.c                           |   29 +-
 sound/soc/sof/ipc3-priv.h                          |    3 +
 sound/soc/sof/ipc4-compress.c                      |  823 +++++++
 sound/soc/sof/ipc4-loader.c                        |   37 +
 sound/soc/sof/ipc4-pcm.c                           |  114 +-
 sound/soc/sof/ipc4-priv.h                          |   55 +-
 sound/soc/sof/ipc4-topology.c                      |  178 +-
 sound/soc/sof/ipc4-topology.h                      |    9 +
 sound/soc/sof/ipc4.c                               |   13 +-
 sound/soc/sof/mediatek/mt8186/mt8186.c             |    2 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c             |    2 +-
 sound/soc/sof/ops.h                                |   74 +
 sound/soc/sof/pcm.c                                |   20 +-
 sound/soc/sof/sof-audio.c                          |   95 +-
 sound/soc/sof/sof-audio.h                          |   24 +-
 sound/soc/sof/sof-priv.h                           |   12 +
 sound/soc/sof/sof-utils.c                          |   12 +-
 sound/soc/sof/sof-utils.h                          |   11 +-
 sound/soc/sof/topology.c                           |    5 +-
 sound/soc/sprd/sprd-pcm-compress.c                 |    7 +-
 sound/soc/sprd/sprd-pcm-dma.c                      |   10 +-
 sound/soc/sti/uniperif_player.c                    |   29 +-
 sound/soc/sti/uniperif_reader.c                    |   27 +-
 sound/soc/stm/stm32_i2s.c                          |   35 +-
 sound/soc/stm/stm32_sai_sub.c                      |   15 +
 sound/soc/stm/stm32_spdifrx.c                      |    2 +-
 sound/soc/sunxi/sun4i-i2s.c                        |   13 +
 sound/soc/sunxi/sun8i-codec.c                      |   13 +
 sound/soc/tegra/Kconfig                            |   10 +
 sound/soc/tegra/Makefile                           |    2 +
 sound/soc/tegra/tegra20_i2s.c                      |   10 +
 sound/soc/tegra/tegra210_adx.c                     |   12 +-
 sound/soc/tegra/tegra210_adx.h                     |    2 +-
 sound/soc/tegra/tegra210_i2s.c                     |   13 +
 sound/soc/tegra/tegra30_i2s.c                      |   10 +
 sound/soc/tegra/tegra_asoc_machine.c               |    6 +
 sound/soc/tegra/tegra_wm8994.c                     |  175 ++
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
 tools/spi/Makefile                                 |    2 +-
 tools/spi/spidev_test.c                            |  330 ++-
 689 files changed, 34055 insertions(+), 5870 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/airoha,an7581-afe.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/airoha,an7581-wm8960.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/esstech,es9039q2m.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8994.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,shikra-qaif-cpu.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9378-sdw.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/stericsson,ux500-msp-i2s.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,da830-evm-audio.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ux500-mop500.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/ux500-msp.txt
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,pic32mzda-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
 create mode 100644 drivers/spi/spi-rtk-nor.c
 create mode 100644 include/sound/sdca_class.h
 create mode 100644 sound/soc/amd/acp/acp-mach-common.h
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
 create mode 100644 sound/soc/intel/boards/cht_rt5677.c
 create mode 100644 sound/soc/mediatek/an7581/Makefile
 create mode 100644 sound/soc/mediatek/an7581/an7581-afe-common.h
 create mode 100644 sound/soc/mediatek/an7581/an7581-afe-pcm.c
 create mode 100644 sound/soc/mediatek/an7581/an7581-dai-etdm.c
 create mode 100644 sound/soc/mediatek/an7581/an7581-reg.h
 create mode 100644 sound/soc/mediatek/an7581/an7581-wm8960.c
 create mode 100644 sound/soc/qcom/qaif-cpu.c
 create mode 100644 sound/soc/qcom/qaif-platform.c
 create mode 100644 sound/soc/qcom/qaif-reg.h
 create mode 100644 sound/soc/qcom/qaif-shikra.c
 create mode 100644 sound/soc/qcom/qaif.h
 delete mode 100644 sound/soc/sdca/sdca_class.h
 create mode 100644 sound/soc/sdw_utils/soc_sdw_senary_amp.c
 create mode 100644 sound/soc/sdw_utils/soc_sdw_senary_dmic.c
 create mode 100644 sound/soc/sdw_utils/soc_sdw_senary_sdca.c
 create mode 100644 sound/soc/sdw_utils/soc_sdw_senary_sdca_jack_common.c
 create mode 100644 sound/soc/soc-internal.h
 create mode 100644 sound/soc/sof/amd/acp7x.h
 create mode 100644 sound/soc/sof/amd/acp_asp_mailbox.c
 rename sound/soc/sof/{compress.c => ipc3-compress.c} (66%)
 create mode 100644 sound/soc/sof/ipc4-compress.c
 create mode 100644 sound/soc/tegra/tegra_wm8994.c
 delete mode 100644 sound/soc/ux500/mop500.c
 delete mode 100644 sound/soc/ux500/mop500_ab8500.c
 delete mode 100644 sound/soc/ux500/mop500_ab8500.h
