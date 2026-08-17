Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F96C5DF70
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:53:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72C8C60258;
	Mon, 17 Aug 2026 18:53:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72C8C60258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786985608;
	bh=Qz8rekctG3t2n1hd2YOTRA754ZSZcwdyX6TunmWtvhg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=IIAmHGk8mOa+Md+W94xy3DHDmTzFudk0o64QbKjHKE5i3WsMZc2xJPGDDFHAttbYj
	 EMk6Hc7rQn8D9q8XyhNGI4C1uTyyRADBjSo6d0zYKTD6v3VlsUsFo4QgfFZHDvNfLN
	 B9VIIMK1LOBvPZBYosu8uRAtPqhudTOqopFTqCYw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A4F9F80600; Mon, 17 Aug 2026 18:52:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D81F7F805F5;
	Mon, 17 Aug 2026 18:52:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B82E5F8047D; Mon, 17 Aug 2026 18:52:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786985560;
	b=LqOgMCQ/MES33rbXaEre1sdq3wTj7zUBVdGQ/T6TZTkB1VOdEyDrJZdmO1znECCCVTZu
	 O6PqnF70XVPP53lT4DMNKUh8rhg1C7EIpGdHKcePaXJyKAR3a4aD69Om17W3EjdBcR+0X
	 +PQnk1Vj1Jbr8TZYQITltBgqMU4HjK+IUzRdWbrTqTIzUiqa8pxNK2MXHpHB9CfuGWUhk
	 opdQdGQHD9EuUEAMYd57HEz/r7lG4GqCScxjrYpdTNn4JH4K6ts2oVEcF04zfCceHQktR
	 2UtJnV/4RgUjbdM5n92a2fQlSZDjIpsIXHo20egsANZru/FKrKtFpQ4OdayIrXWA9Tg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786985560;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=Qz8rekctG3t2n1hd2YOTRA754ZSZcwdyX6TunmWtvhg=;
	b=iMHyPVxxGW2h7/i+/aQl+uKF1qpUc6OrbX8rksf+co4svUg0u2CymLT5qIwHxKsDtFUZ
	 XxCyUZ3noD2vxEp6rHkljDGUoyLytKo2HPngHu+hqBTNhvHDileRqd3IhwvLGkcIWmhS/
	 sORv6asPfsMCxG8leuCR8hxwbrjTvJR81SvnSKiZSPHSO5XtCy6ineegPrusIHDdk/Pvk
	 MsjKcl7u3gFNMOOI3n9GHmcvDr5VFTjRtXXUyns9jrMb9SFE5yIBsVaP+up0jGfZVnWCu
	 Tt83SyUVC2XTxnj5u0EsSwXLFIKQWNbk297QlPN/373BtIFcAGXqZffdQ2zw9bx+pZQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AQpQXyfn;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 79B39F800FA
	for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2026 18:52:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79B39F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AQpQXyfn
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id D4195601DE;
	Mon, 17 Aug 2026 16:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A35F41F000E9;
	Mon, 17 Aug 2026 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786985556;
	bh=VR8gOLff1frgSy/EANb4nx22gE+5q2hcs/fES7hucrs=;
	h=From:To:Cc:Subject:Date;
	b=AQpQXyfnVNpaCoydwIVfTnYVt0ZPvNA82WJTXGNVqDOPat49Z68SCxffkm+JfSS9s
	 NCBBfHU/7HpmVpBUDF9wY6Uk3NGdkbF/asQZkHA5PC4Gy7ihSIYQOieVY6OsxaZ54X
	 TEWtsHitUIb+jx57TqmeyBpPEXTOE9I8KPcZKQPtMKqT3nw1Qq0Bxx9VwGiIzvZ9P3
	 MS/0JUbhgatymETzrdPd3JBp515ryER8thein6vDMXQ6rqiHGXJse6TOJrZhPhlYTG
	 Spu9ZhntxdfVeYb7DKsh8O1ovlg000SCQwXUz2rnx893adoCOmm8g3Y1yfO6u15wgG
	 7bkofIXDEHLjA==
Message-ID: <c95b9b429426c579bc4230e8b2ae489c@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v7.3
Date: Mon, 17 Aug 2026 17:52:14 +0100
Message-ID-Hash: I22X6D6LNO3SOXD2YNWG55NTWISMZRTO
X-Message-ID-Hash: I22X6D6LNO3SOXD2YNWG55NTWISMZRTO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I22X6D6LNO3SOXD2YNWG55NTWISMZRTO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v7.3

for you to fetch changes up to 0c7aeb0f5eceb95b5887bd8e83fef865e5a49a13:

  ASoC: tas2783-sdw: do not treat read-only Controls as writable (2026-08-14 16:20:47 +0100)

----------------------------------------------------------------
ASoC: Updates for v7.3

A very busy release, a combination of a lot of new device work and more
people than usual doing various subsystem wide improvements in the code.
The main subsystem level change is the work Morimoto-san has been doing
to get automatic DAI format selection more widely deployed, and even
that is largely changes in the drivers to enable use of the feature
rather than framework work.

 - Conversions of a lot of drivers to use the automatic DAI format
   selection code from Morimoto-san.
 - Many fixes and code improvements from bui duc phuc and Morimoto-san.
 - Fixes for ordering problems in register default tables from Peter
   Ujfalusi.
 - Changes to use auto-cleanup for firmware to improve robustness from
   Takashi Iwai.
 - Support for firmware on more Awinc devices.
 - Many changes in the Qualcomm driver stack, mostly around new platform
   support.
 - Support for AMD ACP7.B/F, Cirrus Logic CS35L62, Loongson 2K0300,
   Meson GX formatter and interface, Qualcomm LPI MI2S, SM8475 and
   WSA855 and Realtek RT1321 VA1/2 and RT766/7.

----------------------------------------------------------------
Adam Skladowski (2):
      ASoC: dt-bindings: pm8916-wcd-analog-codec: Document pm8950/pm8953
      ASoC: msm8916-wcd-analog: add pm8950 codec

Ajay Kumar Nandam (8):
      ASoC: codecs: lpass-wsa-macro: Switch to PM clock framework for runtime PM
      ASoC: codecs: lpass-va-macro: Switch to PM clock framework for runtime PM
      ASoC: codecs: lpass-wsa-macro: Use devm_clk_hw_register() for MCLK output
      ASoC: codecs: lpass-tx-macro: switch to PM clock framework for runtime PM
      ASoC: codecs: lpass-rx-macro: switch to PM clock framework for runtime PM
      ASoC: codecs: lpass-{tx,rx}-macro: check clk_set_rate() return value
      ASoC: codecs: lpass-wsa-macro: check clk_set_rate() return value
      ASoC: codecs: lpass-va-macro: check clk_set_rate() return value

Andrey Golovko (2):
      ASoC: tas2783-sdw: drop stale regcache on uninitialized re-attach
      ASoC: tas2783-sdw: do not treat read-only Controls as writable

Andy Shevchenko (1):
      ASoC: SOF: Intel: Don't use "proxy" headers

Bard Liao (9):
      ASoC: SOF: add Intel UAOL sof_ipc_dai_type
      ASoC: SOF: Intel: reset spib_addr before disabling SPIB
      ASoC: SOF: Intel: Disable SPIB in non ICCMAX stream
      ASoC: Intel: add snd_soc_acpi_intel_rt712_vb_no_function_topology machine check function
      ASoC: soc-acpi-intel-ptl-match: add machine check for machines can't use function topology
      ASoC: soc-acpi-intel-ptl-match: use function topology by default
      ASoC: soc-acpi-intel-lnl-match: use function topology by default
      ASoC: soc-acpi-intel-arl-match: use function topology by default
      ASoC: soc-acpi-intel-mtl-match: use function topology by default

Bhargav Joshi (1):
      ASoC: dt-bindings: ti,omap4-dmic: Convert to DT schema

Binbin Zhou (9):
      ASoC: loongson: Fix error handling in ACPI property parsing
      ASoC: dt-bindings: loongson,ls2k1000-i2s: Document Loongson-2K0300 compatible
      ASoC: loongson: Add Loongson-2K0300 I2S controller support
      ASoC: dt-bindings: loongson,ls-audio-card: Use common sound card
      ASoC: dt-bindings: loongson,ls-audio-card: Add ctcisz forever pi compatible
      ASoC: loongson: Add Loongson-2K0300 CTCISZ Forever Pi sound card support
      ASoC: dt-bindings: loongson,ls-audio-card: Add ATK-DL2K0300B compatible
      ASoC: loongson: Add headphone jack detection and DAPM routing
      ASoC: es8328: Add DAPM routes from MIC inputs to Mic Bias

Cezary Rojewski (9):
      ASoC: Intel: catpt: Wrap the store firmware-context procedure
      ASoC: Intel: catpt: Drop redundant else-if
      ASoC: Intel: catpt: Drop redundant signature argument
      ASoC: Intel: catpt: Rename module header struct
      ASoC: Intel: catpt: Rename firmware loading functions
      ASoC: Intel: catpt: Streamline wording of offset variables
      ASoC: Intel: catpt: Streamline runtime-variables naming
      ASoC: Intel: catpt: Streamline control-variables naming
      ASoC: Intel: Remove obsolete UAPI headers

Chancel Liu (6):
      ASoC: dt-bindings: wlf,wm8524: Add audio-graph port support
      ASoC: dt-bindings: fsl,micfil: Add audio-graph port support
      ASoC: dt-bindings: dmic-codec: Add audio-graph port support
      ASoC: fsl-asoc-card: Drop mclk management for nau8822
      ASoC: fsl-asoc-card: Move static compatible data to platform data
      ASoC: fsl-asoc-card: Move bound-component setup to late_probe

Charles Keepax (11):
      ASoC: SDCA: Add missing stub for sdca_fdl_free_state()
      ASoC: es9356: Remove unused headers
      ASoC: dt-bindings: cirrus,cs42l43: Add CS42L44 variant
      ASoC: SDCA: Tidy up error message
      ASoC: SDCA: Remove unused dev pointer argument
      ASoC: SDCA: Move HID registration to IRQ time
      ASoC: SDCA: Move HID descriptors to function
      ASoC: SDCA: Update HID DisCo parsing
      ASoC: SDCA: Add missing destroy for HID device
      ASoC: SDCA: Add missing HID kernel doc
      ASoC: SDCA: Pass swft table through sdca_dev_register()

Chen-Yu Tsai (1):
      ASoC: sun4i-codec: Sort sound related #include statements

David Heidelberg (1):
      ASoC: dt-bindings: Convert cirrus,cs35l36 to DT schema

Diogo Ivo (2):
      ASoC: rt5677: Add GPIO .get_direction() callback
      ASoC: rt5677: Enable standalone compilation for generic card use

Dmitry Torokhov (10):
      ASoC: wcd9335: switch to using sleeping variants of gpiod API
      ASoC: ti: omap-twl4030: drop support for platform data
      ASoC: ti: omap-twl4030: use per-device instance of headset jack gpio
      ASoC: tlv320aic32x4: remove global header with platform data
      ASoC: tlv320aic32x4: do not allocate gpio config separately
      ASoC: tlv320aic32x4: consolidate programming functions
      ASoC: tlv320aic32x4: move regmap_config into i2c and spi drivers
      ASoC: tlv320aic32x4: do not make clocks bulk data static
      ASoC: tlv320aic32x4: factor out rate configuration helper
      ASoC: tlv320aic32x4: clean up driver code formatting and logging

Esteban Urrutia (2):
      ASoC: dt-bindings: qcom,sm8250: Add compatible string for SM8475
      ASoC: qcom: sc8280xp: Add support for SM8475

Ethan Tidmore (1):
      ASoC: codecs: ES8389: Remove redundant comparison

Frank Li (1):
      ASoC: dt-bindings: Convert eukrea-tlv320.txt to yaml

Haoxiang Li (4):
      ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure
      AsoC: intel: sst: fix PCI device reference leak on probe failure
      ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
      ASoC: hdac_hdmi: Fix resource cleanup on probe failure

Hector Martin (2):
      ASoC: apple: mca: Do not mark clocks in use for non-providers
      ASoC: apple: mca: Add delay after configuring clock

Hongyang Zhao (3):
      ASoC: dt-bindings: es8316: Add regulator supplies
      ASoC: codecs: es8316: Add regulator support
      ASoC: dt-bindings: es8316: Fix supply property constraints

Ivaylo Dimitrov (2):
      ASoC: cpcap: Remove modem-specific voice call support
      ASoC: codecs: cpcap: set voice DAI format as specified in DT

Jack Yu (1):
      ASoC: rt1320-sdw: Add settings to support more base clock frequency

James Calligeros (1):
      ASoC: apple: mca: increase SERDES reset delay

Jerome Brunet (1):
      ASoC: meson: aiu: make aiu_formatter_i2s_drv static

Jiri Slaby (SUSE) (1):
      ASoC: pm4125: Switch to irq_domain_create_linear()

Jorijn van der Graaf (2):
      ASoC: codecs: aw88261: only check PLL and clock state at power-up
      ASoC: qcom: q6apm: keep the graph start count in sync with the DSP

Julia Lawall (1):
      ASoC: wm8940: drop unneeded semicolon

Julian Braha (1):
      ASoC: codecs: cleanup kconfig indentations

Jyri Sarha (6):
      ASoC: SOF: ipc4-topology: Remove dp_ from all module memory attributes
      ASoC: SOF: ipc4-topology: Fix SOF_TKN_COMP_STACK_BYTES_REQUIREMENT id
      ASoC: SOF: ipc4: Add SOF_IPC4_GLB_CREATE_PIPELINE payload macros and structs
      ASoC: SOF: ipc4-topology: Add payload to pipeline create messages
      ASoC: SOF: ipc4-topology: Fix sof_ipc4_mod_init_ext_dp_memory_data comments
      ASoC: SOF: ipc4-topology: Refactor sof_ipc4_widget_mod_init_msg_payload()

Krzysztof Kozlowski (3):
      ASoC: renesas: adg: Drop redundant NULL check on clk_get and clk_register_fixed_rate
      ASoC: codecs: es9356: Constify regmap_sdw_mbq_cfg
      ASoC: dt-bindings: Correct white-space style

Kuninori Morimoto (69):
      ASoC: codecs: max98090: add missing describe "data" for max98090_set_jack()
      ASoC: au1x: psc-ac97: remove unused chans
      ASoC: sdw_utils: tidyup .count_sidecar
      ASoC: sdw_utils: tidyup asoc_sdw_parse_sdw_endpoints()
      ASoC: mediatek: mt8173-rt5650: tidyup error message
      ASoC: sof: topology: use for_each_card_rtds()
      ASoC: sof: nocodec: tidyup sof_nocodec_bes_setup()
      ASoC: sof: nocodec: tidyup sof_nocodec_setup()
      ASoC: mediatek: mt8365-mt6357: tidyup mach_priv
      ASoC: amd: acp6x-mach: tidyup strange alignment
      ASoC: amd: use .auto_selectable_formats
      ASoC: codecs: pcm*: use .auto_selectable_formats
      ASoC: meson: use .auto_selectable_formats
      ASoC: spacemit: use .auto_selectable_formats
      ASoC: simple-card: move simple_parse_of()
      ASoC: simple-card: merge extra method into simple_parse_of()
      ASoC: audio-graph-card2: Tidyup audio_graph2_parse_of() around error
      ASoC: audio-graph-card: Tidyup audio_graph_parse_of() around error
      ASoC: simple_card_utils: add simple_util_parse_property()
      ASoC: simple_card_utils: add simple_util_parse_aux_devs()
      ASoC: simple-card: tidyup simple_util_parse_xxx() in simple_parse_of()
      ASoC: audio-graph-card: tidyup simple_util_parse_xxx() in audio_graph_parse_of()
      ASoC: audio-graph-card2: tidyup simple_util_parse_xxx() in audio_graph2_parse_of()
      ASoC: simple-card-utils: tidyup simple_util_init_aux_jacks()
      ASoC: simple-card-utils: tidyup simple_util_clean_reference()
      ASoC: generic: Card name parsing should be called after xxx_for_each_link()
      ASoC: amd: acp-sdw-legacy-mach: use &pdev->dev instead of card->dev
      ASoC: amd: acp-sdw-sof-mach: use &pdev->dev instead of card->dev
      ASoC: qcom: common: use dev
      ASoC: qcom: sdm845: remove unused card
      ASoC: qcom: storm: use dev instead of card on storm_parse_of()
      ASoC: mediatek: mt8192-mt6359-rt1015-rt5682: use *dev in mt8192_mt6359_card_set_be_link()
      ASoC: mediatek: common/mtk-dsp-sof-common: use for_each_card_prelinks()
      ASoC: mediatek: mt8196-nau8825: remove unnecessary declaration
      ASoC: mediatek: mt8365-mt6357: remove useless assignment
      ASoC: intel: sof_sdw: use &pdev->dev instead of card->dev
      ASoC: fsl: p1022_ds: add card_to_mdata() macro
      ASoC: fsl: p1022_rdk: add card_to_mdata() macro
      ASoC: meson: axg-card: tidyup not to use card->dev
      ASoC: meson: gx-card: tidyup not to use card->dev
      ASoC: meson: meson-card-utils: tidyup not to use card->dev
      ASoC: atmel: atmel_wm8904: use dev in atmel_asoc_wm8904_dt_init()
      ASoC: ti: omap-hdmi: remove unused *card
      ASoC: ti: tidyup not to use *card on rx51_soc_probe()
      ASoC: ti: ams-delta: use &pdev->dev instead of card->dev
      ASoC: ux500: mop500: tidyup mop500_of_probe() parameter
      ASoC: ux500: mop500_ab8500: tidyup mop500_ab8500_remove()
      ASoC: apple: use .auto_selectable_formats
      ASoC: atmel: use .auto_selectable_formats
      ASoC: au1x: use .auto_selectable_formats
      ASoC: bcm: use .auto_selectable_formats
      ASoC: cirrus: use .auto_selectable_formats
      ASoC: soc-component: move soc_component_field_shift()
      ASoC: soc-component: add snd_soc_component_alloc()
      ASoC: soc-component: add snd_soc_register_component_{c/d}()
      ASoC: soc-component: add snd_soc_component_{set_}name()
      ASoC: soc-component: add snd_soc_component_{set/to}_priv()
      ASoC: intel: avs: use snd_soc_register_component()
      ASoC: intel: avs: probes: use snd_soc_register_component()
      ASoC: intel: catpt: pcm: use snd_soc_register_component()
      ASoC: soc-generic-dmaengine-pcm: use snd_soc_register_component()
      ASoC: soc-topology-test: use snd_soc_register_component()
      ASoC: soc-core: makes snd_soc_component_initialize() / snd_soc_add_component() local
      ASoC: soc-core: remove dev from soc_component_initialize()
      ASoC: codecs: ad1*: use .auto_selectable_formats
      ASoC: codecs: adav80x: use .auto_selectable_formats
      ASoC: codecs: cros_ec_codec: use .auto_selectable_formats
      ASoC: codecs: lochnagar-sc: use .auto_selectable_formats
      ASoC: codecs: madera: use .auto_selectable_formats

Le Qi (1):
      ASoC: qcom: sc8280xp: configure codec sysclk for QCS615

LiangCheng Wang (1):
      ASoC: fsl-asoc-card: defer probe when the CPU DAI device is not ready

Linmao Li (2):
      ASoC: meson: Keep link pointers valid on realloc failure
      ASoC: Intel: avs: da7219: Remove redundant DAI link name allocation

Luca Leonardo Scorcia (1):
      ASoC: dt-bindings: mtk-btcvsd-snd: Convert to DT Schema

Marco Giunta (5):
      ASoC: aw88399: extract shared device library
      ASoC: aw88399: derive channel from I2C address on ACPI systems
      ASoC: aw88399: add per-instance BSTS status bypass flag
      ASoC: aw88399: add firmware reload flag for resume
      ASoC: aw88399: add channel setter for HDA side codec

Marek Szyprowski (1):
      ASoC: samsung: i2s: drop secondary DAI for i2sv7 hardware variant

Mark Brown (75):
      ASoC: fsl: Use guard() for mutex & spin locks
      ASoC: Intel: Convert locking to guard()/scoped_guard()
      ASoC: rt5677: add GPIO get_direction and enable standalone compilation
      ASoC: meson: aiu: align I2S design to the AXG one
      ASoC: sdw_utils: tidyup functions
      ASoC: codecs: ES8389: Modify the ES8389 driver
      ASoC: Fix mixed goto and guard() usage
      ASoC: Add Loongson-2K0300 I2S controller and sound card support
      ASoC: sof: nocodec: tidyup sof_nocodec_xxx_setup()
      ASoC: qcom: lpass: Switch VA/WSA macros to PM clock framework
      ASoC: SOF: amd: add support for ACP7.B/7.F platforms
      ASoC: cs35l3x: drain threaded IRQs before runtime suspend
      ASoC: use .auto_selectable_formats
      ASoC: xilinx: xlnx_i2s: Use dev_err_probe() and drop redundant error handling
      ASoC: cleanup simple-card/audio-graph-card1/2
      ASoC: codecs: lpass-{tx,rx}-macro: switch to PM clock framework
      ASoC: apple: mca: support simultaneous I2S capture on the frontend
      ASoC: simple-card: Fix clang build
      ASoC: SOF: Intel: reset spib_addr in stream cleanup
      ASoC: codecs: Use guard() for mutex & spin lock - part 1
      ASoC: tegra: Simplify error handling
      ASoC: cs35l56: Add support for CS35L62
      ASoC: codecs: lpass-{wsa,va}-macro: check clk_set_rate() return value
      ASoC: amd: preparation for Card capsuling
      ASoC: qcom: preparation for Card capsuling
      ALSA: hda: Add AW88399 HDA side codec driver for Lenovo Legion
      ASoC: mediatek: preparation for Card capsuling
      ASoC: fsl: add card_to_mdata() macro
      ASoC: codecs: Use guard() for mutex & spin locks - part 2
      ASoC: meson: preparation for Card capsuling
      ASoC: soc-acpi-intel-matchs: use function topology by default
      ASoC: qcom: qdsp6: Add MI2S clock control
      ASoC: remove conditional returns with no effect
      ASoC: meson: aiu-encoder-i2s: improve hw constraints checks
      ASoC: Use named initializers for platform_device_id arrays
      ASoC: dt-bindings: qcom,sm8250: Add Hawi sound card
      ASoC: ti: omap-twl4030: drop support for platform data
      ASoC: ti: Improve probe error handling
      ASoC: sunxi: Simplify error handling
      ASoC: ti: preparation for Card capsuling
      ASoC: stm: Drop redundant error message
      ASoC: ux500: preparation for Card capsuling
      ASoC: starfive: Simplify probe error handling
      ASoC: SM8475 sndcard support
      ASoC: Intel: catpt: Code cleanup and renames
      ASoC: qcom: audioreach: support WSA speakers only on WSA2
      ASoC: SOF: ipc4-topology: Update the memory data building
      ASoC: codecs: Use guard() for mutex & spin locks - part 3
      ASoC: SOF: Intel: hda/mtl: Handle powered on DSP on boot
      ASoC: SOF: Intel: Handle ACE2+ link DMA allocation restrictions
      Subject: [PATCH v6 0/7] ASoC: qcom and pinctrl: add LPASS LPR voting and Hawi LPASS LPI support
      ASoC: Add support for the Qualcomm WSA885X Stereo smart speaker amplifier
      SDM660 sound card and internal MI2S support
      ASoC: qcom: sc8280xp: add Monaco/Monza (MAX98090) support on QCS8275
      ASoC: use .auto_selectable_formats
      ASoC: spear: Update the SPDIF drivers for current ASoC APIs
      Merge remote-tracking branch 'asoc/for-7.3' into asoc-next
      ASoC: SOF: ipc4-topology: Pipeline params improvements
      ASoC: qcom: add AudioReach TDM backend support
      ASoC: add and use new snd_soc_register_component()
      ASoC: cpcap: Use standard ASoC DAI link configuration for voice
      ASoC: Rework the SDCA HID code
      ASoC: Realtek codecs: sort the reg_defaults tables
      ASoC: TI codecs: sort the reg_defaults tables
      ASoC: NXP/Freescale: sort the reg_defaults tables
      ASoC: tegra: sort the reg_defaults tables
      ASoC: codec drivers: sort the reg_defaults tables
      ASoC: Use auto-cleanup for firmware loading
      ASoC: dt-bindings: qcom,sm8250: Add Maili sound card
      ASoC: amd: enable audio on HP OmniBook X Flip 14
      ASoC: es8316: Add regulator support
      ASoC: mxs: Improve probe error handling
      ASoC: rockchip: Simplify probe error handling
      ASoC: fsl-asoc-card: Restructure to support deferrable card binding
      ASoC: cs35l56: Switch to using the IRQ from the SoundWire core

Markus Elfring (1):
      ASoC: SOF: topology: Use more common error handling code in sof_link_load()

Martin Povišer (4):
      ASoC: apple: mca: Separate data & clock port setup
      ASoC: apple: mca: Factor out mca_be_get_fe
      ASoC: apple: mca: Support FEs being clock consumers
      ASoC: apple: mca: Support capture on multiples BEs

Mert Seftali (1):
      ASoC: SOF: ipc4-topology: Return error for invalid number of formats

Mohammad Rafi Shaik (3):
      ASoC: dt-bindings: qcom,q6apm-lpass-dais: Document DAI subnode
      ASoC: qcom: q6apm-lpass-dais: Add MI2S clock control
      ASoC: qcom: sc8280xp: enhance machine driver for board-specific config

Narasimharao Vadlamudi (1):
      ASoC: renesas: fsi: Propagate platform_get_irq() errors

Neil Armstrong (5):
      ASoC: qcom: sc8280xp: allow setting m2is clocks for SM8[456]50 boards
      ASoC: qcom: audioreach: compute active channel maps from channel_map
      ASoC: dt-bindings: qcom,sm8250: Add Ayaneo Pocket S2 sound card
      ASoC: qcom: sc8280xp: add Ayaneo Pocket S2 card with special WSA channel mapping
      ASoC: qcom: qdsp6: q6prm: add the missing MCLK clock IDs

Nickolay Goppen (1):
      ASoC: dt-bindings: qcom,sm8250: add compatible for sdm660

Niranjan H Y (2):
      ASoC: tac5xx2-sdw: add rev_id 0x30 support
      ASoC: tac5xx2-sdw: remove firmware check restriction

Pengpeng Hou (41):
      ASoC: sma1303: remove fault-check sysfs group on remove
      ASoC: tlv320aic26: remove keyclick sysfs file
      ASoC: codecs: max98390: Propagate regcache_sync() errors
      ASoC: codecs: cs42l42-sdw: Propagate regcache_sync() errors
      ASoC: codecs: max98927: Propagate regcache_sync() errors
      ASoC: codecs: uda1342: Leave cache-only mode before syncing
      ASoC: codecs: max98363: Propagate regcache_sync() errors
      ASoC: codecs: max98373-sdw: Propagate regcache_sync() errors
      ASoC: codecs: pm4125-sdw: Propagate regcache_sync() errors
      ASoC: codecs: rt5645: Propagate regcache_sync() errors
      ASoC: codecs: wcd937x-sdw: Propagate regcache_sync() errors
      ASoC: codecs: wcd939x-sdw: Propagate regcache_sync() errors
      ASoC: codecs: wsa883x: Propagate regcache_sync() errors
      ASoC: codecs: wsa884x: Propagate regcache_sync() errors
      ASoC: codecs: rt712-sdca-dmic: Propagate regcache_sync() errors
      ASoC: codecs: rt712-sdca-sdw: Propagate regcache_sync() errors
      ASoC: codecs: rt721-sdca-sdw: Propagate regcache_sync() errors
      ASoC: codecs: rt1017-sdca-sdw: Propagate regcache_sync() errors
      ASoC: codecs: rt1316-sdw: Propagate regcache_sync() errors
      ASoC: codecs: rt722-sdca-sdw: Propagate regcache_sync() errors
      ASoC: codecs: wsa881x: Propagate regcache_sync() errors
      ASoC: codecs: rt5514: Propagate bias restore errors
      ASoC: codecs: lpass-rx-macro: Propagate regcache_sync() errors
      ASoC: codecs: lpass-tx-macro: Propagate regcache_sync() errors
      ASoC: codecs: max98373: Propagate regcache_sync() errors
      ASoC: codecs: max98388: Propagate regcache_sync() errors
      ASoC: codecs: rt1318-sdw: Propagate regcache_sync() errors
      ASoC: codecs: rt9120: Propagate regcache_sync() errors
      ASoC: codecs: tas2552: Propagate regcache_sync() errors
      ASoC: codecs: tas2783-sdw: Propagate regcache_sync() errors
      ASoC: codecs: wcd938x-sdw: Propagate regcache_sync() errors
      ASoC: codecs: cs35l32: Propagate regcache_sync() errors
      ASoC: codecs: wm2200: Propagate regcache_sync() errors
      ASoC: codecs: wm5100: Propagate regcache_sync() errors
      ASoC: codecs: wm8962: Propagate regcache_sync() errors
      ASoC: codecs: cs4349: Propagate regcache_sync() errors
      ASoC: codecs: rt1320-sdw: Propagate regcache_sync() errors
      ASoC: codecs: rt5682-sdw: Propagate regcache_sync() errors
      ASoC: codecs: max98396: Unwind supplies on resume failure
      ASoC: codecs: max98090: Propagate runtime regcache_sync() errors
      ASoC: SOF: validate topology volume range before allocation

Peter Ujfalusi (46):
      ASoC: SOF: ipc4: Add decoder for RESOURCE_EVENT notifications from firmware
      ASoC: SOF: Intel: hda-stream: clear hstream->running flag in hw_params
      ASoC: SOF: Intel: hda: Power down DSP if it is left enabled in pre_fw_run()
      ASoC: SOF: Intel: mtl: Power down DSP if it is left enabled in pre_fw_run()
      ASoC: SOF: Intel: hda: Fold mlink enumeration into hda_dsp_ctrl_init_chip()
      ASoC: SOF: Intel: hda: Keep non-alt mlinks powered at probe on ACE2+
      ASoC: SOF: Intel: hda: Remove unused hda_bus_ml_put_all()
      ASoC: SOF: Intel: hda: Avoid ACE2+ link DMA stream allocation hazards
      ASoC: SOF: ipc4-topology: Store the params change between input/output of a module
      ASoC: SOF: ipc4-topology: Correct the process module's output lookup
      ASoC: SOF: ipc4-topology: Update the pipeline_params of prepared modules
      ASoC: adau1761: sort the register default table
      ASoC: rt274: sort the register default table
      ASoC: rt286: sort the register default table
      ASoC: rt298: sort the register default table
      ASoC: rt700: drop duplicate reg_default entry
      ASoC: rt700: sort the register default table
      ASoC: rt711: sort the register default table
      ASoC: rt711-sdca: sort the register default tables
      ASoC: rt712-sdca-dmic: sort the register default table
      ASoC: rt712-sdca-sdw: sort the register default table
      ASoC: rt715: sort the register default table
      ASoC: rt715-sdca: drop duplicate reg_default entries
      ASoC: rt715-sdca: sort the register default tables
      ASoC: rt721-sdca-sdw: sort the register default table
      ASoC: rt1017-sdca-sdw: sort the register default table
      ASoC: rt1316-sdw: sort the register default table
      ASoC: rt1318: sort the register default table
      ASoC: rt1318-sdw: sort the register default table
      ASoC: pm4125-sdw: sort the register default table
      ASoC: tas2783-sdw: drop duplicate reg_default entry
      ASoC: tas2783-sdw: sort the register default table
      ASoC: pcm512x: sort the register default table
      ASoC: tas2552: sort the register default table
      ASoC: tas2764: sort the register default table
      ASoC: tas2780: sort the register default table
      ASoC: tas675x: sort the register default table
      ASoC: sgtl5000: sort the register default table
      ASoC: fsl_easrc: sort the register default table
      ASoC: tegra210_i2s: sort the register default table
      ASoC: tegra210_i2s: sort the Tegra264 register default table
      ASoC: tegra210_mixer: sort the register default table
      ASoC: ml26124: sort the register default table
      ASoC: cx2072x: sort the register default table
      ASoC: max9860: sort the register default table
      ASoC: sti-sas: sort the register default table

Prasad Kumpatla (17):
      ASoC: qcom: qdsp6: Remove unused Q6AFE_MAX_CLK_ID define
      ASoC: dt-bindings: qcom,sm8250: Add Hawi sound card
      ASoC: qcom: sc8280xp: Add support for Hawi
      ASoC: dt-bindings: qcom: add LPASS LPR vote clock ID
      ASoC: qcom: qdsp6: Increase Q6DSP_MAX_CLK_ID for LPASS LPR vote clock
      ASoC: qcom: q6prm: add support for LPASS LPR resource voting
      ASoC: dt-bindings: qcom,wsa8855: add Qualcomm WSA8855 speaker amplifier
      ASoC: codecs: add Qualcomm WSA885X codec driver
      ASoC: qcom: qdsp6: add topology-driven Audio IF support
      ASoC: qcom: q6apm-lpass-dais: add TDM DAI operations
      dt-bindings: sound: qcom,q6dsp-lpass-ports: add Audio IF clocks
      ASoC: qcom: q6prm: add Audio IF clock IDs
      dt-bindings: sound: qcom,sm8250: allow TDM slot properties
      ASoC: qcom: common: add DAI-node TDM slot helpers
      ASoC: qcom: sc8280xp: add TDM hw_params support
      ASoC: dt-bindings: qcom,sm8250: Add Maili sound card
      ASoC: qcom: sc8280xp: Add Maili sound card support

Randy Dunlap (12):
      ASoC: SOF: don't use "/**" for non-kernel-doc comments
      ASoC: SOF: ipc4-topology: repair struct kernel-doc comments
      ASoC: codecs: NeoFidelity: repair the kernel-doc format
      ASoC: fsl_asrc: avoid kernel-doc warnings
      ASoC: fsl-dma: fix all kernel-doc warnings
      ASoC: fsl_easrc: use struct keyword on structs
      ASoC: fsl: mpc5200_psc_i2s: avoid kernel-doc warnings
      ASoC: uniphier: don't use "/**" for non-kernel-doc comment
      ASoC: SDCA: correct enum names and add a missing struct field
      ASoC: soc-acpi: fix all kernel-doc warnings
      ASoC: qcom: audioreach: use C-style "/*" comment
      ASoC: wm8904: don't use "/**" for non-kernel-doc comments

Richard Acayan (11):
      ASoC: dt-bindings: qcom: q6dsp: add support for lpi mi2s ports 5-6
      ASoC: dt-bindings: pm8916-analog-codec: Add PM660L compatible
      ASoC: dt-bindings: msm8916-digital-codec: Add SDM660 compatible
      ASoC: qdsp6: q6dsp-lpass-ports: add support for lpi mi2s ports 5-6
      ASoC: qdsp6: q6afe: add internal mi2s support
      ASoC: qdsp6: q6afe-dai: add internal mi2s support
      ASoC: qdsp6: q6routing: add lpi mi2s support
      ASoC: qdsp6: common: support headphone jacks connected to lpi mi2s
      ASoC: qcom: sm8250: add support for LPI_MI2S_RX_0 and LPI_MI2S_TX_3
      ASoC: qcom: sm8250: add SDM660 compatible
      ASoC: msm8916-wcd-analog: add quirk for cajon 2.0

Richard Fitzgerald (7):
      ASoC: cs35l56: Remove unnecessary goto in cs35l56_runtime_resume_common()
      ASoC: cs35l56: Sort table of sdw_device_id
      firmware: cs_dsp: Fix mock register default typo in KUnit test
      ASoC: cs35l56: Request IRQ in cs35l56_common_probe()
      ASoC: cs35l56: Move cs35l56_irq_request() after cs35l56_irq()
      soundwire: bus_type: Create IRQ mapping before calling driver probe()
      ASoC: cs35l56: Use IRQ provided by the SoundWire core

Rosen Penev (9):
      ASoC: mediatek: mt2701: add COMPILE_TEST
      ASoC: fsl: mpc5200_dma: use platform helpers and devm cleanup
      ASoC: fsl: dma: use platform helpers and devm cleanup
      ASoC: amd: acp: Use pcim_iomap_region() in acp-pci
      ASoC: xilinx: replace OF with device handlers
      ASoC: amd: acp: return irq error directly
      ASoC: xilinx: formatter_pcm: fix stream_data leak on open error
      ASoC: mediatek: mt8365: use devm_platform_ioremap_resource helpers
      ASoC: amd: acp: pass audio_drv_data to dma_irq_handler

Runyu Xiao (3):
      ASoC: rt700-sdw: always drain jack work on remove
      ASoC: cs35l33: drain threaded IRQ before runtime suspend
      ASoC: cs35l34: drain threaded IRQ before runtime suspend

Sang-Heon Jeon (5):
      ASoC: remove conditional return with no effect
      ASoC: amd: acp: remove conditional return with no effect
      ASoC: Intel: atom: remove conditional return with no effect
      ASoC: samsung: smdk_spdif: remove conditional return with no effect
      ASoC: SOF: Intel: remove conditional return with no effect

Seppo Ingalsuo (1):
      ASoC: dapm: Add encoder and decoder widget types to kcontrol handling

Shenghao Ding (4):
      ASoC: tas2781: Optimize calibration to avoid full device reboot after calibration
      ASoC: tas2781: add capture_profile_id field and update the tuning_switch function
      ASoC: tas2781: Fix compiling warning for tasdevice_set_capture_profile_id()
      ASoC: tas2781: Refactor calibration start kcontrol creation to separate helper

Shengjiu Wang (2):
      ASoC: fsl_audmix: rework runtime PM handling in probe
      ASoC: fsl_easrc: fix missing return on success in runtime_resume

Shuming Fan (6):
      ASoC: rt1321: move DSP status checking into a helper function
      ASoC: rt1321: add support for rt1321 VA1/VA2
      ASoC: SDCA: export sdca_find_entity_by_label() helper
      ASoC: SDCA: export sdca_asoc_populate_rate_format() helper
      ASoC: rt722: reinitialize rt722_sdca_jack_init() after reset
      ASoC: rt766: add RT766/RT767 SDCA driver

Srinivas Kandagatla (3):
      ASoC: qcom: sc8280xp: tolerate -ENOTSUPP from codec set_sysclk
      ASoC: qcom: sc8280xp: rename snd_soc_common to qcom_snd_soc_common
      ASoC: qcom: sc8280xp: add monaco/monza controls for qcs8275

Stefan Binding (2):
      ASoC: cs35l56: Add support for CS35L62 for SoundWire
      ASoC: sdw_utils: Add codec info for CS35L62

Takashi Iwai (32):
      ASoC: sdw_utils: Use auto-cleanup for put_device()
      ASoC: aw87390: Use auto-cleanup for firmware loading
      ASoC: aw88081: Use auto-cleanup for firmware loading
      ASoC: aw88166: Use auto-cleanup for firmware loading
      ASoC: aw88261: Use auto-cleanup for firmware loading
      ASoC: aw88395: Use auto-cleanup for firmware loading
      ASoC: aw88399: Use auto-cleanup for firmware loading
      ASoC: fs-amp-lib: Use auto-cleanup for firmware loading
      ASoC: hdac_hda: Use auto-cleanup for firmware loading
      ASoC: max98390: Use auto-cleanup for firmware loading
      ASoC: ntpfw: Use auto-cleanup for firmware loading
      ASoC: pcm6240: Use auto-cleanup for firmware loading
      ASoC: peb2466: Use auto-cleanup for firmware loading
      ASoC: rt1320-sdw: Use auto-cleanup for firmware loading
      ASoC: rt5575: Use auto-cleanup for firmware loading
      ASoC: rt5677: Use auto-cleanup for firmware loading
      ASoC: rt722-sdca: Use auto-cleanup for firmware loading
      ASoC: sigmadsp: se auto-cleanup for firmware loading
      ASoC: sma1307: Use auto-cleanup for firmware loading
      ASoC: tas2781: Use auto-cleanup for firmware loading
      ASoC: tas5805m: Use auto-cleanup for firmware loading
      ASoC: tlv320aic31xx: Use auto-cleanup for firmware loading
      ASoC: wm0010: Use auto-cleanup for firmware loading
      ASoC: wm2000: Use auto-cleanup for firmware loading
      ASoC: zl38060: Use auto-cleanup for firmware loading
      ASoC: fsl: Use auto-cleanup for firmware loading
      ASoC: Intel: avs: Use auto-cleanup for firmware loading
      ASoC: Intel: catpt: Use auto-cleanup for firmware loading
      ASoC: qcom: Use auto-cleanup for firmware loading
      ASoC: renesas: Use auto-cleanup for firmware loading
      ASoC: SDCA: Use auto-cleanup for firmware loading
      ASoC: SOF: Use auto-cleanup for firmware loading

Troy Mitchell (2):
      ASoC: spacemit: rename clock inputs to match binding
      ASoC: dt-bindings: sound: spacemit,k1-i2s: allow 6 clocks for K3 i2s1

Uwe Kleine-König (The Capable Hub) (6):
      ASoC: codecs: mt6357: Drop unused assignment of platform_device_id driver data
      ASoC: renesas: fsi: Drop platform probing metadata
      ASoC: amd: acp: Use named initializers for platform_device_id arrays
      ASoC: amd: acp: Unify code style for platform_device_id array
      ASoC: Use named initializers for platform_device_id arrays
      ASOC: Unify code style for platform_device_id arrays

Valerio Setti (8):
      ASoC: meson: gx: add gx-formatter and gx-interface
      ASoC: meson: aiu-encoder-i2s: prepare for multiple streams
      ASoC: meson: aiu: introduce I2S output formatter
      ASoC: meson: aiu: use aiu-formatter-i2s to format I2S output data
      ASoC: meson: aiu-formatter-i2s: remove pipeline reset from prepare
      ASoC: meson: aiu-encoder-i2s: fix bs quirk incompatibility check
      ASoC: meson: aiu-encoder-i2s: reflect bs quirk in hw constraints
      ASoC: meson: aiu-encoder-i2s: use the core symmetric_rate handling

Vijendar Mukunda (17):
      ASoC: amd: acp: add ACPI machine table for ACP7.B/7.F SOF driver
      ASoC: SOF: amd: add base platform support for ACP7.B/7.F
      ASoC: SOF: amd: mask ACP7x PGFSM status poll
      ASoC: SOF: amd: refactor SW1 I2S error reason clear in acp_irq_handler
      ASoC: SOF: amd: add ACP7x probe and remove
      ASoC: SOF: amd: add ACP7x IRQ handler for DSP IPC
      ASoC: SOF: amd: extend signed firmware pre-run for ACP7x
      ASoC: SOF: amd: require full ACP header for ACP7 signed firmware
      ASoC: SOF: amd: validate SizeFWSigned before signed FW length on ACP7x
      ASoC: SOF: amd: add post-firmware-run delay for ACP7x
      ASoC: SOF: amd: extend configure_and_run_sha_dma for ACPI signed FW flag
      ASoC: SOF: amd: wire signed firmware load callback for ACP7x via ACPI
      ASoC: SOF: amd: load ACP7.B/7.F signed data firmware to SRAM
      ASoC: SOF: amd: add ACP I2S format field and topology token
      ASoC: SOF: amd: add ACP7x I2S DAI type and topology support
      ASoC: SOF: amd: add system and runtime PM ops for ACP7x
      ASoC: SOF: amd: add missing blank line between Kconfig entries

Ville Saarinen (2):
      ASoC: amd: acp-config: force SoundWire probe on HP OmniBook X Flip 14
      ASoC: amd: acp70: add HP OmniBook X Flip 14 SoundWire machine

Vladimir Lypak (1):
      ASoC: msm8916-wcd-analog: add pm8953 codec

WenTao Liang (1):
      ASoC: samsung: aries_audio_probe: double of_node_put due to direct assignment without of_node_get

Yu-Hsuan Hsu (1):
      ASoC: SOF: Use high-priority workqueue for PCM period elapsed

Zhang Yi (6):
      ASoC: codecs: ES8389: Modify volatile_register
      ASoC: codecs: ES8389: Fix the issue about mclk_src
      ASoC: codecs: ES8389: Modify the clock table
      ASoC: codecs: ES8389: Modify the initial configuration
      ASoC: codecs: ES8389: Add private members about HPF
      ASoC: codecs: ES8389: Add INPUTL MUX and INPUTR MUX

bui duc phuc (165):
      ASoC: meson: Use dev_err_probe() for device reset failures
      ASoC: fsl_asrc: Use guard() for spin locks
      ASoC: fsl_audmix: Use guard() for spin locks
      ASoC: fsl_easrc: Use guard() for spin locks
      ASoC: fsl_esai: Use guard() for spin locks
      ASoC: fsl_spdif: Use guard() for spin locks
      ASoC: fsl_ssi: Use guard() for mutex locks
      ASoC: fsl_xcvr: Use guard() for spin locks
      ASoC: imx-audio-rpmsg: Use guard() for spin locks
      ASoC: fsl_rpmsg: Use guard() for mutex & spin locks
      ASoC: fsl: mpc5200_dma: Use guard() for spin locks
      ASoC: fsl: mpc5200_psc_ac97: Use guard() for mutex locks
      ASoC: Intel: avs: Use guard() for locking
      ASoC: Intel: avs: Use scoped_guard() for scoped locking
      ASoC: intel: atom: Use __free(kfree) for stream pointer
      ASoC: Intel: atom: Use guard() for locking
      ASoC: Intel: atom: Use scoped_guard() for scoped locking
      ASoC: samsung: i2s: Avoid mixing goto with guard()
      ASoC: ti: j721e-evm: Avoid mixing goto with guard()
      ASoC: samsung: spdif: Preserve the original clock acquisition error
      ASoC: samsung: i2s: Use dev_err_probe() for iis clock error
      ASoC: xtensa: Use dev_err_probe() and drop redundant error handling
      ASoC: xilinx: xlnx_i2s: Use dev_err_probe() and drop redundant error handling
      ASoC: xilinx: xlnx_spdif: Preserve devm_request_irq() error codes
      ASoC: xilinx: xlnx_spdif: Use dev_err_probe() and drop redundant error handling
      ASoC: codecs: ab8500: Use guard() for mutex locks
      ASoC: codecs: ak4613: Use guard() for mutex locks
      ASoC: codecs: arizona-jack: Use guard() cleanup helpers
      ASoC: codecs: arizona: Use guard() for mutex locks
      ASoC: codecs: aw87390: Use guard() for mutex locks
      ASoC: codecs: aw88081: Use guard() for mutex locks
      ASoC: codecs: aw88166: Use guard() for mutex locks
      ASoC: codecs: aw88261: Use guard() for mutex locks
      ASoC: codecs: aw88395: Use guard() for mutex locks
      ASoC: codecs: aw88399: Use guard() for mutex locks
      ASoC: codecs: cros_ec_codec: Use guard() for mutex locks
      ASoC: codecs: cs-amp-lib: Use guard() for mutex locks
      ASoC: codecs: cs35l56: Use guard() and PM runtime scope helpers
      ASoC: codecs: cs42l42: Use guard() cleanup helpers
      ASoC: codecs: cs42l43: Use guard() and PM runtime scope helpers
      ASoC: codecs: cs42l84: Use guard() for mutex locks
      ASoC: codecs: cs43130: Use guard() for mutex locks
      ASoC: codecs: cs47l15: Use guard() for mutex locks
      ASoC: codecs: cs47l35: Use guard() for mutex locks
      ASoC: codecs: cs47l85: Use guard() for mutex locks
      ASoC: codecs: cs47l90: Use guard() for mutex locks
      ASoC: codecs: cs47l92: Use guard() for mutex locks
      ASoC: codecs: cs48l32: Use guard() for mutex locks
      ASoC: codecs: cx2072x: Use guard() for mutex locks
      ASoC: tegra: tegra20_das: Use dev_err_probe() for error handling
      ASoC: tegra: tegra210_adx: Return the original error directly
      ASoC: tegra: tegra210_amx: Return the original error directly
      ASoC: tegra: tegra210: Use devm_clk_get_optional() for sync_input clock
      ASoC: uniphier: Drop redundant error messages in probe
      ASoC: codecs: da7213: Use guard() for mutex locks
      ASoC: codecs: da7219: Use guard() for mutex locks
      ASoC: codecs: es8316: Use guard() for mutex locks
      ASoC: codecs: es8326: Use guard() for mutex locks
      ASoC: codecs: es9356: Use guard() for mutex locks
      ASoC: codecs: fs210x: Use guard() for mutex locks
      ASoC: codecs: hdac_hdmi: Use guard() for mutex locks
      ASoC: codecs: hdmi-codec: Use guard() for mutex locks
      ASoC: codecs: idt821034: Use guard() for mutex locks
      ASoC: codecs: lpass-macro: Use guard() for mutex locks
      ASoC: codecs: madera: Use guard() for mutex locks
      ASoC: codecs: max98095: Use guard() for mutex locks
      ASoC: codecs: mt6359-accdet: Use guard() for mutex locks
      ASoC: codecs: pcm512x: Use guard() for mutex locks
      ASoC: codecs: pcm6240: Use guard() for mutex locks
      ASoC: codecs: peb2466: Use guard() for mutex locks
      ASoC: codecs: rt5514-spi: Use guard() for mutex locks
      ASoC: codecs: rt5645: Use guard() for mutex locks
      ASoC: codecs: rt5665: Use guard() for mutex locks
      ASoC: codecs: rt5668: Use guard() for mutex locks
      ASoC: codecs: rt5677: Use guard() for mutex locks
      ASoC: codecs: rt5682: Use guard() for mutex locks
      ASoC: codecs: rt700: Use guard() for mutex locks
      ASoC: codecs: rt711: Use guard() for mutex locks
      ASoC: codecs: rt712-sdca-sdw: Simplify regcache error handling in resume
      ASoC: codecs: rt712: Use guard() for mutex locks
      ASoC: codecs: rt721-sdca-sdw: Simplify regcache error handling in resume
      ASoC: codecs: rt721: Use guard() for mutex locks
      ASoC: codecs: rt722: Use guard() for mutex locks
      ASoC: soc-generic-dmaengine: Handle DMA channel request failures correctly
      ASoC: ti: ams-delta: Use dev_err_probe() for error handling
      ASoC: ti: davinci-evm: Use dev_err_probe() for error handling
      ASoC: ti: j721e-evm: Return the original error from card name parsing
      ASoC: ti: omap-abe-twl6040: Preserve error code and drop redundant log
      ASoC: ti: omap-abe-twl6040: Use dev_err_probe() for error handling
      ASoC: ti: omap-dmic: Use dev_err_probe() for error handling
      ASoC: ti: omap-hdmi: Use dev_err_probe() for error handling
      ASoC: ti: omap-twl4030: Return the original error code
      ASoC: ti: omap-twl4030: Use dev_err_probe() for error handling
      ASoC: ti: rx51: Use dev_err_probe() for error handling
      ASoC: sunxi: sun4i-codec: Use dev_err_probe() for probe error handling
      ASoC: sunxi: sun4i-codec: Drop redundant error messages
      ASoC: sunxi: sun4i-i2s: Use dev_err_probe() for probe error handling
      ASoC: sunxi: sun4i-spdif: Use dev_err_probe() for probe error handling
      ASoC: sunxi: sun50i-codec-analog: Improve probe error handling
      ASoC: sunxi: sun8i-codec-analog: Improve probe error handling
      ASoC: stm: stm32_adfsdm: Drop redundant error message
      ASoC: stm: stm32_i2s: Drop redundant error messages
      ASoC: stm: stm32_sai_sub: Drop redundant error messages
      ASoC: stm: stm32_spdifrx: Drop redundant error messages
      ASoC: starfive: jh7110-pwmdac: Remove unnecessary goto
      ASoC: starfive: jh7110-pwmdac: Drop redundant error messages
      ASoC: starfive: jh7110_tdm: Remove unnecessary goto
      ASoC: starfive: jh7110_tdm: Drop redundant error messages
      ASoC: sprd: sprd-mcdt: Drop redundant error messages
      ASoC: sprd: sprd-pcm-dma: Drop redundant error messages
      ASoC: codecs: sigmadsp: Use guard() for mutex locks
      ASoC: codecs: sta350: Use guard() for mutex locks
      ASoC: codecs: sta32x: Use guard() for mutex locks
      ASoC: codecs: tas2781: Use guard() for mutex locks
      ASoC: codecs: tas2783: Use guard() for mutex locks
      ASoC: codecs: tas5805m: Use guard() for mutex locks
      ASoC: codecs: tlv320dac33: Use guard() for mutex & spin locks
      ASoC: codecs: tscs42xx: Use guard() for mutex locks
      ASoC: codecs: tscs454: Use guard() for mutex locks
      ASoC: codecs: twl6040: Use guard() for mutex locks
      ASoC: codecs: wcd934x: Use guard() for mutex locks
      ASoC: codecs: wcd937x: Use guard() for mutex locks
      ASoC: codecs: wcd938x: Use guard() for mutex locks
      ASoC: codecs: wcd939x: Use guard() for mutex locks
      ASoC: codecs: wm0010: Use guard() for mutex & spin locks
      ASoC: codecs: wm2000: Use guard() for mutex locks
      ASoC: codecs: wm5102: Use guard() for mutex locks
      ASoC: codecs: wm8731: Use guard() for mutex locks
      ASoC: codecs: wm8903: Use guard() for mutex locks
      ASoC: codecs: wm8958: Use guard() for mutex locks
      ASoC: codecs: wm8962: Use guard() for mutex locks
      ASoC: codecs: wm8994: Use guard() for mutex locks
      ASoC: codecs: wm971x: Use guard() for mutex locks
      ASoC: codecs: wm_adsp: Use guard() for mutex locks
      ASoC: codecs: wsa88xx: Use guard() for mutex locks
      ASoC: spear: spdif_in: Drop redundant error messages
      ASoC: spear: spdif_in: Switch to snd_soc_dai_dma_data_set_capture()
      ASoC: spear: spdif_in: Move DAI probe callback to snd_soc_dai_ops
      ASoC: spear: spdif_out: Move DAI probe callback to snd_soc_dai_ops
      ASoC: spacemit: Drop redundant error messages
      ASoC: sophgo: Drop redundant error messages
      ASoC: sophgo: remove unneeded devm_kmemdup() for DAI driver
      ASoC: dwc: Propagate -EPROBE_DEFER from IRQ lookup
      ASoC: Intel: KMB: Propagate -EPROBE_DEFER from IRQ lookup
      ASoC: ti: omap-twl4030: Check for missing card name after parsing
      ASoC: pxa: Use devm_clk_get_optional() for extclk clock
      ASoC: pxa: Drop redundant probe error messages
      ASoC: mxs-saif: Use dev_err_probe() for error handling
      ASoC: mxs-saif: Drop redundant probe error messages
      ASoC: mxs-sgtl5000: Drop redundant probe error messages
      ASoC: spacemit: advertise only DMA-backed DAI streams
      ASoC: rockchip: rk3288_hdmi_analog: Drop redundant probe error messages
      ASoC: rockchip: rk3288_hdmi_analog: Use dev_err_probe() for error handling
      ASoC: rockchip: rockchip_i2s: Use dev_err_probe() for error handling
      ASoC: rockchip: rockchip_i2s: Drop redundant probe error messages
      ASoC: rockchip: rockchip_i2s: Propagate -EPROBE_DEFER from devm_pinctrl_get()
      ASoC: rockchip: i2s-tdm: Inline PTR_ERR() in dev_err_probe()
      ASoC: rockchip: i2s-tdm: Drop redundant probe error messages
      ASoC: rockchip: rockchip_max98090: Drop redundant probe error messages
      ASoC: rockchip: rockchip_pdm: Drop redundant probe error messages
      ASoC: rockchip: rockchip_rt5645: Drop redundant probe error messages
      ASoC: rockchip: rockchip_sai: Propagate -EPROBE_DEFER from IRQ lookup
      ASoC: rockchip: rockchip_sai: Return the original error code
      ASoC: rockchip: rockchip_sai: Drop redundant probe error messages
      ASoC: rockchip: spdif: Return the original error code

shaikh.kamal (1):
      ASoC: dt-bindings: fix spelling errors

wangdicheng (2):
      ASoC: mediatek: mt8189: Remove redundant else-if branch with identical body
      ASoC: fsl_easrc: Use div64_u64 for 64-by-64 division

 .../bindings/sound/amlogic,axg-sound-card.yaml     |    2 +-
 .../bindings/sound/amlogic,gx-sound-card.yaml      |    2 +-
 .../devicetree/bindings/sound/cirrus,cs35l36.yaml  |  240 +++
 .../devicetree/bindings/sound/cirrus,cs42l43.yaml  |    1 +
 .../devicetree/bindings/sound/cs35l36.txt          |  168 ---
 .../devicetree/bindings/sound/dmic-codec.yaml      |    4 +
 .../bindings/sound/eukrea,asoc-tlv320.yaml         |   61 +
 .../devicetree/bindings/sound/eukrea-tlv320.txt    |   26 -
 .../devicetree/bindings/sound/everest,es8316.yaml  |   28 +
 .../devicetree/bindings/sound/fsl,micfil.yaml      |    4 +
 .../bindings/sound/loongson,ls-audio-card.yaml     |   53 +-
 .../bindings/sound/loongson,ls2k1000-i2s.yaml      |   22 +-
 .../bindings/sound/mediatek,mtk-btcvsd-snd.yaml    |   59 +
 .../devicetree/bindings/sound/mtk-btcvsd-snd.txt   |   24 -
 .../bindings/sound/neofidelity,ntp8918.yaml        |    2 +-
 .../devicetree/bindings/sound/omap-dmic.txt        |   20 -
 .../sound/qcom,msm8916-wcd-digital-codec.yaml      |    8 +-
 .../sound/qcom,pm8916-wcd-analog-codec.yaml        |   11 +-
 .../bindings/sound/qcom,q6apm-lpass-dais.yaml      |   50 +
 .../bindings/sound/qcom,q6dsp-lpass-ports.yaml     |    4 +-
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |   31 +
 .../devicetree/bindings/sound/qcom,wsa8855.yaml    |   93 ++
 .../devicetree/bindings/sound/realtek,rt1015.yaml  |    2 +-
 .../bindings/sound/renesas,r9a09g047-sound.yaml    |    2 +-
 .../devicetree/bindings/sound/spacemit,k1-i2s.yaml |   64 +-
 .../devicetree/bindings/sound/st,sta32x.txt        |    2 +-
 .../devicetree/bindings/sound/ti,omap4-dmic.yaml   |   58 +
 .../devicetree/bindings/sound/wlf,wm8524.yaml      |    4 +
 drivers/firmware/cirrus/test/cs_dsp_mock_regmap.c  |    2 +-
 drivers/soundwire/bus_type.c                       |    6 +-
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h |   36 +-
 include/linux/platform_data/omap-twl4030.h         |   42 -
 include/sound/aw88399.h                            |  621 ++++++++
 include/sound/cs35l56.h                            |    1 -
 include/sound/dmaengine_pcm.h                      |    6 -
 include/sound/hda-mlink.h                          |   23 +-
 include/sound/sdca_asoc.h                          |   15 +-
 include/sound/sdca_fdl.h                           |    4 +
 include/sound/sdca_function.h                      |   32 +-
 include/sound/sdca_hid.h                           |   11 +-
 include/sound/simple_card_utils.h                  |   37 +-
 include/sound/soc-acpi.h                           |   23 +-
 include/sound/soc-component.h                      |   11 +
 include/sound/soc.h                                |   15 +-
 include/sound/soc_sdw_utils.h                      |   31 +-
 include/sound/sof/dai-amd.h                        |    1 +
 include/sound/sof/dai.h                            |    3 +
 include/sound/sof/header.h                         |    4 +-
 include/sound/sof/ipc4/header.h                    |  133 +-
 include/sound/tas2781-dsp.h                        |    7 +-
 include/sound/tlv320aic32x4.h                      |   43 -
 include/sound/wm8904.h                             |    4 +-
 include/uapi/sound/skl-tplg-interface.h            |  168 ---
 include/uapi/sound/snd_ar_tokens.h                 |   95 +-
 include/uapi/sound/snd_sst_tokens.h                |  324 -----
 include/uapi/sound/sof/tokens.h                    |    5 +-
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c     |   10 +-
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c     |   12 +-
 sound/soc/amd/acp-config.c                         |   19 +
 sound/soc/amd/acp-pcm-dma.c                        |    8 +-
 sound/soc/amd/acp/acp-i2s.c                        |    6 +
 sound/soc/amd/acp/acp-mach-common.c                |   11 +-
 sound/soc/amd/acp/acp-pci.c                        |   26 +-
 sound/soc/amd/acp/acp-sdw-legacy-mach.c            |   20 +-
 sound/soc/amd/acp/acp-sdw-sof-mach.c               |   16 +-
 sound/soc/amd/acp/acp-sof-mach.c                   |   14 +-
 sound/soc/amd/acp/amd-acp70-acpi-match.c           |   56 +
 sound/soc/amd/mach-config.h                        |    1 +
 sound/soc/amd/raven/acp3x-i2s.c                    |    6 +
 sound/soc/amd/vangogh/acp5x-i2s.c                  |    6 +
 sound/soc/amd/yc/acp6x-mach.c                      |   12 +-
 sound/soc/apple/mca.c                              |  315 ++--
 sound/soc/atmel/atmel-i2s.c                        |    4 +
 sound/soc/atmel/atmel_ssc_dai.c                    |    7 +
 sound/soc/atmel/atmel_wm8904.c                     |   13 +-
 sound/soc/atmel/mchp-i2s-mcc.c                     |    9 +
 sound/soc/atmel/mchp-pdmc.c                        |    4 +
 sound/soc/au1x/db1200.c                            |    2 +-
 sound/soc/au1x/i2sc.c                              |   11 +
 sound/soc/au1x/psc-ac97.c                          |    4 +-
 sound/soc/au1x/psc-i2s.c                           |   11 +
 sound/soc/bcm/bcm2835-i2s.c                        |   13 +
 sound/soc/bcm/cygnus-ssp.c                         |    7 +
 sound/soc/cirrus/ep93xx-i2s.c                      |   11 +
 sound/soc/codecs/Kconfig                           |   61 +-
 sound/soc/codecs/Makefile                          |    6 +
 sound/soc/codecs/ab8500-codec.c                    |   12 +-
 sound/soc/codecs/ad1836.c                          |    6 +
 sound/soc/codecs/ad193x.c                          |   10 +
 sound/soc/codecs/adau1761.c                        |   34 +-
 sound/soc/codecs/adau7118-hw.c                     |    2 +-
 sound/soc/codecs/adav80x.c                         |    8 +
 sound/soc/codecs/ak4613.c                          |   83 +-
 sound/soc/codecs/arizona-jack.c                    |  117 +-
 sound/soc/codecs/arizona.c                         |   26 +-
 sound/soc/codecs/aw87390.c                         |   17 +-
 sound/soc/codecs/aw88081.c                         |   27 +-
 sound/soc/codecs/aw88166.c                         |   32 +-
 sound/soc/codecs/aw88261.c                         |   35 +-
 sound/soc/codecs/aw88261.h                         |    6 -
 sound/soc/codecs/aw88395/aw88395.c                 |   32 +-
 sound/soc/codecs/aw88395/aw88395_device.c          |   40 +-
 sound/soc/codecs/aw88399-lib.c                     | 1409 ++++++++++++++++++
 sound/soc/codecs/aw88399.c                         | 1358 +----------------
 sound/soc/codecs/aw88399.h                         |  582 +-------
 sound/soc/codecs/bt-sco.c                          |   10 +-
 sound/soc/codecs/cpcap.c                           |  130 +-
 sound/soc/codecs/cros_ec_codec.c                   |   26 +-
 sound/soc/codecs/cs-amp-lib.c                      |   11 +-
 sound/soc/codecs/cs35l32.c                         |   10 +-
 sound/soc/codecs/cs35l33.c                         |   14 +-
 sound/soc/codecs/cs35l34.c                         |   14 +-
 sound/soc/codecs/cs35l56-i2c.c                     |   10 +-
 sound/soc/codecs/cs35l56-sdw.c                     |   71 +-
 sound/soc/codecs/cs35l56-shared.c                  |   69 +-
 sound/soc/codecs/cs35l56-spi.c                     |   10 +-
 sound/soc/codecs/cs35l56.c                         |   58 +-
 sound/soc/codecs/cs35l56.h                         |   11 +-
 sound/soc/codecs/cs40l50-codec.c                   |    4 +-
 sound/soc/codecs/cs42l42-sdw.c                     |   14 +-
 sound/soc/codecs/cs42l42.c                         |   54 +-
 sound/soc/codecs/cs42l43-jack.c                    |  138 +-
 sound/soc/codecs/cs42l43.c                         |   20 +-
 sound/soc/codecs/cs42l84.c                         |   10 +-
 sound/soc/codecs/cs43130.c                         |   72 +-
 sound/soc/codecs/cs4349.c                          |    8 +-
 sound/soc/codecs/cs47l15.c                         |   11 +-
 sound/soc/codecs/cs47l35.c                         |   11 +-
 sound/soc/codecs/cs47l85.c                         |   11 +-
 sound/soc/codecs/cs47l90.c                         |   11 +-
 sound/soc/codecs/cs47l92.c                         |   11 +-
 sound/soc/codecs/cs48l32.c                         |   26 +-
 sound/soc/codecs/cx2072x.c                         |  127 +-
 sound/soc/codecs/da7213.c                          |   37 +-
 sound/soc/codecs/da7219.c                          |   62 +-
 sound/soc/codecs/es8316.c                          |   44 +-
 sound/soc/codecs/es8326.c                          |   30 +-
 sound/soc/codecs/es8328.c                          |    5 +
 sound/soc/codecs/es8389.c                          |  236 ++-
 sound/soc/codecs/es8389.h                          |   11 +-
 sound/soc/codecs/es9356.c                          |   33 +-
 sound/soc/codecs/fs-amp-lib.c                      |    3 +-
 sound/soc/codecs/fs210x.c                          |   89 +-
 sound/soc/codecs/hdac_hda.c                        |    7 +-
 sound/soc/codecs/hdac_hdmi.c                       |  127 +-
 sound/soc/codecs/hdmi-codec.c                      |   15 +-
 sound/soc/codecs/idt821034.c                       |  144 +-
 sound/soc/codecs/lochnagar-sc.c                    |    8 +
 sound/soc/codecs/lpass-macro-common.c              |   12 +-
 sound/soc/codecs/lpass-rx-macro.c                  |  137 +-
 sound/soc/codecs/lpass-tx-macro.c                  |  128 +-
 sound/soc/codecs/lpass-va-macro.c                  |  137 +-
 sound/soc/codecs/lpass-wsa-macro.c                 |  138 +-
 sound/soc/codecs/madera.c                          |   51 +-
 sound/soc/codecs/max98090.c                        |    9 +-
 sound/soc/codecs/max98095.c                        |   35 +-
 sound/soc/codecs/max98363.c                        |    7 +-
 sound/soc/codecs/max98373-i2c.c                    |    9 +-
 sound/soc/codecs/max98373-sdw.c                    |    7 +-
 sound/soc/codecs/max98388.c                        |    8 +-
 sound/soc/codecs/max98390.c                        |   24 +-
 sound/soc/codecs/max98396.c                        |   24 +-
 sound/soc/codecs/max9860.c                         |    2 +-
 sound/soc/codecs/max98927.c                        |    8 +-
 sound/soc/codecs/ml26124.c                         |    4 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |  144 +-
 sound/soc/codecs/mt6357.c                          |    4 +-
 sound/soc/codecs/mt6359-accdet.c                   |   13 +-
 sound/soc/codecs/ntpfw.c                           |   21 +-
 sound/soc/codecs/ntpfw.h                           |   11 +-
 sound/soc/codecs/pcm1681.c                         |    7 +
 sound/soc/codecs/pcm1754.c                         |    6 +
 sound/soc/codecs/pcm1789.c                         |    7 +
 sound/soc/codecs/pcm179x.c                         |    6 +
 sound/soc/codecs/pcm186x.c                         |    9 +
 sound/soc/codecs/pcm3060.c                         |    8 +
 sound/soc/codecs/pcm512x.c                         |   68 +-
 sound/soc/codecs/pcm6240.c                         |   41 +-
 sound/soc/codecs/peb2466.c                         |   23 +-
 sound/soc/codecs/pm4125-sdw.c                      |   10 +-
 sound/soc/codecs/pm4125.c                          |    3 +-
 sound/soc/codecs/rt1017-sdca-sdw.c                 |    7 +-
 sound/soc/codecs/rt1017-sdca-sdw.h                 |   10 +-
 sound/soc/codecs/rt1316-sdw.c                      |    9 +-
 sound/soc/codecs/rt1318-sdw.c                      |    9 +-
 sound/soc/codecs/rt1318.c                          |    4 +-
 sound/soc/codecs/rt1320-sdw.c                      |  882 +++++++++--
 sound/soc/codecs/rt1320-sdw.h                      |   19 +
 sound/soc/codecs/rt274.c                           |    8 +-
 sound/soc/codecs/rt286.c                           |   12 +-
 sound/soc/codecs/rt298.c                           |   12 +-
 sound/soc/codecs/rt5514-spi.c                      |   21 +-
 sound/soc/codecs/rt5514.c                          |   16 +-
 sound/soc/codecs/rt5575-spi.c                      |    3 +-
 sound/soc/codecs/rt5645.c                          |  176 +--
 sound/soc/codecs/rt5665.c                          |   15 +-
 sound/soc/codecs/rt5668.c                          |   10 +-
 sound/soc/codecs/rt5677-spi.c                      |   36 +-
 sound/soc/codecs/rt5677.c                          |  100 +-
 sound/soc/codecs/rt5682-sdw.c                      |   44 +-
 sound/soc/codecs/rt5682.c                          |    5 +-
 sound/soc/codecs/rt5682s.c                         |   17 +-
 sound/soc/codecs/rt700-sdw.c                       |   20 +-
 sound/soc/codecs/rt700-sdw.h                       |   11 +-
 sound/soc/codecs/rt711-sdca-sdw.c                  |   29 +-
 sound/soc/codecs/rt711-sdca-sdw.h                  |    6 +-
 sound/soc/codecs/rt711-sdca.c                      |    5 +-
 sound/soc/codecs/rt711-sdw.c                       |   24 +-
 sound/soc/codecs/rt711-sdw.h                       |   10 +-
 sound/soc/codecs/rt711.c                           |   50 +-
 sound/soc/codecs/rt712-sdca-dmic.c                 |   17 +-
 sound/soc/codecs/rt712-sdca-dmic.h                 |    6 +-
 sound/soc/codecs/rt712-sdca-sdw.c                  |   45 +-
 sound/soc/codecs/rt712-sdca-sdw.h                  |   11 +-
 sound/soc/codecs/rt712-sdca.c                      |    5 +-
 sound/soc/codecs/rt715-sdca-sdw.h                  |   12 +-
 sound/soc/codecs/rt715-sdw.h                       |   32 +-
 sound/soc/codecs/rt721-sdca-sdw.c                  |   44 +-
 sound/soc/codecs/rt721-sdca-sdw.h                  |   28 +-
 sound/soc/codecs/rt721-sdca.c                      |    5 +-
 sound/soc/codecs/rt722-sdca-sdw.c                  |   37 +-
 sound/soc/codecs/rt722-sdca.c                      |   16 +-
 sound/soc/codecs/rt766-sdca-sdw.c                  |  339 +++++
 sound/soc/codecs/rt766-sdca-sdw.h                  |   61 +
 sound/soc/codecs/rt766-sdca.c                      | 1378 ++++++++++++++++++
 sound/soc/codecs/rt766-sdca.h                      |  140 ++
 sound/soc/codecs/rt9120.c                          |    9 +-
 sound/soc/codecs/sgtl5000.c                        |    2 +-
 sound/soc/codecs/sigmadsp.c                        |   30 +-
 sound/soc/codecs/sma1303.c                         |    2 +
 sound/soc/codecs/sma1307.c                         |    6 +-
 sound/soc/codecs/sta32x.c                          |   21 +-
 sound/soc/codecs/sta350.c                          |   20 +-
 sound/soc/codecs/sti-sas.c                         |    2 +-
 sound/soc/codecs/tac5xx2-sdw.c                     |   90 +-
 sound/soc/codecs/tas2552.c                         |   24 +-
 sound/soc/codecs/tas2764.c                         |    2 +-
 sound/soc/codecs/tas2780.c                         |    2 +-
 sound/soc/codecs/tas2781-comlib-i2c.c              |    5 +-
 sound/soc/codecs/tas2781-fmwlib.c                  |   51 +-
 sound/soc/codecs/tas2781-i2c.c                     |  253 +++-
 sound/soc/codecs/tas2783-sdw.c                     |  310 ++--
 sound/soc/codecs/tas5805m.c                        |   30 +-
 sound/soc/codecs/tas675x.c                         |   18 +-
 sound/soc/codecs/tlv320aic26.c                     |    6 +
 sound/soc/codecs/tlv320aic31xx.c                   |    8 +-
 sound/soc/codecs/tlv320aic32x4-clk.c               |   68 +-
 sound/soc/codecs/tlv320aic32x4-i2c.c               |   21 +-
 sound/soc/codecs/tlv320aic32x4-spi.c               |   25 +-
 sound/soc/codecs/tlv320aic32x4.c                   |  480 +++---
 sound/soc/codecs/tlv320aic32x4.h                   |   32 +-
 sound/soc/codecs/tlv320dac33.c                     |   87 +-
 sound/soc/codecs/tscs42xx.c                        |   61 +-
 sound/soc/codecs/tscs454.c                         |  107 +-
 sound/soc/codecs/twl6040.c                         |    5 +-
 sound/soc/codecs/uda1342.c                         |    9 +-
 sound/soc/codecs/wcd9335.c                         |    4 +-
 sound/soc/codecs/wcd934x.c                         |   48 +-
 sound/soc/codecs/wcd937x-sdw.c                     |    8 +-
 sound/soc/codecs/wcd937x.c                         |   25 +-
 sound/soc/codecs/wcd938x-sdw.c                     |    8 +-
 sound/soc/codecs/wcd938x.c                         |   22 +-
 sound/soc/codecs/wcd939x-sdw.c                     |    8 +-
 sound/soc/codecs/wcd939x.c                         |   20 +-
 sound/soc/codecs/wm0010.c                          |   86 +-
 sound/soc/codecs/wm2000.c                          |   35 +-
 sound/soc/codecs/wm2200.c                          |   10 +-
 sound/soc/codecs/wm5100.c                          |   10 +-
 sound/soc/codecs/wm5102.c                          |   23 +-
 sound/soc/codecs/wm8731.c                          |    9 +-
 sound/soc/codecs/wm8903.c                          |    9 +-
 sound/soc/codecs/wm8940.c                          |    2 +-
 sound/soc/codecs/wm8958-dsp2.c                     |   10 +-
 sound/soc/codecs/wm8962.c                          |   22 +-
 sound/soc/codecs/wm8994.c                          |   30 +-
 sound/soc/codecs/wm9712.c                          |    5 +-
 sound/soc/codecs/wm9713.c                          |    5 +-
 sound/soc/codecs/wm_adsp.c                         |   77 +-
 sound/soc/codecs/wsa881x.c                         |    8 +-
 sound/soc/codecs/wsa883x.c                         |   19 +-
 sound/soc/codecs/wsa884x.c                         |   18 +-
 sound/soc/codecs/wsa885x.c                         | 1533 ++++++++++++++++++++
 sound/soc/codecs/zl38060.c                         |   11 +-
 sound/soc/dwc/dwc-i2s.c                            |    4 +-
 sound/soc/fsl/fsl-asoc-card.c                      |  728 ++++++----
 sound/soc/fsl/fsl_asrc.c                           |   10 +-
 sound/soc/fsl/fsl_asrc.h                           |    6 +-
 sound/soc/fsl/fsl_asrc_dma.c                       |    4 +-
 sound/soc/fsl/fsl_audmix.c                         |   35 +-
 sound/soc/fsl/fsl_dma.c                            |   68 +-
 sound/soc/fsl/fsl_dma.h                            |    4 +-
 sound/soc/fsl/fsl_easrc.c                          |   43 +-
 sound/soc/fsl/fsl_easrc.h                          |    4 +-
 sound/soc/fsl/fsl_esai.c                           |   16 +-
 sound/soc/fsl/fsl_spdif.c                          |    8 +-
 sound/soc/fsl/fsl_ssi.c                            |   13 +-
 sound/soc/fsl/fsl_xcvr.c                           |   39 +-
 sound/soc/fsl/imx-audio-rpmsg.c                    |   25 +-
 sound/soc/fsl/imx-pcm-rpmsg.c                      |   75 +-
 sound/soc/fsl/mpc5200_dma.c                        |  114 +-
 sound/soc/fsl/mpc5200_psc_ac97.c                   |   38 +-
 sound/soc/fsl/mpc5200_psc_i2s.c                    |   12 +-
 sound/soc/fsl/p1022_ds.c                           |   14 +-
 sound/soc/fsl/p1022_rdk.c                          |   14 +-
 sound/soc/generic/audio-graph-card.c               |   16 +-
 sound/soc/generic/audio-graph-card2.c              |   35 +-
 sound/soc/generic/simple-card-utils.c              |   82 +-
 sound/soc/generic/simple-card.c                    |  127 +-
 sound/soc/intel/atom/sst-atom-controls.c           |   67 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   66 +-
 sound/soc/intel/atom/sst/sst_ipc.c                 |    5 +-
 sound/soc/intel/atom/sst/sst_pci.c                 |    4 +-
 sound/soc/intel/atom/sst/sst_pvt.c                 |    9 +-
 sound/soc/intel/avs/apl.c                          |    8 +-
 sound/soc/intel/avs/avs.h                          |    5 +-
 sound/soc/intel/avs/boards/da7219.c                |    7 +-
 sound/soc/intel/avs/boards/dmic.c                  |    6 +-
 sound/soc/intel/avs/boards/es8336.c                |    6 +-
 sound/soc/intel/avs/boards/hdaudio.c               |    6 +-
 sound/soc/intel/avs/boards/i2s_test.c              |    6 +-
 sound/soc/intel/avs/boards/max98357a.c             |    6 +-
 sound/soc/intel/avs/boards/max98373.c              |    6 +-
 sound/soc/intel/avs/boards/max98927.c              |    6 +-
 sound/soc/intel/avs/boards/nau8825.c               |    6 +-
 sound/soc/intel/avs/boards/pcm3168a.c              |    6 +-
 sound/soc/intel/avs/boards/probe.c                 |    2 +-
 sound/soc/intel/avs/boards/rt274.c                 |    2 +-
 sound/soc/intel/avs/boards/rt286.c                 |    2 +-
 sound/soc/intel/avs/boards/rt298.c                 |    2 +-
 sound/soc/intel/avs/boards/rt5514.c                |    2 +-
 sound/soc/intel/avs/boards/rt5640.c                |    2 +-
 sound/soc/intel/avs/boards/rt5663.c                |    2 +-
 sound/soc/intel/avs/boards/rt5682.c                |    2 +-
 sound/soc/intel/avs/boards/ssm4567.c               |    2 +-
 sound/soc/intel/avs/control.c                      |    7 +-
 sound/soc/intel/avs/core.c                         |    4 +-
 sound/soc/intel/avs/debug.h                        |   10 +-
 sound/soc/intel/avs/debugfs.c                      |   19 +-
 sound/soc/intel/avs/ipc.c                          |   59 +-
 sound/soc/intel/avs/loader.c                       |   15 +-
 sound/soc/intel/avs/path.c                         |   30 +-
 sound/soc/intel/avs/pcm.c                          |   19 +-
 sound/soc/intel/avs/probes.c                       |   16 +-
 sound/soc/intel/avs/topology.c                     |    3 +-
 sound/soc/intel/avs/utils.c                        |   45 +-
 sound/soc/intel/boards/sof_sdw.c                   |   16 +-
 sound/soc/intel/catpt/core.h                       |    4 +-
 sound/soc/intel/catpt/device.c                     |   33 +-
 sound/soc/intel/catpt/loader.c                     |  146 +-
 sound/soc/intel/catpt/pcm.c                        |   59 +-
 sound/soc/intel/common/soc-acpi-intel-arl-match.c  |    3 +
 sound/soc/intel/common/soc-acpi-intel-lnl-match.c  |   15 +-
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c  |   18 +-
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c  |    6 +-
 .../soc/intel/common/soc-acpi-intel-sdca-quirks.c  |    8 +
 .../soc/intel/common/soc-acpi-intel-sdca-quirks.h  |    1 +
 sound/soc/intel/keembay/kmb_platform.c             |    2 +
 sound/soc/loongson/loongson_card.c                 |  171 ++-
 sound/soc/loongson/loongson_i2s_plat.c             |   42 +-
 sound/soc/mediatek/Kconfig                         |    2 +-
 sound/soc/mediatek/common/mtk-dsp-sof-common.c     |    7 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |    2 +-
 sound/soc/mediatek/mt8189/mt8189-dai-adda.c        |    2 -
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  |   12 +-
 sound/soc/mediatek/mt8196/mt8196-nau8825.c         |    2 -
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c         |   16 +-
 sound/soc/mediatek/mt8365/mt8365-mt6357.c          |   10 +-
 sound/soc/meson/Makefile                           |    2 +
 sound/soc/meson/aiu-encoder-i2s.c                  |  365 +++--
 sound/soc/meson/aiu-formatter-i2s.c                |  103 ++
 sound/soc/meson/aiu.c                              |   33 +-
 sound/soc/meson/aiu.h                              |    4 +
 sound/soc/meson/axg-card.c                         |   25 +-
 sound/soc/meson/g12a-toacodec.c                    |    2 +-
 sound/soc/meson/g12a-tohdmitx.c                    |    2 +-
 sound/soc/meson/gx-card.c                          |    6 +-
 sound/soc/meson/gx-formatter.c                     |  282 ++++
 sound/soc/meson/gx-formatter.h                     |   56 +
 sound/soc/meson/gx-interface.h                     |   42 +
 sound/soc/meson/meson-card-utils.c                 |   39 +-
 sound/soc/meson/t9015.c                            |   12 +-
 sound/soc/mxs/mxs-saif.c                           |   21 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |    2 -
 sound/soc/pxa/pxa-ssp.c                            |    7 +-
 sound/soc/pxa/pxa2xx-ac97-lib.c                    |    4 +-
 sound/soc/qcom/common.c                            |  164 ++-
 sound/soc/qcom/common.h                            |   16 +-
 sound/soc/qcom/qdsp6/audioreach.c                  |  140 +-
 sound/soc/qcom/qdsp6/audioreach.h                  |   90 ++
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |   48 +
 sound/soc/qcom/qdsp6/q6afe.c                       |   56 +
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c            |  228 ++-
 sound/soc/qcom/qdsp6/q6apm.c                       |   12 +-
 sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c          |    2 +-
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c           |    5 +
 sound/soc/qcom/qdsp6/q6prm-clocks.c                |   35 +
 sound/soc/qcom/qdsp6/q6prm.c                       |   16 +-
 sound/soc/qcom/qdsp6/q6prm.h                       |   44 +
 sound/soc/qcom/qdsp6/q6routing.c                   |   78 +-
 sound/soc/qcom/qdsp6/topology.c                    |  107 +-
 sound/soc/qcom/sc8280xp.c                          |  430 +++++-
 sound/soc/qcom/sdm845.c                            |    2 -
 sound/soc/qcom/sm8250.c                            |   17 +
 sound/soc/qcom/storm.c                             |   12 +-
 sound/soc/renesas/fsi.c                            |   13 +-
 sound/soc/renesas/rcar/adg.c                       |    8 +-
 sound/soc/renesas/siu_dai.c                        |    4 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c            |   16 +-
 sound/soc/rockchip/rockchip_i2s.c                  |   30 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c              |   15 +-
 sound/soc/rockchip/rockchip_max98090.c             |    5 +-
 sound/soc/rockchip/rockchip_pdm.c                  |    8 +-
 sound/soc/rockchip/rockchip_rt5645.c               |    5 +-
 sound/soc/rockchip/rockchip_sai.c                  |   15 +-
 sound/soc/rockchip/rockchip_spdif.c                |    4 +-
 sound/soc/samsung/aries_wm8994.c                   |    1 +
 sound/soc/samsung/i2s.c                            |   58 +-
 sound/soc/samsung/smdk_spdif.c                     |    8 +-
 sound/soc/samsung/spdif.c                          |    8 +-
 sound/soc/sdca/sdca_asoc.c                         |   18 +-
 sound/soc/sdca/sdca_class_function.c               |    2 +-
 sound/soc/sdca/sdca_fdl.c                          |    8 +-
 sound/soc/sdca/sdca_function_device.c              |    7 +-
 sound/soc/sdca/sdca_functions.c                    |  187 ++-
 sound/soc/sdca/sdca_hid.c                          |   48 +-
 sound/soc/sdca/sdca_interrupts.c                   |    6 +
 sound/soc/sdw_utils/soc_sdw_bridge_cs35l56.c       |    4 +-
 sound/soc/sdw_utils/soc_sdw_utils.c                |   72 +-
 sound/soc/soc-component.c                          |   53 +-
 sound/soc/soc-core.c                               |   44 +-
 sound/soc/soc-dapm.c                               |    6 +
 sound/soc/soc-generic-dmaengine-pcm.c              |   58 +-
 sound/soc/soc-topology-test.c                      |  133 +-
 sound/soc/sof/amd/Kconfig                          |   11 +
 sound/soc/sof/amd/Makefile                         |    2 +
 sound/soc/sof/amd/acp-dsp-offset.h                 |   17 +
 sound/soc/sof/amd/acp-ipc.c                        |   15 +-
 sound/soc/sof/amd/acp-loader.c                     |   37 +-
 sound/soc/sof/amd/acp.c                            |  267 +++-
 sound/soc/sof/amd/acp.h                            |   20 +
 sound/soc/sof/amd/acp7x.c                          |  185 +++
 sound/soc/sof/amd/pci-acp7x.c                      |  116 ++
 sound/soc/sof/fw-file-profile.c                    |   19 +-
 sound/soc/sof/intel/hda-ctrl.c                     |   19 +
 sound/soc/sof/intel/hda-dai-ops.c                  |   76 +-
 sound/soc/sof/intel/hda-dai.c                      |    2 +-
 sound/soc/sof/intel/hda-dsp.c                      |    6 +-
 sound/soc/sof/intel/hda-loader.c                   |   11 +-
 sound/soc/sof/intel/hda-mlink.c                    |   35 +-
 sound/soc/sof/intel/hda-sdw-bpt.c                  |    2 +-
 sound/soc/sof/intel/hda-stream.c                   |   18 +-
 sound/soc/sof/intel/hda.c                          |   18 +-
 sound/soc/sof/intel/hda.h                          |   31 +-
 sound/soc/sof/intel/icl.c                          |   10 +-
 sound/soc/sof/intel/mtl.c                          |   23 +
 sound/soc/sof/ipc3-pcm.c                           |    6 +
 sound/soc/sof/ipc3-topology.c                      |   39 +-
 sound/soc/sof/ipc4-topology.c                      |  382 ++++-
 sound/soc/sof/ipc4-topology.h                      |   12 +-
 sound/soc/sof/ipc4.c                               |   84 ++
 sound/soc/sof/nocodec.c                            |   16 +-
 sound/soc/sof/pcm.c                                |    2 +-
 sound/soc/sof/sof-audio.c                          |    5 +-
 sound/soc/sof/sof-audio.h                          |    8 +-
 sound/soc/sof/topology.c                           |   53 +-
 sound/soc/sophgo/cv1800b-tdm.c                     |   16 +-
 sound/soc/spacemit/k1_i2s.c                        |   47 +-
 sound/soc/spear/spdif_in.c                         |   12 +-
 sound/soc/spear/spdif_out.c                        |    2 +-
 sound/soc/sprd/sprd-mcdt.c                         |    4 +-
 sound/soc/sprd/sprd-pcm-dma.c                      |    2 -
 sound/soc/starfive/jh7110_pwmdac.c                 |   15 +-
 sound/soc/starfive/jh7110_tdm.c                    |   27 +-
 sound/soc/stm/stm32_adfsdm.c                       |    5 +-
 sound/soc/stm/stm32_i2s.c                          |    6 +-
 sound/soc/stm/stm32_sai_sub.c                      |    8 +-
 sound/soc/stm/stm32_spdifrx.c                      |    6 +-
 sound/soc/sunxi/sun4i-codec.c                      |   93 +-
 sound/soc/sunxi/sun4i-i2s.c                        |   28 +-
 sound/soc/sunxi/sun4i-spdif.c                      |   23 +-
 sound/soc/sunxi/sun50i-codec-analog.c              |   11 +-
 sound/soc/sunxi/sun8i-codec-analog.c               |   11 +-
 sound/soc/tegra/tegra20_das.c                      |    7 +-
 sound/soc/tegra/tegra210_adx.c                     |   12 +-
 sound/soc/tegra/tegra210_amx.c                     |   12 +-
 sound/soc/tegra/tegra210_i2s.c                     |   18 +-
 sound/soc/tegra/tegra210_mixer.c                   |    2 +-
 sound/soc/ti/ams-delta.c                           |    8 +-
 sound/soc/ti/davinci-evm.c                         |    3 +-
 sound/soc/ti/j721e-evm.c                           |   11 +-
 sound/soc/ti/omap-abe-twl6040.c                    |   15 +-
 sound/soc/ti/omap-dmic.c                           |    7 +-
 sound/soc/ti/omap-hdmi.c                           |    9 +-
 sound/soc/ti/omap-twl4030.c                        |  170 +--
 sound/soc/ti/rx51.c                                |   53 +-
 sound/soc/uniphier/aio-cpu.c                       |    8 +-
 sound/soc/uniphier/aio.h                           |    2 +-
 sound/soc/ux500/mop500.c                           |   12 +-
 sound/soc/ux500/mop500_ab8500.c                    |    2 +-
 sound/soc/xilinx/xlnx_formatter_pcm.c              |   16 +-
 sound/soc/xilinx/xlnx_i2s.c                        |   30 +-
 sound/soc/xilinx/xlnx_spdif.c                      |   39 +-
 sound/soc/xtensa/xtfpga-i2s.c                      |   60 +-
 503 files changed, 17268 insertions(+), 8851 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs35l36.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cs35l36.txt
 create mode 100644 Documentation/devicetree/bindings/sound/eukrea,asoc-tlv320.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mtk-btcvsd-snd.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mtk-btcvsd-snd.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-dmic.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa8855.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-dmic.yaml
 delete mode 100644 include/linux/platform_data/omap-twl4030.h
 create mode 100644 include/sound/aw88399.h
 delete mode 100644 include/sound/tlv320aic32x4.h
 delete mode 100644 include/uapi/sound/skl-tplg-interface.h
 delete mode 100644 include/uapi/sound/snd_sst_tokens.h
 create mode 100644 sound/soc/codecs/aw88399-lib.c
 create mode 100644 sound/soc/codecs/rt766-sdca-sdw.c
 create mode 100644 sound/soc/codecs/rt766-sdca-sdw.h
 create mode 100644 sound/soc/codecs/rt766-sdca.c
 create mode 100644 sound/soc/codecs/rt766-sdca.h
 create mode 100644 sound/soc/codecs/wsa885x.c
 create mode 100644 sound/soc/meson/aiu-formatter-i2s.c
 create mode 100644 sound/soc/meson/gx-formatter.c
 create mode 100644 sound/soc/meson/gx-formatter.h
 create mode 100644 sound/soc/meson/gx-interface.h
 create mode 100644 sound/soc/sof/amd/acp7x.c
 create mode 100644 sound/soc/sof/amd/pci-acp7x.c
