Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E39CD98C5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:05:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47227601EF;
	Mon, 15 Jun 2026 19:05:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47227601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781543119;
	bh=BXt8e2x6XPolHdsjaUww2lec/Ae/VnOAsY4CPq+AfM4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=tCHEbYWwPe0+XG7IcMoGdb09wkBhpmBLx4dFxfP8XolV7GL2hBvtoEwcJ/mmFbI12
	 Iok4k7RwJYX4i+9WLQknNNLbyaF7EMjXylwbwYE9gkk4VTgIX35tG9mZllorgmFKJp
	 btQsTW4ywnx11nsoum3e916GJGOGfGbnSRAmLGrI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 65D1CF80601; Mon, 15 Jun 2026 19:04:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 217F1F80600;
	Mon, 15 Jun 2026 19:04:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F843F8047D; Mon, 15 Jun 2026 19:04:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781543071;
	b=hw9crHTASvGfAWmZhhEfMMWc0m0U262sCXIieOxKa/ghkcerpJ/kET4kbP0g44m3BRKG
	 czJg1qBVdHvrg9lX2IMFST27xthnPMFZMt2QizQeKjBNmuvbmyfBdmhY1R7c1Co55nM4w
	 mC/Pg2gVPG1T1Z8YpnhEYVnAV4rfKHL37NjNegVrgKj4GIlls9/sJ5QkqV4kdRGIZzqou
	 pwLRAdzJb1f1n0tRaj+M1OCr2JjkLTbEagsWoOxEJ49qSPw1Rh70VX/3YsSB/sbM2OlEY
	 m3uXbfk4j3GXHKeBIYEzEoSoscIaahLW6xhkC3zZNwbGoUcdIuN0gtvKtMf1ZSrlgzg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781543071;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=BXt8e2x6XPolHdsjaUww2lec/Ae/VnOAsY4CPq+AfM4=;
	b=B1qzbsooK6qqN+bhvX62YT2YGe7F2U/RGDByHNRN0x96pDaU6gcnX0Avh8A0NhCnFl/M
	 aBy8VNBWW4G8O64Z1t/+yzrfK4S1gVJJxRmu40AfzO3zrmbWfRctaR3ZgFeqlWrc9L0uo
	 rGpvmj+/vPZjQVkIbmf/3APEAUL9aEJWaLHMkXQlkJSTYQe431yJNnM7E8OJXXRkSZw6S
	 HDiE/PpVz95F3J4VTbAYRR06/LnQEGt/PDNEjauu+bsL64b8Kcx5TPnWprekfnBVX/F3r
	 SEo/u4eqAGLDEOCBaX61KZLH/VWTa1QYao+qKaW4PQQ5in901fu5/sV71jGQOuQYF3w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KLZaRXzx;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id DD2EEF80038
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2026 19:04:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD2EEF80038
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KLZaRXzx
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 2A3DA4444A;
	Mon, 15 Jun 2026 17:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2B35C1F000E9;
	Mon, 15 Jun 2026 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781543066;
	bh=N4ENBrmUnUfUC0GIjy6Hiw/o9r4+WhHDi2sAtOGu0RY=;
	h=From:To:Cc:Subject:Date;
	b=KLZaRXzxP9jHJFUsWZYUpBanDaRUrGqYw85kHW/UsWZu6xG0OKwiMZfY9UZlMxKF2
	 tpHd+ECqu9GETAw1ctCEZscocwE1Yg56jFuIc8PCnkzqNBwD7X8keTnIfOLf4+96yj
	 J/DLYPFi9QQJVJNUAUWp7Q/HVkjquzNZ4cifUEmO1bHs0h9KOo57PVSZGYf4m7dLyY
	 Xlw47U+8PaJVIOZlhlnn06G05LzuV3lrn9+5p+kZi0XDDAOwPsznIqI0rVdKwM4r3v
	 IoQ9T1+JK+KFxSUvJwJFURMSV6U/vxih8eYAid7mPyiDX1SzbwOp7NqZamZ8hYVNUK
	 9cOOlLO2dKzVw==
Message-ID: <ade83b6e856043bf84685b229f85a4d4@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v7.2
Date: Mon, 15 Jun 2026 18:04:15 +0100
Message-ID-Hash: RABTO3WYB6VXLSTAKQZOY4FKJAL7U2UF
X-Message-ID-Hash: RABTO3WYB6VXLSTAKQZOY4FKJAL7U2UF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RABTO3WYB6VXLSTAKQZOY4FKJAL7U2UF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 310628484ef06f95c5589374fade917a5689787b:

  spi: rzv2h-rspi: Fix SPDR read access width for 16-bit RX (2026-06-10 16:39:13 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v7.2

for you to fetch changes up to 4346d91cfa47b0d9303533edde8acd33e4b9ca40:

  ASoC: dt-bindings: Fix RT5677 "realtek,gpio-config" type (2026-06-14 01:03:38 +0100)

----------------------------------------------------------------
ASoC: Updates for v7.2

There's been quite a lot of framework improvements this time around,
though mainly cleanups and robustness rather than user visible features.
The same pattern is seen with a lot of the driver work that's going on,
there are new features but a huge proportion of this is bug fixing and
cleanup work.  We also have a good selectio of new device support.

 - Improvements to SDCA jack handling from Charles Keepax.
 - Use of device links to make suspend handling more robust from Richard
   Fitzgerald.
 - Use of a new helper to factor out a common pattern in SoundWire
   enmeration from Charles Keepax.
 - Slimming down of the component from Kuninori Morimoto.
 - Simplification of format auto selection from Kuninori Morimoto.
 - Lots of conversions to guard() from Bui Duc Phuc.
 - Addition of a simple-amplifier driver supporting more featureful GPIO
   controller amplifiers than the previous basic driver from Herve
   Codina.
 - Support for AMD ACP 7.x, Cirrus Logic CS42448/CS42888, Everest Semi
   ES9356, Mediatek MT2701 and MT8196, Renesas RZ/G3E, Spacemit K3,
   Texas Instruments TAC5xx2 and TAS67524.

----------------------------------------------------------------
Aaron Ma (3):
      ASoC: rt722-sdca: add FU06 Playback Switch for speaker mute control
      ASoC: amd: acp-sdw-legacy: Bound DAI link iteration
      ASoC: amd: acp-sdw-sof: Bound DAI link iteration

Alexey Charkov (2):
      ASoC: dt-bindings: nau8822: Add supply regulators
      ASoC: codecs: nau8822: add support for supply regulators

Andy Shevchenko (1):
      ASoC: Intel: cht_bsw_rt5672: Drop unneeded NULL checks

Anupama Kunkulagunta (2):
      ASoC: tegra: Add S8 PCM format support for MVC
      ASoC: rt5640: Handle nested IRQs

Arnd Bergmann (5):
      ASoC: arm: pxa2xx: remove platform_data processing
      ASoC: pxa2xx: push gpio usage into arch code
      ASoC: pxa: integrate sound/arm/pxa2xx into sound/soc/pxa2xx
      ASoC: SOF: Intel: select SND_SOC_SDW_UTILS=y from SND_SOC_SOF_HDA_GENERIC=y
      ASoC: SOF: Intel: hda-sdw-bpt: select SND_SOF_SOF_HDA_SDW_BPT properly

Baojun Xu (3):
      ASoC: dt-bindings: ti,tas2781: Add TAS2573 support
      ASoC: tas2781: Add TAS2573 support
      ASoC: sdw_utils: Add missed component_name strings for TI amps

Bard Liao (6):
      ASoC: sof-function-topology-lib: add virtual loop dai support
      ASoC: SOF: topology: allow user to add topologies
      ASoC: Intel: sof_sdw: append dai type to dai link name unconditionally
      ASoC: sdw_utils: return -EPROBE_DEFER if components are not registered yet
      ASoC: soc_sdw_utils: add is_amp flag to all amps
      ASoC: SOF: Intel: Use codec_info_list.is_amp directly

Binbin Zhou (4):
      MAINTAINERS: Add entry for Loongson ASoC driver
      ASoC: loongson: Combined regmap definitions
      ASoC: loongson: Use the `idma` identifier for internal DMA variables
      ASoC: loongson: Separate external shared DMA from the platform interface

Cezary Rojewski (14):
      ASoC: core: Move all users to deferrable card binding
      ASoC: Intel: catpt: Complete coredump handling
      ASoC: Intel: catpt: Add pretty-trace for large IPC payloads
      ASoC: Intel: catpt: Print error code if board-registration fails
      ASoC: codecs: pcm3168a: Prevent regulator double-disable in S4
      ASoC: codecs: pcm3168a: Drop redundant pm_runtime_idle()
      ASoC: codecs: pcm3168a: Drop CONFIG_PM-conditional preproc directive
      ASoC: Intel: catpt: Utilize lock-guard helper
      ASoC: Intel: catpt: Replace RAM-helpers with resource_xxx()
      ASoC: Intel: catpt: Simplify the RAM-navigation code
      ASoC: Intel: catpt: Simplify catpt_stream_find()
      ASoC: Intel: catpt: Remove unused WAVES controls
      ASoC: Intel: catpt: Drop manipulation of the obsolete direction flag
      ASoC: Intel: catpt: Cleanup components_kcontrols[]

Chaitanya Sabnis (1):
      ASoC: dt-bindings: cdns,xtfpga-i2s: Convert to dt-schema

Chancel Liu (9):
      ASoC: dt-bindings: imx-card: Complete the full list of supported DAI formats
      ASoC: dapm: Fix widget lookup with prefixed names across DAPM contexts
      ASoC: soc-core: Add core support for ignoring suspend on selected DAPM widgets
      ASoC: fsl: imx-rpmsg: Switch to core ignore-suspend-widgets support
      ASoC: dt-bindings: cirrus,cs42xx8: Add SPI bus support
      ASoC: cs42xx8: Add SPI bus support for CS42448/CS42888 codec
      ASoC: dt-bindings: fsl,rpmsg: Add hp-det-gpios property
      ASoC: imx-rpmsg: Support headphone jack detection
      ASoC: imx-rpmsg: Set driver_name for snd_soc_card

Charles Keepax (33):
      ASoC: SDCA: Add correct masks whilst reporting SDCA jack status
      ASoC: SDCA: Remove sdca_function_data duplication
      ASoC: SDCA: Support devices with multiple functions of identical type
      ASoC: SDCA: Fix bad move of jack_state initialisation
      soundwire: Add a helper function to wait for device initialisation
      ASoC: cs35l56: Use new SoundWire enumeration helper
      ASoC: cs42l42: Use new SoundWire enumeration helper
      ASoC: max98363: Use new SoundWire enumeration helper
      ASoC: max98373: Use new SoundWire enumeration helper
      ASoC: rt700: Use new SoundWire enumeration helper
      ASoC: rt711: Use new SoundWire enumeration helper
      ASoC: rt712: Use new SoundWire enumeration helper
      ASoC: rt715: Use new SoundWire enumeration helper
      ASoc: rt721: Use new SoundWire enumeration helper
      ASoC: rt722: Use new SoundWire enumeration helper
      ASoC: rt1017: Use new SoundWire enumeration helper
      ASoC: rt1308: Use new SoundWire enumeration helper
      ASoC: rt1316: Use new SoundWire enumeration helper
      ASoC: rt1318: Use new SoundWire enumeration helper
      ASoC: rt1320: Use new SoundWire enumeration helper
      ASoC: rt5682: Use new SoundWire enumeration helper
      ASoC: tas2783: Use new SoundWire enumeration helper
      ASoC: tac5xx2-sdw: Use new SoundWire enumeration helper
      ASoC: es9356: Use new SoundWire enumeration helper
      soundwire: Always wait for initialisation of unattached devices
      ASoC: wsa881x: Use new SoundWire enumeration helper
      ASoC: rt5682: Use new SoundWire enumeration helper
      ASoC: pm4125: Use new SoundWire enumeration helper
      ASoC: wcd937x: Use new SoundWire enumeration helper
      ASoC: wcd938x: Use new SoundWire enumeration helper
      ASoC: wcd939x: Use new SoundWire enumeration helper
      ASoC: SDCA: Use new SoundWire enumeration helper
      ASoC: cs35l56: Remove unnecessary conditionals waiting for enumeration

Chia-Lin Kao (AceLan) (1):
      ASoC: sdw_utils: fix missing component_name for cs42l43 part_id 0x2A3B

Cássio Gabriel (15):
      ASoC: docs: Fix stale and misspelled references
      ASoC: mediatek: mt8196: Fix probe resource cleanup
      ASoC: mediatek: mt8189: Fix probe resource cleanup
      ASoC: rockchip: i2s: Use managed hclk and runtime PM cleanup
      ASoC: codecs: rk3328: Use managed GPIO and clock helpers
      ASoC: mediatek: mt8183: Release reserved memory on cleanup
      ASoC: mediatek: mt8183: Check runtime resume during probe
      ASoC: mediatek: mt8192: Release reserved memory on cleanup
      ASoC: mediatek: mt8192: Check runtime resume during probe
      ASoC: sma1307: Fix uevent string leaks in fault worker
      ASoC: SOF: topology: validate vendor array size before parsing
      ASoC: topology: Check PCM and DAI name strings before use
      ASoC: qcom: common: use scoped OF node handling
      ASoC: fsl: fsl_qmc_audio: use scoped child node loop
      ASoC: bcm: cygnus: use scoped child node loop

Daniel Golle (6):
      ASoC: dt-bindings: mt2701-afe-pcm: add HDMI audio path clocks
      ASoC: dt-bindings: mediatek,mt2701-hdmi-audio: add MT2701 HDMI audio
      ASoC: mediatek: mt2701: add AFE HDMI register definitions
      ASoC: mediatek: mt2701: add optional HDMI audio path clocks
      ASoC: mediatek: mt2701: add HDMI audio memif, FE and BE DAIs
      ASoC: mediatek: mt2701: add machine driver for on-chip HDMI codec

Darren Ye (10):
      ASoC: mediatek: common: modify mtk afe platform driver for mt8196
      ASoC: mediatek: mt8196: add common header
      ASoC: mediatek: mt8196: support audio clock control
      ASoC: mediatek: mt8196: support ADDA in platform driver
      ASoC: mediatek: mt8196: support I2S in platform driver
      ASoC: mediatek: mt8196: support TDM in platform driver
      ASoC: dt-bindings: mediatek,mt8196-afe: add audio AFE
      ASoC: mediatek: mt8196: add platform driver
      ASoC: dt-bindings: mediatek,mt8196-nau8825: Add audio sound card
      ASoC: mediatek: mt8196: add machine driver with nau8825

Diederik de Haas (1):
      ASoC: dt-bindings: everest,es8389: Document audio graph port

Ethan Nelson-Moore (4):
      ASoC: ti: omap3pandora: update board check to use DT compatible
      ASoC: ti: rx51: remove stale reference to machine_is_nokia_rx51()
      ASoC: fsl: eukrea-tlv320: update board checks to use the DT
      ASoC: tas2783A: remove unused tas25xx_(de)register_misc() functions

Ethan Tidmore (1):
      ASoC: cs35l56-shared-test: Fix possible null pointer dereference

Gabriel Jacob Perin (1):
      ASoC: atmel: Change manual bitfield manipulation to use FIELD_PREP()

Guangshuo Li (1):
      ASoC: adau1372: Clear PLL_EN on failed PLL lock without reset GPIO

Herve Codina (17):
      of: Introduce of_property_read_s32_index()
      ASoC: dt-bindings: Add support for the GPIOs driven amplifier
      ASoC: simple-amplifier: Remove DRV_NAME defined value
      ASoC: simple-amplifier: Add missing headers
      ASoC: simple-amplifier: Remove CONFIG_OF flag and of_match_ptr()
      ASoC: simple-amplifier: Rename drv_event() function
      ASoC: simple-amplifier: Use 'simple_amp' variable name instead of 'priv'
      ASoC: simple-amplifier: Remove DAPM widgets and routes from the ASoC component driver
      ASoC: simple-amplifier: Introduce support for gpio-audio-amp
      ASoC: simple-amplifier: gpio-audio-amp: Add support for extra power supplies
      ASoC: simple-amplifier: gpio-audio-amp: Add support for mute gpio
      ASoC: simple-amplifier: gpio-audio-amp: Add support for bypass gpio
      ASoC: simple-amplifier: gpio-audio-amp: Add support for basic gain
      ASoC: simple-amplifier: gpio-audio-amp: Add support for gain-ranges
      ASoC: simple-amplifier: gpio-audio-amp: Add support for gain-labels
      ASoC: simple-amplifier: Update author and copyright
      MAINTAINERS: Add the ASoC gpio audio amplifier entry

HyeongJun An (4):
      ASoC: codecs: hdac_hdmi: Validate written enum value
      ASoC: meson: aiu: Validate written enum values
      ASoC: fsl: fsl_audmix: Validate written enum values
      ASoC: tegra: tegra210_ahub: Validate written enum value

Jack Yu (1):
      ASoC: rt722-sdca: Add a control to support CAE firmware update

Janusz Krzysztofik (1):
      ASoC: ti: ams-delta: Stop (ab)using card->pop_time

John Madieu (18):
      ASoC: dt-bindings: sound: Add DT binding for RZ/G3E sound
      ASoC: rsnd: Fix RSND_SOC_MASK width to single nibble
      ASoC: rsnd: Add reset controller support to rsnd_mod
      ASoC: rsnd: Support hyphen or dot in indexed clock and reset names
      ASoC: rsnd: Add RZ/G3E SoC probing and register map
      ASoC: rsnd: Add audmapp clock and reset support for RZ/G3E
      ASoC: rsnd: Refactor DMA address tables with named structs
      ASoC: rsnd: Add RZ/G3E DMA address calculation support
      ASoC: rsnd: ssiu: Add shared SSI reset controller support
      ASoC: rsnd: ssiu: Add RZ/G3E BUSIF support
      ASoC: rsnd: Add SSI reset support for RZ/G3E platform
      ASoC: rsnd: Add ADG reset support for RZ/G3E
      ASoC: rsnd: adg: Add per-SSI ADG and SSIF supply clock management
      ASoC: rsnd: adg: Look up RZ/G3E clkin under audio-clk{a,b,c,i}
      ASoC: rsnd: src: Acquire shared SCU clocks for RZ/G3E
      ASoC: rsnd: src: Add SRC reset support for RZ/G3E
      ASoC: rsnd: Support unprefixed DT node names for RZ/G3E
      ASoC: rsnd: Add system suspend/resume support

João (1):
      ASoC: mchp-spdifrx: Replace manual bitfield manipulations with macros and typo correction

Krzysztof Kozlowski (2):
      ASoC: tegra: Move MODULE_DEVICE_TABLE next to the table itself
      ASoC: rockchip: Move MODULE_DEVICE_TABLE next to the table itself

Kuninori Morimoto (32):
      ASoC: soc-dapm: move card->pop_time to soc-dapm.c
      ASoC: soc-card: add snd_soc_card_set_topology_name()
      ASoC: amd: acp3x-rn: remove unused machine
      ASoC: amd: acp6x-mach: remove unused machine
      ASoC: amd: ps-mach: remove unused machine
      ASoC: soc-core: remove card->dmi_longname
      sh: ecovec24: remove FSI/DA7210/Simple-Audio-Card support
      sh: 7724se: remove FSI/AK4642/Simple-Audio-Card support
      ASoC: simple-card: remove platform data style
      sh: roll back Ecovec24/7724se Sound support
      ASoC: renesas: fsi: remove platform data style support
      ASoC: soc-component: remove CONFIG_DEBUG_FS for debugfs_prefix
      ASoC: fsl: imx-pcm-rpmsg: set debugfs_prefix via Component driver
      ASoC: soc-generic-dmaengine: set debugfs_prefix via Component driver
      ASoC: stm: stm32_adfsdm: set debugfs_prefix via Component driver
      ASoC: mediatek: mt8173-afe-pcm: set debugfs_prefix via Component driver
      ASoC: soc-component: remove .debugfs_prefix from Component
      ASoC: mediatek: cleanup mtk_sof_dailink_parse_of() param
      ASoC: mediatek: mtk-soundcard-driver: tidyup set_card_codec_info()
      ASoC: mediatek: mtk-soundcard-driver: tidyup set_dailink_daifmt()
      ASoC: mediatek: mt8186-mt6366: tidyup mt8186_mt6366_card_set_be_link()
      ASoC: mediatek: mt8186-mt6366: use *dev in mt8186_mt6366_soc_card_probe()
      ASoC: mediatek: mt8365_mt6357: use *dev in mt8365_mt6357_gpio_probe()
      ASoC: remove SND_SOC_POSSIBLE_xBx_xFx
      ASoC: codecs: framer-codec: don't use array if single pattern
      ASoC: codecs: idt821034: don't use array if single pattern
      ASoC: codecs: peb2466: don't use array if single pattern
      ASoC: codecs: ak4619: update auto select format
      ASoC: codecs: pcm3168a: update auto select format
      ASoC: renesas: rcar: update auto select format
      ASoC: update auto format selection method
      ASoC: audio-graph-card2: recommend to use auto select DAI format

Linus Walleij (1):
      ASoC: wsa881x: Move custom workaround to gpiolib-of

Maciej Strozek (2):
      ASoC: soc_sdw_utils: skip aux device if it is not present
      ASoC: soc_sdw_utils: Change comment into proper kernel doc

Manish Baing (1):
      ASoC: dt-bindings: mediatek,mt6351: convert to DT schema

Marco Crivellari (2):
      ASoC: cs42l43: Move long delayed work on system_dfl_long_wq
      ASoC: codecs: rt5640: Move long delayed work on system_dfl_long_wq

Marek Vasut (3):
      ASoC: tlv320aic3x: Add multi endpoint support
      ASoC: dt-bindings: fsl-sai: Document RX/TX BCLK swap support
      ASoC: fsl_sai: Add RX/TX BCLK swap support

Mark Brown (63):
      ASoC: ops: Log unknown controls in snd_soc_limit_volume()
      ASoC: samsung: Use guard() for spin locks
      ASoC: SOF: topology: allow user to add topologies
      ASoC: dt-bindings: fsl-sai: Document RX/TX BCLK swap support
      ASoC: tegra210: simplify ADX/AMX byte map get/put logic
      ASoC: Add TAS67524 quad-channel Class-D amplifier driver
      ASoC: wsa881x: Move custom workaround to gpiolib-of
      ASoC: fsl-asoc-card: Add some improvements
      ASoC: uniphier: Use guard() for spin locks
      ASoC: Improve SDCA support for duplicated features
      ASoC: mediatek: Add support for MT8196 SoC
      ASoC: tegra: Move MODULE_DEVICE_TABLE next to the table itself
      ASoC: wm_adsp_fw_find_test: Fix a couple of bugs
      ASoC: Move system_long_wq to system_dfl_long_wq
      ASoC: ti: Cleanup locking code using guard() helpers
      ASoC: soc_sdw_utils: skip aux device if it is not present
      ASoC: Add a new SoundWire enumeration helper
      ASoC: Merge up fixes
      ASoC: Add support for GPIOs driven amplifiers
      ASoC: cs35l56: Replace open-coded SoundWire regmap with generic regmap-sdw
      ASoC: move card->pop_time to soc-dapm
      ASoC: SOF: DSP core count handling updates
      ASoC: Rework initialization of i2c_device_ids
      ASoC: AMD: ACP7.x initial PCI driver bring-up
      ASoC: SOF: Intel: Enable offload for UAOL for LNL+
      ASoC: cs35l56: Replace open-coded SoundWire regmap with generic regmap-sdw
      ASoC: stm: Use guard() for mutex & spin locks
      ASoC: add shared BCLK rate constraint for cross-DAI coordination
      ASoC: soc-core: Add core support for ignoring suspend on selected DAPM widgets
      ASoC: codecs: max98090: switch to standard set_jack callback
      ASoC: SOF: ipc4-topology: Support for multiple src output formats
      ASoC: Address es9356 build failures without CONFIG_SND_SOC_SDCA
      ASoC: Intel: catpt: Error handling and debug improvements
      ASoC: nau8822: add support for supply regulators
      ASoC: rsnd: Add RZ/G3E audio driver support
      ASoC: codecs: pcm3168a: Fix and updates for power management
      ASoC: spacemit: add K3 SoC support
      ASoC: sti: Use guard() for mutex & spin locks
      ASoC: qcom: qdsp6: add push/pull module support
      ASoC: mediatek: mt8183: Fix probe resource cleanup
      ASoC: mediatek: mt8192 probe cleanup
      ASoC: loongson: Refactor DMA and regmap handling
      ASoC: cs42xx8: Add SPI bus support for CS42448/CS42888 codec
      ASoC: amd: remove unused machine
      ASoC: Intel: catpt: Code cleanup
      ASoC: imx-rpmsg: Add headphone jack detection and driver_name support
      ASoC: simple-card: remove platform data style
      ASoC: dt-bindings: ti,tas2781: Add TAS2573 support
      ASoC: amd: acp-sdw-legacy: Bound DAI link iteration
      ASoC: SOF: ipc3/ipc4-control: harden kcontrol payload handling
      ASoC: codecs: aw88261: fixes and cleanup
      ASoC: cs35l56: Fix some cleanup memory leaks
      ASoC/sh: roll back Ecovec24/7724se Sound support
      ASoC: Use codec_info_list.is_amp directly in find_acpi_adr_device()
      ASoC: remove .debugfs_prefix from Component
      ASoC: img: Use guard() for spin locks
      ASoC: Validate written enum values in custom controls
      ASoC: rockchip: Reorder clock enable sequence
      ASoC: rockchip: Use guard() for spin locks
      ASoC: mediatek: Use guard() for mutex & spin locks
      ASoC: mediatek: tidyup details
      ASoC: use scoped OF node handling in manual cleanup paths
      ASoC: don't use array if single pattern

Md Shofiqul Islam (1):
      ASoC: nau8825: Fix typos in comments

Nathan Chancellor (3):
      ASoC: SDCA: Make CONFIG_SND_SOC_SDCA a user selectable symbol
      ASoC: codecs: Adjust indentation in CONFIG_SND_SOC_ES9356 definition
      ASoC: es9356-sdca: Depend on CONFIG_SND_SOC_SDCA

Niranjan H Y (5):
      ASoC: SDCA: Add PDE verification reusable helper
      ASoC: tac5xx2-sdw: add soundwire based codec driver
      ASoC: sdw_utils: TI amp utility for tac5xx2 family
      ASoC: tac5xx2-sdw: ACPI match for intel mtl platform
      ASoC: sdw_utils: Remove dead code in asoc_sdw_ti_add_tac5xx2_routes()

Peter Ujfalusi (14):
      ASoC: SOF: ipc4-topology: Handle SOF_DBG_DISABLE_MULTICORE flag for pipelines
      ASoC: SOF: Validate and correct the core id against the number of cores of the DSP
      ASoC: SOF: ipc4-control: Use local copy of IPC message for sending
      ASoC: SOF: Intel: hda-mlink/lnl: Convert offload enable functions to void
      ASoC: SOF: Intel: lnl: Enable offload for UAOL link
      ASoC: SOF: ipc4-topology: Print for format type in dbg_audio_format
      ASoC: SOF: ipc4-topology: Validate the number of in/out formats for src/asrc
      ASoC: SOF: ipc4-topology: Allow the use of multiple formats for src output
      ASoC: SOF: ipc4-control: Fix TOCTOU in sof_ipc4_bytes_put
      ASoC: SOF: ipc4-control: Validate notification payload size
      ASoC: SOF: ipc3-control: Use overflow checks in control_update size calc
      ASoC: SOF: ipc3-control: Validate size in snd_sof_update_control
      ASoC: SOF: ipc3-control: Fix TOCTOU in bytes_put and bytes_get
      ASoC: SOF: ipc3-control: Fix heap overflow in bytes_ext put/get

Piyush Patle (2):
      ASoC: tegra210_adx: simplify byte map get/put logic
      ASoC: tegra210_amx: simplify byte map get/put logic

Randy Dunlap (1):
      ASoC: docs: fix TAS675x doc build warnings

Richard Fitzgerald (17):
      ASoC: cs35l56: Abort TDM mask loop at maximum channel shift
      ASoC: cs35l56-shared-test: Subtract reg_base offset in dummy regmap
      ASoC: cs35l56: Use reg_base to offset addresses on SoundWire
      ASoC: cs35l56: Use standard SoundWire regmap implementation
      ASoC: cs35l56-shared-test: Subtract reg_base offset in dummy regmap
      ASoC: cs35l56: Use reg_base to offset addresses on SoundWire
      ASoC: cs35l56: Use standard SoundWire regmap implementation
      ASoC: cs-amp-lib: Simplify overcomplicated error return
      ASoC: cs35l56: Share common SoundWire interrupt enable/disable code
      ASoC: cs35l56: Increase pm_runtime autosuspend delay
      ASoC: cs35l56: Fix missing calls to wm_adsp2_remove()
      ASoC: cs35l56: Prevent double-free of debugfs
      ASoC: cs35l56: Cleanup if component_probe fails
      ASoC: cs35l56: Don't leave parent IRQ disabled if system_suspend fails
      ASoC: cs35l56: Fix possible uninitialized value in cs35l56_spi_system_reset()
      ASoC: soc-core: Create device_link to ensure correct suspend order
      ASoC: cs35l56: Fix wrong error test on simple_write_to_buffer()

Rob Herring (Arm) (1):
      ASoC: dt-bindings: Fix RT5677 "realtek,gpio-config" type

Rosen Penev (11):
      ASoC: ti: j721e-evm: allocate dai_links with priv
      ASoC: tegra: ADMAIF: allocate with a single kzalloc
      ASoC: tegra: tegra210-mixer: Use div_u64() for 64-bit division
      ASoC: pcm6240: Use flexible array for config blocks
      ASoC: sigmadsp: Use flexible array for control cache
      ASoC: fsl: Allow MPC5200 PSC audio compile testing
      ASoC: uda1380: remove kmemdup_array
      ASoC: mediatek: mt2701: allocate i2s_path with priv
      ASoC: mediatek: mt2701: fix snprintf bounds
      ASoC: aw88395: use struct_size() and __counted_by() for aw_container
      ASoC: tegra: ADX: use of_device_get_match_data

Sachin Mokashi (1):
      ASoC: Intel: cht_bsw_rt5672: Simplify probe() with local 'dev' pointer

Sen Wang (5):
      ASoC: dt-bindings: Add ti,tas67524
      ASoC: codecs: Add TAS67524 quad-channel audio amplifier driver
      Documentation: sound: Add TAS675x codec mixer controls documentation
      MAINTAINERS: add entry for TAS67524 audio amplifier
      ASoC: ti: davinci-mcasp: Add audio-graph-card2 and DPCM support

Seppo Ingalsuo (1):
      ASoC: SOF: ipc4-topology: Enable deep buffer capture

Sheetal (2):
      ASoC: tegra: Add per-stream Mixer Fade controls
      ASoC: tegra: tegra210-mixer: Reject too-short fade durations

Shengjiu Wang (6):
      ASoC: fsl_micfil: Add DC output remover control
      ASoC: fsl-asoc-card: enable dpcm_merged_chan flag for ASRC frontend
      ASoC: fsl-asoc-card: enable ignore_pmdown_time for ASRC case
      ASoC: fsl-asoc-card: add channel and rate constraints for CS42888
      ASoC: fsl-asoc-card: exclude S20_3LE format for WM8960/WM8962 + SAI
      ASoC: fsl-asoc-card: reduce WM8904 PLL ratio to meet frequency limit

Srinivas Kandagatla (8):
      ASoC: mt8173-max98090: use standard callback to set jack
      ASoC: codecs: max98090: use component set_jack callback
      ASoC: qcom: audioreach: use cached shared memory module IID
      ASoC: qcom: q6apm: return error code to consumers on failures
      ASoC: qcom: q6apm: remove shared memory IID helpers
      ASoC: qcom: audioreach: Add support for shared memory push/pull modules
      ASoC: qcom: q6apm: add watermark event support
      ASoC: qcom: q6apm-dai: add push-pull and watermark event support

Troy Mitchell (5):
      ASoC: soc-dai: add shared BCLK clock for cross-DAI rate constraints
      ASoC: soc-pcm: add DEFINE_GUARD for snd_soc_card_mutex
      ASoC: soc-pcm: constrain hw_params when DAIs share the same BCLK
      ASoC: dt-bindings: add SpacemiT K3 SoC compatible
      ASoC: spacemit: add K3 SoC support with additional clocks

Tuo Li (1):
      ASoC: mediatek: mt8365-afe-pcm: fix possible NULL-pointer dereferences in mt8365_afe_suspend()

Uwe Kleine-König (The Capable Hub) (2):
      ASoC: Drop empty i2c remove callbacks
      ASoC: Use named initializers for arrays of i2c_device_data

Val Packett (7):
      ASoC: codecs: aw88261: support changing sample rate and bit width
      ASoC: codecs: aw88261: add TDM support
      ASoC: codecs: aw88261: reduce log spam
      ASoC: codecs: aw88261: remove fade in/out on start/stop
      ASoC: codecs: aw88261: remove async start
      ASoC: codecs: aw88261: fix incorrect masks for boost regs
      ASoC: codecs: aw88261: make volume control usable

Vijendar Mukunda (7):
      include: sound: add register header file for acp7.x series
      ASoC: amd: acp7x: add ACP PCI driver probe/remove sequence
      ASoC: amd: acp7x: add helper functions and hw ops
      ASoC: amd: enable acp7.x drivers build
      ASoC: amd: acp7x: add system and runtime PM ops
      ASoC: amd: ps: honor machine_check in SoundWire machine select
      ASoC: SOF: amd: honor machine_check in SoundWire machine select

Zhang Yi (5):
      ASoC: sdw_utils: add soc_sdw_es9356
      ASoC: sdw_utils: add ES9356 in codec_info_list
      ASoC: es9356-sdca: Add ES9356 SDCA driver
      ASoC: Intel: soc-acpi: arl: Add es9356 support
      ASoC: Intel: sof_sdw: add es9356 support

Zhao Dongdong (1):
      ASoC: SOF: topology: fix memory leak in snd_sof_load_topology

bui duc phuc (57):
      ASoC: apple: mca: Use guard() for mutex locks
      ASoC: samsung: i2s: Use guard() for spin locks
      ASoC: samsung: idma: Use guard() for spin locks
      ASoC: samsung: odroid: Use guard() for spin locks
      ASoC: samsung: pcm: Use guard() for spin locks
      ASoC: samsung: spdif: Use guard() for spin locks
      ASoC: ux500: Use guard() for mutex locks
      ASoC: tegra: Use guard() for mutex locks
      ASoC: uniphier: aio-compress: Use guard() for spin locks
      ASoC: uniphier: aio-dma: Use guard() for spin locks
      ASoC: ti: j721e-evm: Use guard() for mutex locks
      ASoC: ti: omap-dmic: Use guard() for mutex locks
      ASoC: ti: omap-hdmi: Use guard() for mutex locks
      ASoC: ti: omap-mcpdm: Use guard() for mutex locks
      ASoC: ti: ams-delta: Use guard() for spin locks
      ASoC: ti: omap-mcbsp-st: Use guard() for spin locks
      ASoC: ti: omap-mcbsp: Simplify lock and resource handling
      ASoC: ti: omap-mcbsp: Remove mixed goto/scoped cleanup handling
      ASoC: stm: stm32_adfsdm: Use guard() for mutex locks
      ASoC: stm: stm32_i2s: Use guard() for spin locks
      ASoC: stm: stm32_sai_sub: Use guard() for mutex & spin locks
      ASoC: stm: stm32_spdifrx: Use guard() for spin locks
      ASoC: sti: uniperif_reader: Use guard() for spin locks
      ASoC: sti: uniperif_player: Use guard() for mutex & spin locks
      ASoC: sprd: sprd-mcdt: Use guard() for mutex & spin locks
      ASoC: dt-bindings: renesas,fsi: add support multiple clocks
      ASoC: renesas: fsi: Fix trigger stop ordering
      ASoC: renesas: fsi: Move fsi_stream_is_working()
      ASoC: renesas: fsi: Fix register access from in-flight IRQ after shutdown
      ASoC: renesas: fsi: Move fsi_clk_init()
      ASoC: renesas: fsi: Use devm_clk_get_optional() for optional clocks
      ASoC: renesas: fsi: refactor clock initialization
      ASoC: renesas: fsi: Add SPU clock support
      ASoC: renesas: fsi: add fsi_clk_prepare/unprepare()
      ASoC: renesas: fsi: Add SPU clock control in hw_startup/shutdown
      ASoC: meson: axg-tdm-formatter: Use guard() for mutex locks
      ASoC: img: img-spdif-in: Use guard() for spin locks
      ASoC: img: img-spdif-out: Use guard() for spin locks
      ASoC: dt-bindings: rockchip-spdif: Correct SPDIF clock descriptions
      ASoC: rockchip: spdif: Reorder clock enable sequence
      ASoC: rockchip: rockchip_pdm: Reorder clock enable sequence
      ASoC: rockchip: spdif: Restore regcache cache-only mode on sync failure
      ASoC: rockchip: rockchip_pdm: Handle runtime PM resume failures in set_fmt
      ASoC: rockchip: rockchip_i2s: Use guard() for spin locks
      ASoC: rockchip: i2s-tdm: Use guard() for spin locks
      ASoC: rockchip: rockchip_sai: Use guard() for spin locks
      ASoC: mediatek: common: mtk-afe-fe-dai: Use guard() for mutex locks
      ASoC: mediatek: common: mtk-btcvsd: Use guard() for spin locks
      ASoC: mediatek: mt8186: mt8186-afe-gpio: Use guard() for mutex locks
      ASoC: mediatek: mt8188: mt8188-afe-clk: Use guard() for spin locks
      ASoC: mediatek: mt8192: mt8192-afe-gpio: Use guard() for mutex locks
      ASoC: mediatek: mt8195: mt8195-afe-clk: Use guard() for spin locks
      ASoC: mediatek: mt8195: mt8195-dai-etdm: Use guard() for spin locks
      ASoC: mediatek: mt8195: mt8365-afe-clk: Use guard() for mutex & spin locks
      ASoC: mediatek: mt8195: mt8365-dai-adda: Use guard() for spin locks
      ASoC: mediatek: mt8195: mt8365-dai-i2s: Use guard() for spin locks
      ASoC: hisilicon: Use guard() for spin locks

 .../bindings/crypto/qcom,inline-crypto-engine.yaml |    35 +-
 .../devicetree/bindings/net/eswin,eic7700-eth.yaml |     3 +-
 .../devicetree/bindings/sound/cdns,xtfpga-i2s.txt  |    18 -
 .../devicetree/bindings/sound/cdns,xtfpga-i2s.yaml |    48 +
 .../devicetree/bindings/sound/cirrus,cs42xx8.yaml  |    23 +
 .../devicetree/bindings/sound/everest,es8389.yaml  |     4 +
 .../devicetree/bindings/sound/fsl,rpmsg.yaml       |     4 +
 .../devicetree/bindings/sound/fsl,sai.yaml         |     7 +
 .../devicetree/bindings/sound/gpio-audio-amp.yaml  |   270 +
 .../devicetree/bindings/sound/imx-audio-card.yaml  |     6 +
 .../bindings/sound/mediatek,mt2701-audio.yaml      |    23 +
 .../bindings/sound/mediatek,mt2701-hdmi-audio.yaml |    48 +
 .../bindings/sound/mediatek,mt6351-sound.yaml      |    37 +
 .../bindings/sound/mediatek,mt8196-afe.yaml        |   113 +
 .../bindings/sound/mediatek,mt8196-nau8825.yaml    |   100 +
 Documentation/devicetree/bindings/sound/mt6351.txt |    16 -
 .../devicetree/bindings/sound/nuvoton,nau8822.yaml |    18 +
 .../devicetree/bindings/sound/realtek,rt5677.yaml  |     4 +-
 .../devicetree/bindings/sound/renesas,fsi.yaml     |    60 +-
 .../bindings/sound/renesas,r9a09g047-sound.yaml    |   800 ++
 .../devicetree/bindings/sound/rockchip-spdif.yaml  |     2 +-
 .../devicetree/bindings/sound/spacemit,k1-i2s.yaml |    31 +-
 .../devicetree/bindings/sound/ti,tas2781.yaml      |     5 +
 .../devicetree/bindings/sound/ti,tas67524.yaml     |   280 +
 Documentation/sound/alsa-configuration.rst         |     4 +-
 Documentation/sound/codecs/index.rst               |     1 +
 Documentation/sound/codecs/tas675x.rst             |   820 ++
 Documentation/sound/soc/index.rst                  |     2 +-
 Documentation/sound/soc/platform.rst               |     2 +-
 Documentation/sound/soc/usb.rst                    |     4 +-
 MAINTAINERS                                        |    22 +-
 Makefile                                           |     5 +-
 arch/arm/Kconfig                                   |     2 +-
 arch/arm/boot/dts/gemini/gemini-sl93512r.dts       |     2 +-
 arch/arm/boot/dts/gemini/gemini-sq201.dts          |     2 +-
 arch/arm/boot/dts/microchip/sam9x7.dtsi            |     6 +-
 arch/arm/mach-pxa/pxa27x.c                         |     9 +-
 arch/arm/mach-socfpga/platsmp.c                    |     1 +
 arch/arm64/Makefile                                |     3 +
 arch/arm64/boot/dts/qcom/eliza.dtsi                |     6 +-
 arch/arm64/boot/dts/qcom/glymur.dtsi               |    20 +-
 arch/arm64/boot/dts/qcom/milos.dtsi                |     6 +-
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi        |     7 +-
 arch/arm64/configs/defconfig                       |     1 +
 arch/arm64/include/asm/kvm_nested.h                |     4 +-
 arch/arm64/kvm/at.c                                |     6 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |     2 +
 arch/arm64/kvm/hyp/pgtable.c                       |     4 +-
 arch/arm64/kvm/nested.c                            |    33 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |     6 +-
 arch/s390/configs/debug_defconfig                  |     4 +
 arch/s390/configs/defconfig                        |     4 +
 arch/s390/include/asm/bug.h                        |    12 +-
 arch/s390/include/asm/gmap_helpers.h               |     1 +
 arch/s390/include/asm/linkage.h                    |     2 +
 arch/s390/kvm/faultin.c                            |    30 +-
 arch/s390/kvm/gaccess.c                            |    11 +-
 arch/s390/kvm/gmap.c                               |    19 +-
 arch/s390/kvm/gmap.h                               |     3 +
 arch/s390/kvm/kvm-s390.c                           |    33 +-
 arch/s390/kvm/priv.c                               |     8 +-
 arch/s390/kvm/pv.c                                 |    21 +-
 arch/s390/mm/gmap_helpers.c                        |   128 +-
 arch/x86/Makefile                                  |     4 +
 arch/x86/Makefile.um                               |     8 +
 arch/x86/kernel/cpu/amd.c                          |     2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c              |     7 +-
 arch/x86/kvm/svm/sev.c                             |   238 +-
 arch/x86/kvm/svm/svm.h                             |     9 +-
 drivers/accel/ethosu/ethosu_gem.c                  |    35 +-
 drivers/accel/ivpu/ivpu_fw.c                       |    16 +
 drivers/accel/ivpu/ivpu_fw_log.c                   |     5 +
 drivers/accel/ivpu/ivpu_ms.c                       |     7 +
 drivers/auxdisplay/Kconfig                         |     2 +-
 drivers/auxdisplay/line-display.c                  |     2 +-
 drivers/auxdisplay/max6959.c                       |     5 +-
 drivers/firmware/samsung/exynos-acpm-dvfs.c        |     3 +
 drivers/firmware/samsung/exynos-acpm.c             |   141 +-
 drivers/gpio/gpiolib-of.c                          |     8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c          |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c        |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c          |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c          |    14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c         |    10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |    16 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |     5 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |     1 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |    49 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |     5 +
 drivers/gpu/drm/amd/display/dc/basics/vector.c     |     4 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |    15 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |    81 +-
 .../drm/amd/display/dc/bios/bios_parser_helper.h   |     5 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |     2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |    10 +-
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   |    10 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c    |     3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |    42 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |    32 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |     3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |     1 -
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |     8 +-
 drivers/gpu/drm/drm_dumb_buffers.c                 |     7 -
 drivers/gpu/drm/drm_gem.c                          |    75 +-
 drivers/gpu/drm/drm_ioctl.c                        |     3 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |    19 +-
 drivers/gpu/drm/i915/display/intel_plane.c         |    27 +
 drivers/gpu/drm/imx/dcss/dcss-scaler.c             |     3 +
 drivers/gpu/drm/v3d/v3d_gem.c                      |     8 +
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |    24 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |    17 +-
 drivers/gpu/drm/xe/xe_exec_queue.h                 |    17 -
 drivers/gpu/drm/xe/xe_guc_submit.c                 |    62 +-
 drivers/gpu/drm/xe/xe_hw_engine_group.c            |    10 +-
 drivers/gpu/drm/xe/xe_uc_fw.c                      |     1 -
 drivers/input/keyboard/atkbd.c                     |    15 +
 drivers/md/dm-cache-policy-smq.c                   |    12 +-
 drivers/memory/atmel-ebi.c                         |     3 +-
 drivers/mmc/core/mmc.c                             |     4 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |    17 +
 drivers/mmc/host/litex_mmc.c                       |    20 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |     1 +
 drivers/mmc/host/sdhci-msm.c                       |    10 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |    44 +-
 drivers/mmc/host/sdhci.c                           |     1 +
 drivers/net/bonding/bond_3ad.c                     |    18 +-
 drivers/net/bonding/bond_main.c                    |     4 +-
 drivers/net/bonding/bond_netlink.c                 |     4 +-
 drivers/net/bonding/bond_procfs.c                  |     8 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |     2 +-
 drivers/net/ethernet/amd/pcnet32.c                 |     4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    36 +-
 drivers/net/ethernet/freescale/fec_main.c          |     3 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |     1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |    36 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |     2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |     2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |     2 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |     6 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |    32 +
 drivers/net/ethernet/microchip/lan743x_main.h      |     1 +
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |     7 +-
 drivers/net/geneve.c                               |     2 +-
 drivers/net/phy/sfp.c                              |     1 +
 drivers/net/vxlan/vxlan_vnifilter.c                |     5 +-
 drivers/net/wireless/intel/iwlwifi/mld/ap.c        |     4 -
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |     7 +
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |     2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |     6 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |    56 +-
 drivers/ptp/ptp_vclock.c                           |    14 +-
 drivers/regulator/Kconfig                          |     1 +
 drivers/soc/imx/soc-imx8m.c                        |     2 +-
 drivers/soc/qcom/ice.c                             |    66 +-
 drivers/soundwire/bus.c                            |    28 +
 drivers/tee/optee/supp.c                           |   107 +-
 drivers/tee/qcomtee/core.c                         |     6 +-
 drivers/tee/tee_core.c                             |    56 +-
 drivers/tee/tee_shm.c                              |     2 +-
 drivers/ufs/host/ufs-qcom.c                        |    10 +-
 fs/erofs/zdata.c                                   |     6 +-
 fs/erofs/zmap.c                                    |     2 +-
 fs/fhandle.c                                       |    16 +-
 fs/fuse/dev.c                                      |    13 +-
 fs/iomap/buffered-io.c                             |    10 +-
 fs/mount.h                                         |    10 +-
 fs/namei.c                                         |    10 +
 fs/namespace.c                                     |     6 +-
 fs/nfs/write.c                                     |     2 +-
 fs/overlayfs/readdir.c                             |     7 +-
 fs/qnx6/dir.c                                      |     8 +-
 fs/smb/server/oplock.c                             |    15 +-
 fs/smb/server/smb2pdu.c                            |    11 +
 fs/smb/server/vfs_cache.c                          |    12 +-
 fs/xfs/scrub/cow_repair.c                          |    12 +-
 fs/xfs/xfs_ioctl.c                                 |    47 +-
 fs/xfs/xfs_mount.c                                 |     7 +-
 fs/xfs/xfs_pnfs.c                                  |    11 +-
 fs/xfs/xfs_reflink.c                               |    14 +-
 fs/xfs/xfs_zone_gc.c                               |     2 +-
 include/linux/cfi.h                                |     1 +
 include/linux/hugetlb.h                            |     8 -
 include/linux/mm.h                                 |     8 -
 include/linux/of.h                                 |     7 +
 include/linux/platform_data/asoc-pxa.h             |    23 +-
 include/linux/rseq_entry.h                         |     5 +-
 include/linux/soundwire/sdw.h                      |     8 +
 include/linux/tracepoint.h                         |     8 +
 include/net/act_api.h                              |     1 +
 include/net/bluetooth/l2cap.h                      |     1 +
 include/net/ip_vs.h                                |     3 +-
 include/net/mptcp.h                                |     7 +-
 include/net/tc_act/tc_pedit.h                      |     1 -
 include/sound/ac97/codec.h                         |     5 +-
 include/sound/ac97/controller.h                    |     5 +-
 include/sound/acp7x_chip_offset_byte.h             |  2519 ++++
 include/sound/cs35l56.h                            |     2 +
 include/sound/hda-mlink.h                          |     5 +-
 include/sound/pxa2xx-lib.h                         |    50 +-
 include/sound/sdca.h                               |     4 +
 include/sound/sdca_asoc.h                          |     6 +
 include/sound/sdca_function.h                      |     1 -
 include/sound/sdca_jack.h                          |     3 +
 include/sound/soc-card.h                           |     2 +
 include/sound/soc-component.h                      |     3 -
 include/sound/soc-dai.h                            |    22 +-
 include/sound/soc-dapm.h                           |     3 +
 include/sound/soc.h                                |    15 +-
 include/sound/soc_sdw_utils.h                      |    18 +
 include/sound/tas2781.h                            |     1 +
 include/uapi/linux/tee.h                           |     1 +
 io_uring/net.c                                     |     3 +-
 kernel/cgroup/cpuset.c                             |    13 +-
 kernel/futex/requeue.c                             |     6 +
 kernel/locking/rtmutex.c                           |     3 +
 kernel/locking/rtmutex_api.c                       |     2 +-
 kernel/pid.c                                       |     8 +-
 kernel/sched/ext.c                                 |    10 +-
 kernel/signal.c                                    |     1 +
 kernel/time/clockevents.c                          |     2 +-
 kernel/time/time.c                                 |     2 +-
 kernel/time/timer_migration.c                      |     8 +-
 kernel/trace/trace_probe.c                         |     2 -
 lib/vdso/datastore.c                               |     6 +-
 mm/cma.c                                           |     7 +-
 mm/cma_debug.c                                     |     3 +-
 mm/damon/ops-common.c                              |     4 +-
 mm/huge_memory.c                                   |     4 +-
 mm/hugetlb.c                                       |    69 +-
 mm/hugetlb_vmemmap.c                               |    36 +-
 mm/memcontrol.c                                    |     5 +-
 mm/memory-failure.c                                |    19 +-
 mm/userfaultfd.c                                   |    92 +-
 net/6lowpan/iphc.c                                 |     4 +-
 net/802/garp.c                                     |     2 +-
 net/802/mrp.c                                      |     9 +
 net/appletalk/aarp.c                               |     2 +-
 net/bluetooth/bnep/core.c                          |    57 +-
 net/bluetooth/hci_sync.c                           |     5 +
 net/bluetooth/hci_sysfs.c                          |     6 +-
 net/bluetooth/iso.c                                |    63 +-
 net/bluetooth/l2cap_core.c                         |    46 +
 net/bluetooth/mgmt.c                               |    17 +-
 net/bluetooth/rfcomm/core.c                        |    67 +-
 net/bluetooth/rfcomm/sock.c                        |    26 +-
 net/bluetooth/sco.c                                |    20 +-
 net/bridge/netfilter/ebt_snat.c                    |     3 +
 net/core/sock.c                                    |     8 +-
 net/devlink/core.c                                 |     2 +
 net/hsr/hsr_framereg.c                             |     4 +-
 net/ieee802154/6lowpan/tx.c                        |     5 +
 net/ipv4/inet_connection_sock.c                    |     6 +
 net/ipv4/ip_options.c                              |     4 +
 net/ipv4/udp.c                                     |     8 +
 net/ipv6/anycast.c                                 |    16 +-
 net/ipv6/mcast.c                                   |     8 +-
 net/ipv6/netfilter/nft_fib_ipv6.c                  |     3 +
 net/l2tp/l2tp_ppp.c                                |    82 +-
 net/mac80211/tx.c                                  |     4 +-
 net/mptcp/options.c                                |    79 +-
 net/mptcp/pm.c                                     |    15 +-
 net/mptcp/pm_userspace.c                           |    14 +-
 net/mptcp/protocol.c                               |    10 +
 net/mptcp/protocol.h                               |     7 +-
 net/mptcp/sockopt.c                                |    15 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |    13 +-
 net/netfilter/ipvs/ip_vs_sched.c                   |    14 +-
 net/netfilter/nf_conntrack_irc.c                   |     4 +-
 net/netfilter/nf_synproxy_core.c                   |    24 +-
 net/netfilter/nft_byteorder.c                      |    51 +-
 net/netfilter/nft_ct.c                             |     8 +-
 net/netfilter/nft_ct_fast.c                        |     2 +-
 net/netfilter/nft_tunnel.c                         |     2 +-
 net/netfilter/xt_NFQUEUE.c                         |     2 +-
 net/rds/ib_cm.c                                    |     1 +
 net/sched/act_api.c                                |     7 +-
 net/sched/act_pedit.c                              |    77 +-
 net/sctp/diag.c                                    |    17 +-
 net/sctp/sm_make_chunk.c                           |     5 +
 net/sctp/sm_statefuns.c                            |     6 +-
 net/unix/af_unix.c                                 |    11 +-
 net/vmw_vsock/vmci_transport.c                     |     4 +-
 net/wireless/nl80211.c                             |     9 +
 net/wireless/scan.c                                |     9 +-
 net/xdp/xsk.c                                      |    11 +-
 rust/helpers/vmalloc.c                             |     6 +
 scripts/Makefile.compiler                          |     2 +-
 scripts/generate_rust_target.rs                    |     8 +-
 .../kconfig/tests/err_repeated_inc/expected_stderr |     4 +-
 sound/ac97/bus.c                                   |    26 +-
 sound/arm/Kconfig                                  |     7 -
 sound/arm/Makefile                                 |     4 -
 sound/core/pcm_native.c                            |     7 +-
 sound/core/seq/seq_dummy.c                         |    15 +-
 sound/hda/codecs/side-codecs/cs35l41_hda_i2c.c     |     4 +-
 sound/hda/codecs/side-codecs/cs35l56_hda_i2c.c     |     8 +-
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c     |     4 +-
 sound/soc/amd/Kconfig                              |    10 +
 sound/soc/amd/Makefile                             |     1 +
 sound/soc/amd/acp/acp-sdw-legacy-mach.c            |     7 +-
 sound/soc/amd/acp/acp-sdw-sof-mach.c               |     7 +-
 sound/soc/amd/acp7x/Makefile                       |     5 +
 sound/soc/amd/acp7x/acp7x-common.c                 |   125 +
 sound/soc/amd/acp7x/acp7x.h                        |   110 +
 sound/soc/amd/acp7x/pci-acp7x.c                    |   168 +
 sound/soc/amd/ps/pci-ps.c                          |     3 +-
 sound/soc/amd/ps/ps-mach.c                         |     2 -
 sound/soc/amd/renoir/acp3x-rn.c                    |     2 -
 sound/soc/amd/yc/acp6x-mach.c                      |     2 -
 sound/soc/apple/mca.c                              |    14 +-
 sound/soc/atmel/atmel-classd.c                     |    41 +-
 sound/soc/atmel/mchp-spdifrx.c                     |    33 +-
 sound/soc/bcm/cygnus-ssp.c                         |    10 +-
 sound/soc/codecs/Kconfig                           |    40 +-
 sound/soc/codecs/Makefile                          |     8 +
 sound/soc/codecs/ad193x-i2c.c                      |     4 +-
 sound/soc/codecs/adau1372-i2c.c                    |     2 +-
 sound/soc/codecs/adau1372.c                        |     5 +
 sound/soc/codecs/adau1373.c                        |     2 +-
 sound/soc/codecs/adau1701.c                        |     8 +-
 sound/soc/codecs/adau1761-i2c.c                    |     8 +-
 sound/soc/codecs/adau1781-i2c.c                    |     4 +-
 sound/soc/codecs/adau1977-i2c.c                    |     6 +-
 sound/soc/codecs/adau7118-i2c.c                    |     4 +-
 sound/soc/codecs/adav803.c                         |     2 +-
 sound/soc/codecs/ak4118.c                          |     4 +-
 sound/soc/codecs/ak4535.c                          |     2 +-
 sound/soc/codecs/ak4613.c                          |     7 +-
 sound/soc/codecs/ak4619.c                          |    10 +-
 sound/soc/codecs/ak4642.c                          |     8 +-
 sound/soc/codecs/ak4671.c                          |     2 +-
 sound/soc/codecs/alc5623.c                         |     8 +-
 sound/soc/codecs/alc5632.c                         |     4 +-
 sound/soc/codecs/aw87390.c                         |     4 +-
 sound/soc/codecs/aw88081.c                         |    16 +-
 sound/soc/codecs/aw88166.c                         |     2 +-
 sound/soc/codecs/aw88261.c                         |   600 +-
 sound/soc/codecs/aw88261.h                         |   185 +-
 sound/soc/codecs/aw88395/aw88395.c                 |    13 +-
 sound/soc/codecs/aw88395/aw88395_device.h          |     2 +-
 sound/soc/codecs/aw88399.c                         |     2 +-
 sound/soc/codecs/cs-amp-lib.c                      |     5 +-
 sound/soc/codecs/cs35l32.c                         |     4 +-
 sound/soc/codecs/cs35l33.c                         |     4 +-
 sound/soc/codecs/cs35l34.c                         |     4 +-
 sound/soc/codecs/cs35l35.c                         |     4 +-
 sound/soc/codecs/cs35l36.c                         |     4 +-
 sound/soc/codecs/cs35l41-i2c.c                     |    10 +-
 sound/soc/codecs/cs35l45-i2c.c                     |     4 +-
 sound/soc/codecs/cs35l56-i2c.c                     |     6 +-
 sound/soc/codecs/cs35l56-sdw.c                     |   231 +-
 sound/soc/codecs/cs35l56-shared-test.c             |     6 +
 sound/soc/codecs/cs35l56-shared.c                  |     6 +-
 sound/soc/codecs/cs35l56.c                         |    91 +-
 sound/soc/codecs/cs35l56.h                         |     7 +-
 sound/soc/codecs/cs4265.c                          |     2 +-
 sound/soc/codecs/cs4270.c                          |     4 +-
 sound/soc/codecs/cs4271-i2c.c                      |     2 +-
 sound/soc/codecs/cs42l42-i2c.c                     |     4 +-
 sound/soc/codecs/cs42l42-sdw.c                     |    11 +-
 sound/soc/codecs/cs42l43-jack.c                    |     5 +-
 sound/soc/codecs/cs42l51-i2c.c                     |     2 +-
 sound/soc/codecs/cs42l52.c                         |     2 +-
 sound/soc/codecs/cs42l56.c                         |     2 +-
 sound/soc/codecs/cs42l73.c                         |     4 +-
 sound/soc/codecs/cs42l84.c                         |     4 +-
 sound/soc/codecs/cs42xx8-i2c.c                     |     6 +-
 sound/soc/codecs/cs42xx8-spi.c                     |   104 +
 sound/soc/codecs/cs42xx8.c                         |     3 +
 sound/soc/codecs/cs43130.c                         |    10 +-
 sound/soc/codecs/cs4341.c                          |     2 +-
 sound/soc/codecs/cs4349.c                          |     4 +-
 sound/soc/codecs/cs530x-i2c.c                      |    14 +-
 sound/soc/codecs/cs53l30.c                         |     4 +-
 sound/soc/codecs/cx20442.c                         |    11 +-
 sound/soc/codecs/cx20442.h                         |     5 +
 sound/soc/codecs/cx2072x.c                         |     6 +-
 sound/soc/codecs/da7210.c                          |     2 +-
 sound/soc/codecs/da7213.c                          |     7 +-
 sound/soc/codecs/da7218.c                          |     4 +-
 sound/soc/codecs/da7219.c                          |     2 +-
 sound/soc/codecs/da732x.c                          |     2 +-
 sound/soc/codecs/da9055.c                          |     2 +-
 sound/soc/codecs/es8311.c                          |     2 +-
 sound/soc/codecs/es8316.c                          |     4 +-
 sound/soc/codecs/es8323.c                          |     2 +-
 sound/soc/codecs/es8326.c                          |     4 +-
 sound/soc/codecs/es8328-i2c.c                      |     4 +-
 sound/soc/codecs/es8375.c                          |     2 +-
 sound/soc/codecs/es8389.c                          |     2 +-
 sound/soc/codecs/es9356.c                          |  1142 ++
 sound/soc/codecs/es9356.h                          |   208 +
 sound/soc/codecs/framer-codec.c                    |     8 +-
 sound/soc/codecs/fs210x.c                          |     6 +-
 sound/soc/codecs/hdac_hdmi.c                       |     4 +-
 sound/soc/codecs/idt821034.c                       |     9 +-
 sound/soc/codecs/isabelle.c                        |     2 +-
 sound/soc/codecs/lm4857.c                          |     2 +-
 sound/soc/codecs/lm49453.c                         |     2 +-
 sound/soc/codecs/max9768.c                         |     2 +-
 sound/soc/codecs/max98088.c                        |     4 +-
 sound/soc/codecs/max98090.c                        |    14 +-
 sound/soc/codecs/max98090.h                        |     3 -
 sound/soc/codecs/max98095.c                        |     2 +-
 sound/soc/codecs/max98363.c                        |    17 +-
 sound/soc/codecs/max98371.c                        |     2 +-
 sound/soc/codecs/max98373-i2c.c                    |     4 +-
 sound/soc/codecs/max98373-sdw.c                    |    18 +-
 sound/soc/codecs/max98388.c                        |     4 +-
 sound/soc/codecs/max98390.c                        |     4 +-
 sound/soc/codecs/max98396.c                        |     6 +-
 sound/soc/codecs/max9850.c                         |     2 +-
 sound/soc/codecs/max98504.c                        |     2 +-
 sound/soc/codecs/max98520.c                        |     4 +-
 sound/soc/codecs/max9860.c                         |     2 +-
 sound/soc/codecs/max9867.c                         |     2 +-
 sound/soc/codecs/max9877.c                         |     2 +-
 sound/soc/codecs/max98925.c                        |     2 +-
 sound/soc/codecs/max98926.c                        |     2 +-
 sound/soc/codecs/max98927.c                        |     4 +-
 sound/soc/codecs/ml26124.c                         |     2 +-
 sound/soc/codecs/mt6660.c                          |     4 +-
 sound/soc/codecs/nau8325.c                         |     2 +-
 sound/soc/codecs/nau8540.c                         |     2 +-
 sound/soc/codecs/nau8810.c                         |     6 +-
 sound/soc/codecs/nau8821.c                         |     2 +-
 sound/soc/codecs/nau8822.c                         |    48 +-
 sound/soc/codecs/nau8822.h                         |     3 +
 sound/soc/codecs/nau8824.c                         |     2 +-
 sound/soc/codecs/nau8825.c                         |    14 +-
 sound/soc/codecs/ntp8835.c                         |     4 +-
 sound/soc/codecs/ntp8918.c                         |     4 +-
 sound/soc/codecs/pcm1681.c                         |     4 +-
 sound/soc/codecs/pcm1789-i2c.c                     |     2 +-
 sound/soc/codecs/pcm179x-i2c.c                     |     2 +-
 sound/soc/codecs/pcm186x-i2c.c                     |     8 +-
 sound/soc/codecs/pcm3168a-i2c.c                    |     2 +-
 sound/soc/codecs/pcm3168a.c                        |    30 +-
 sound/soc/codecs/pcm512x-i2c.c                     |    14 +-
 sound/soc/codecs/pcm6240.c                         |    80 +-
 sound/soc/codecs/pcm6240.h                         |     2 +-
 sound/soc/codecs/peb2466.c                         |     9 +-
 sound/soc/codecs/pm4125.c                          |    11 +-
 sound/soc/codecs/rk3328_codec.c                    |    54 +-
 sound/soc/codecs/rt1011.c                          |     2 +-
 sound/soc/codecs/rt1015.c                          |     2 +-
 sound/soc/codecs/rt1016.c                          |     2 +-
 sound/soc/codecs/rt1017-sdca-sdw.c                 |    18 +-
 sound/soc/codecs/rt1019.c                          |     2 +-
 sound/soc/codecs/rt1305.c                          |     4 +-
 sound/soc/codecs/rt1308-sdw.c                      |    18 +-
 sound/soc/codecs/rt1308.c                          |     2 +-
 sound/soc/codecs/rt1316-sdw.c                      |    18 +-
 sound/soc/codecs/rt1318-sdw.c                      |    16 +-
 sound/soc/codecs/rt1318.c                          |     2 +-
 sound/soc/codecs/rt1320-sdw.c                      |    16 +-
 sound/soc/codecs/rt274.c                           |     4 +-
 sound/soc/codecs/rt286.c                           |     6 +-
 sound/soc/codecs/rt298.c                           |     4 +-
 sound/soc/codecs/rt5514.c                          |     2 +-
 sound/soc/codecs/rt5575.c                          |     2 +-
 sound/soc/codecs/rt5616.c                          |     6 +-
 sound/soc/codecs/rt5631.c                          |    10 +-
 sound/soc/codecs/rt5640.c                          |    43 +-
 sound/soc/codecs/rt5645.c                          |     4 +-
 sound/soc/codecs/rt5651.c                          |     2 +-
 sound/soc/codecs/rt5659.c                          |     4 +-
 sound/soc/codecs/rt5660.c                          |     2 +-
 sound/soc/codecs/rt5663.c                          |     4 +-
 sound/soc/codecs/rt5665.c                          |     4 +-
 sound/soc/codecs/rt5668.c                          |     4 +-
 sound/soc/codecs/rt5670.c                          |     6 +-
 sound/soc/codecs/rt5677.c                          |     2 +-
 sound/soc/codecs/rt5682-i2c.c                      |     4 +-
 sound/soc/codecs/rt5682-sdw.c                      |    16 +-
 sound/soc/codecs/rt5682.c                          |    14 +-
 sound/soc/codecs/rt5682s.c                         |     4 +-
 sound/soc/codecs/rt700-sdw.c                       |    18 +-
 sound/soc/codecs/rt711-sdca-sdw.c                  |    16 +-
 sound/soc/codecs/rt711-sdw.c                       |    14 +-
 sound/soc/codecs/rt712-sdca-dmic.c                 |    19 +-
 sound/soc/codecs/rt712-sdca-sdw.c                  |    16 +-
 sound/soc/codecs/rt715-sdca-sdw.c                  |    18 +-
 sound/soc/codecs/rt715-sdw.c                       |    18 +-
 sound/soc/codecs/rt721-sdca-sdw.c                  |    16 +-
 sound/soc/codecs/rt722-sdca-sdw.c                  |    55 +-
 sound/soc/codecs/rt722-sdca.c                      |   369 +-
 sound/soc/codecs/rt722-sdca.h                      |    27 +
 sound/soc/codecs/sgtl5000.c                        |     4 +-
 sound/soc/codecs/sigmadsp.c                        |     4 +-
 sound/soc/codecs/simple-amplifier.c                |   918 +-
 sound/soc/codecs/sma1303.c                         |     4 +-
 sound/soc/codecs/sma1307.c                         |    39 +-
 sound/soc/codecs/src4xxx-i2c.c                     |     2 +-
 sound/soc/codecs/ssm2518.c                         |     2 +-
 sound/soc/codecs/ssm2602-i2c.c                     |     6 +-
 sound/soc/codecs/ssm4567.c                         |     2 +-
 sound/soc/codecs/sta32x.c                          |     6 +-
 sound/soc/codecs/sta350.c                          |     8 +-
 sound/soc/codecs/sta529.c                          |     2 +-
 sound/soc/codecs/tac5xx2-sdw.c                     |  2037 ++++
 sound/soc/codecs/tac5xx2.h                         |   259 +
 sound/soc/codecs/tas2552.c                         |     2 +-
 sound/soc/codecs/tas2562.c                         |     6 +-
 sound/soc/codecs/tas2764.c                         |     2 +-
 sound/soc/codecs/tas2770.c                         |     2 +-
 sound/soc/codecs/tas2780.c                         |     2 +-
 sound/soc/codecs/tas2781-i2c.c                     |    49 +-
 sound/soc/codecs/tas2783-sdw.c                     |    26 +-
 sound/soc/codecs/tas2783.h                         |     8 -
 sound/soc/codecs/tas5086.c                         |    12 +-
 sound/soc/codecs/tas571x.c                         |    14 +-
 sound/soc/codecs/tas5720.c                         |     6 +-
 sound/soc/codecs/tas5805m.c                        |     2 +-
 sound/soc/codecs/tas6424.c                         |     2 +-
 sound/soc/codecs/tas675x.c                         |  2194 ++++
 sound/soc/codecs/tas675x.h                         |   367 +
 sound/soc/codecs/tda7419.c                         |     2 +-
 sound/soc/codecs/tfa9879.c                         |     2 +-
 sound/soc/codecs/tlv320adc3xxx.c                   |     6 +-
 sound/soc/codecs/tlv320adcx140.c                   |     8 +-
 sound/soc/codecs/tlv320aic23-i2c.c                 |     4 +-
 sound/soc/codecs/tlv320aic31xx.c                   |    16 +-
 sound/soc/codecs/tlv320aic32x4-i2c.c               |     6 +-
 sound/soc/codecs/tlv320aic3x-i2c.c                 |    10 +-
 sound/soc/codecs/tlv320aic3x.c                     |     7 +
 sound/soc/codecs/ts3a227e.c                        |     2 +-
 sound/soc/codecs/tscs42xx.c                        |     4 +-
 sound/soc/codecs/tscs454.c                         |     2 +-
 sound/soc/codecs/uda1342.c                         |     2 +-
 sound/soc/codecs/uda1380.c                         |    15 +-
 sound/soc/codecs/wcd937x.c                         |    11 +-
 sound/soc/codecs/wcd938x.c                         |    11 +-
 sound/soc/codecs/wcd939x.c                         |    11 +-
 sound/soc/codecs/wm1250-ev1.c                      |     2 +-
 sound/soc/codecs/wm2000.c                          |     2 +-
 sound/soc/codecs/wm2200.c                          |     2 +-
 sound/soc/codecs/wm5100.c                          |     2 +-
 sound/soc/codecs/wm8510.c                          |     2 +-
 sound/soc/codecs/wm8523.c                          |     2 +-
 sound/soc/codecs/wm8580.c                          |     4 +-
 sound/soc/codecs/wm8711.c                          |     2 +-
 sound/soc/codecs/wm8728.c                          |     2 +-
 sound/soc/codecs/wm8731-i2c.c                      |     2 +-
 sound/soc/codecs/wm8737.c                          |     2 +-
 sound/soc/codecs/wm8741.c                          |     2 +-
 sound/soc/codecs/wm8750.c                          |     4 +-
 sound/soc/codecs/wm8753.c                          |     2 +-
 sound/soc/codecs/wm8776.c                          |     4 +-
 sound/soc/codecs/wm8804-i2c.c                      |     2 +-
 sound/soc/codecs/wm8900.c                          |     8 +-
 sound/soc/codecs/wm8903.c                          |     2 +-
 sound/soc/codecs/wm8904.c                          |     6 +-
 sound/soc/codecs/wm8940.c                          |     2 +-
 sound/soc/codecs/wm8955.c                          |     2 +-
 sound/soc/codecs/wm8960.c                          |     2 +-
 sound/soc/codecs/wm8961.c                          |     2 +-
 sound/soc/codecs/wm8962.c                          |     2 +-
 sound/soc/codecs/wm8971.c                          |     2 +-
 sound/soc/codecs/wm8974.c                          |     2 +-
 sound/soc/codecs/wm8978.c                          |     2 +-
 sound/soc/codecs/wm8983.c                          |     2 +-
 sound/soc/codecs/wm8985.c                          |     4 +-
 sound/soc/codecs/wm8988.c                          |     2 +-
 sound/soc/codecs/wm8990.c                          |     2 +-
 sound/soc/codecs/wm8991.c                          |     2 +-
 sound/soc/codecs/wm8993.c                          |     2 +-
 sound/soc/codecs/wm8995.c                          |     4 +-
 sound/soc/codecs/wm8996.c                          |     2 +-
 sound/soc/codecs/wm9081.c                          |     8 +-
 sound/soc/codecs/wm9090.c                          |     4 +-
 sound/soc/codecs/wm_adsp.c                         |     7 +
 sound/soc/codecs/wsa881x.c                         |    45 +-
 sound/soc/fsl/Kconfig                              |     7 +-
 sound/soc/fsl/eukrea-tlv320.c                      |    11 +-
 sound/soc/fsl/fsl-asoc-card.c                      |   111 +-
 sound/soc/fsl/fsl_audmix.c                         |     6 +
 sound/soc/fsl/fsl_micfil.c                         |    79 +
 sound/soc/fsl/fsl_micfil.h                         |     1 +
 sound/soc/fsl/fsl_qmc_audio.c                      |     7 +-
 sound/soc/fsl/fsl_sai.c                            |     7 +-
 sound/soc/fsl/fsl_sai.h                            |     2 +
 sound/soc/fsl/imx-pcm-rpmsg.c                      |    12 +-
 sound/soc/fsl/imx-rpmsg.c                          |    38 +-
 sound/soc/generic/audio-graph-card2.c              |    12 +
 sound/soc/generic/simple-card.c                    |    61 +-
 sound/soc/generic/test-component.c                 |     7 -
 sound/soc/hisilicon/hi6210-i2s.c                   |     6 +-
 sound/soc/img/img-spdif-in.c                       |    70 +-
 sound/soc/img/img-spdif-out.c                      |    16 +-
 sound/soc/intel/boards/Kconfig                     |     1 +
 sound/soc/intel/boards/cht_bsw_rt5672.c            |    73 +-
 sound/soc/intel/boards/sof_sdw.c                   |    23 +-
 sound/soc/intel/catpt/Makefile                     |     3 +-
 sound/soc/intel/catpt/core.h                       |     1 -
 sound/soc/intel/catpt/device.c                     |    14 +-
 sound/soc/intel/catpt/dsp.c                        |    19 +-
 sound/soc/intel/catpt/ipc.c                        |    17 +-
 sound/soc/intel/catpt/loader.c                     |    10 +-
 sound/soc/intel/catpt/pcm.c                        |    63 +-
 sound/soc/intel/catpt/registers.h                  |    14 +
 sound/soc/intel/catpt/trace.c                      |    27 +
 sound/soc/intel/catpt/trace.h                      |    22 +-
 sound/soc/intel/common/soc-acpi-intel-arl-match.c  |    52 +
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c  |   132 +
 sound/soc/intel/common/sof-function-topology-lib.c |    11 +-
 sound/soc/loongson/Makefile                        |     4 +-
 sound/soc/loongson/loongson_dma.c                  |   148 +-
 sound/soc/loongson/loongson_dma.h                  |     6 +-
 sound/soc/loongson/loongson_i2s.c                  |    56 +-
 sound/soc/loongson/loongson_i2s.h                  |     7 +-
 sound/soc/loongson/loongson_i2s_pci.c              |    59 +-
 sound/soc/loongson/loongson_i2s_plat.c             |    67 +-
 sound/soc/mediatek/Kconfig                         |    40 +
 sound/soc/mediatek/Makefile                        |     1 +
 sound/soc/mediatek/common/mtk-afe-fe-dai.c         |     8 +-
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |    56 +-
 .../soc/mediatek/common/mtk-afe-platform-driver.h  |     2 +
 sound/soc/mediatek/common/mtk-btcvsd.c             |    81 +-
 sound/soc/mediatek/common/mtk-dsp-sof-common.c     |    13 +-
 sound/soc/mediatek/common/mtk-dsp-sof-common.h     |     5 +-
 sound/soc/mediatek/common/mtk-soundcard-driver.c   |    22 +-
 sound/soc/mediatek/mt2701/Makefile                 |     1 +
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |    26 +-
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |     8 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         |   305 +-
 sound/soc/mediatek/mt2701/mt2701-hdmi.c            |   114 +
 sound/soc/mediatek/mt2701/mt2701-reg.h             |    29 +
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |    39 +-
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |     4 +-
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         |    23 +-
 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c        |    13 +-
 sound/soc/mediatek/mt8186/mt8186-mt6366-common.c   |     6 +-
 sound/soc/mediatek/mt8186/mt8186-mt6366-common.h   |     2 +-
 sound/soc/mediatek/mt8186/mt8186-mt6366.c          |    18 +-
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c         |    29 +-
 sound/soc/mediatek/mt8189/mt8189-afe-pcm.c         |    38 +-
 sound/soc/mediatek/mt8192/mt8192-afe-gpio.c        |     4 +-
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c         |    21 +-
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c         |    42 +-
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c        |    16 +-
 sound/soc/mediatek/mt8196/Makefile                 |    14 +
 sound/soc/mediatek/mt8196/mt8196-afe-clk.c         |   581 +
 sound/soc/mediatek/mt8196/mt8196-afe-clk.h         |    64 +
 sound/soc/mediatek/mt8196/mt8196-afe-common.h      |   205 +
 sound/soc/mediatek/mt8196/mt8196-afe-pcm.c         |  2519 ++++
 sound/soc/mediatek/mt8196/mt8196-dai-adda.c        |   845 ++
 sound/soc/mediatek/mt8196/mt8196-dai-i2s.c         |  2613 ++++
 sound/soc/mediatek/mt8196/mt8196-dai-tdm.c         |   675 ++
 sound/soc/mediatek/mt8196/mt8196-interconnection.h |   121 +
 sound/soc/mediatek/mt8196/mt8196-nau8825.c         |   870 ++
 sound/soc/mediatek/mt8196/mt8196-reg.h             | 12068 +++++++++++++++++++
 sound/soc/mediatek/mt8365/mt8365-afe-clk.c         |    30 +-
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c         |    13 +-
 sound/soc/mediatek/mt8365/mt8365-dai-adda.c        |    10 +-
 sound/soc/mediatek/mt8365/mt8365-dai-i2s.c         |     5 +-
 sound/soc/mediatek/mt8365/mt8365-mt6357.c          |    10 +-
 sound/soc/meson/aiu-acodec-ctrl.c                  |     3 +
 sound/soc/meson/aiu-codec-ctrl.c                   |     3 +
 sound/soc/meson/axg-tdm-formatter.c                |    22 +-
 sound/soc/pxa/Kconfig                              |     6 +
 sound/soc/pxa/Makefile                             |     4 +-
 sound/soc/pxa/mmp-sspa.c                           |     2 +-
 sound/soc/pxa/pxa-ssp.c                            |     2 +-
 sound/{arm => soc/pxa}/pxa2xx-ac97-lib.c           |    39 +-
 sound/{arm => soc/pxa}/pxa2xx-ac97-regs.h          |     0
 sound/soc/pxa/pxa2xx-ac97.c                        |     6 +-
 sound/soc/pxa/pxa2xx-i2s.c                         |     2 +-
 sound/soc/pxa/pxa2xx-lib.h                         |    45 +
 sound/{arm => soc/pxa}/pxa2xx-pcm-lib.c            |    26 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |     3 +-
 sound/soc/qcom/common.c                            |    47 +-
 sound/soc/qcom/qdsp6/audioreach.c                  |    79 +-
 sound/soc/qcom/qdsp6/audioreach.h                  |    96 +
 sound/soc/qcom/qdsp6/q6apm-dai.c                   |   144 +-
 sound/soc/qcom/qdsp6/q6apm.c                       |   222 +-
 sound/soc/qcom/qdsp6/q6apm.h                       |    13 +-
 sound/soc/renesas/fsi.c                            |   288 +-
 sound/soc/renesas/rcar/adg.c                       |   168 +-
 sound/soc/renesas/rcar/cmd.c                       |     2 +-
 sound/soc/renesas/rcar/core.c                      |   173 +-
 sound/soc/renesas/rcar/ctu.c                       |    29 +-
 sound/soc/renesas/rcar/dma.c                       |   280 +-
 sound/soc/renesas/rcar/dvc.c                       |    29 +-
 sound/soc/renesas/rcar/gen.c                       |   180 +
 sound/soc/renesas/rcar/mix.c                       |    29 +-
 sound/soc/renesas/rcar/msiof.c                     |     5 -
 sound/soc/renesas/rcar/rsnd.h                      |    73 +-
 sound/soc/renesas/rcar/src.c                       |    91 +-
 sound/soc/renesas/rcar/ssi.c                       |    49 +-
 sound/soc/renesas/rcar/ssiu.c                      |    92 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |     2 +-
 sound/soc/rockchip/rockchip_i2s.c                  |   230 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c              |    10 +-
 sound/soc/rockchip/rockchip_pdm.c                  |    16 +-
 sound/soc/rockchip/rockchip_sai.c                  |   262 +-
 sound/soc/rockchip/rockchip_spdif.c                |    11 +-
 sound/soc/samsung/i2s.c                            |   118 +-
 sound/soc/samsung/idma.c                           |    26 +-
 sound/soc/samsung/odroid.c                         |    21 +-
 sound/soc/samsung/pcm.c                            |    99 +-
 sound/soc/samsung/spdif.c                          |    25 +-
 sound/soc/sdca/Kconfig                             |     2 +-
 sound/soc/sdca/sdca_asoc.c                         |   106 +-
 sound/soc/sdca/sdca_class.c                        |    60 +-
 sound/soc/sdca/sdca_class.h                        |     4 -
 sound/soc/sdca/sdca_class_function.c               |    23 +-
 sound/soc/sdca/sdca_functions.c                    |    51 +-
 sound/soc/sdca/sdca_interrupts.c                   |     3 +-
 sound/soc/sdca/sdca_jack.c                         |    76 +-
 sound/soc/sdw_utils/Makefile                       |     1 +
 sound/soc/sdw_utils/soc_sdw_es9356.c               |   230 +
 sound/soc/sdw_utils/soc_sdw_ti_amp.c               |   134 +-
 sound/soc/sdw_utils/soc_sdw_utils.c                |   309 +-
 sound/soc/soc-card.c                               |    13 +
 sound/soc/soc-core.c                               |   349 +-
 sound/soc/soc-dai.c                                |   225 +-
 sound/soc/soc-dapm.c                               |   109 +-
 sound/soc/soc-devres.c                             |    28 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |     5 +-
 sound/soc/soc-ops.c                                |     4 +
 sound/soc/soc-pcm.c                                |   119 +
 sound/soc/soc-topology.c                           |    37 +-
 sound/soc/soc-utils.c                              |     7 -
 sound/soc/sof/amd/acp-common.c                     |     3 +-
 sound/soc/sof/intel/Kconfig                        |     6 +-
 sound/soc/sof/intel/hda-mlink.c                    |    11 +-
 sound/soc/sof/intel/hda.c                          |    14 +-
 sound/soc/sof/intel/lnl.c                          |    40 +-
 sound/soc/sof/ipc3-control.c                       |    79 +-
 sound/soc/sof/ipc3-topology.c                      |    10 +-
 sound/soc/sof/ipc4-control.c                       |   124 +-
 sound/soc/sof/ipc4-topology.c                      |   151 +-
 sound/soc/sof/nocodec.c                            |     4 +-
 sound/soc/sof/topology.c                           |    71 +-
 sound/soc/spacemit/k1_i2s.c                        |    36 +-
 sound/soc/sprd/sprd-mcdt.c                         |    66 +-
 sound/soc/sti/uniperif_player.c                    |    73 +-
 sound/soc/sti/uniperif_reader.c                    |    20 +-
 sound/soc/stm/stm32_adfsdm.c                       |    29 +-
 sound/soc/stm/stm32_i2s.c                          |    67 +-
 sound/soc/stm/stm32_sai_sub.c                      |    29 +-
 sound/soc/stm/stm32_spdifrx.c                      |    44 +-
 sound/soc/tegra/tegra20_ac97.c                     |     2 +-
 sound/soc/tegra/tegra20_das.c                      |     2 +-
 sound/soc/tegra/tegra20_i2s.c                      |     2 +-
 sound/soc/tegra/tegra210_admaif.c                  |    28 +-
 sound/soc/tegra/tegra210_admaif.h                  |     2 +-
 sound/soc/tegra/tegra210_adx.c                     |    91 +-
 sound/soc/tegra/tegra210_adx.h                     |     5 +-
 sound/soc/tegra/tegra210_ahub.c                    |     4 +-
 sound/soc/tegra/tegra210_amx.c                     |    82 +-
 sound/soc/tegra/tegra210_amx.h                     |     5 +-
 sound/soc/tegra/tegra210_mixer.c                   |   288 +-
 sound/soc/tegra/tegra210_mixer.h                   |    21 +-
 sound/soc/tegra/tegra210_mvc.c                     |     3 +
 sound/soc/tegra/tegra30_ahub.c                     |     2 +-
 sound/soc/tegra/tegra30_i2s.c                      |     2 +-
 sound/soc/tegra/tegra_isomgr_bw.c                  |    20 +-
 sound/soc/ti/ams-delta.c                           |    47 +-
 sound/soc/ti/davinci-mcasp.c                       |   183 +-
 sound/soc/ti/j721e-evm.c                           |    47 +-
 sound/soc/ti/omap-dmic.c                           |    44 +-
 sound/soc/ti/omap-hdmi.c                           |    18 +-
 sound/soc/ti/omap-mcbsp-st.c                       |    26 +-
 sound/soc/ti/omap-mcbsp.c                          |    92 +-
 sound/soc/ti/omap-mcpdm.c                          |     8 +-
 sound/soc/ti/omap3pandora.c                        |     5 +-
 sound/soc/ti/rx51.c                                |     4 +-
 sound/soc/uniphier/aio-compress.c                  |    24 +-
 sound/soc/uniphier/aio-dma.c                       |    52 +-
 sound/soc/ux500/mop500_ab8500.c                    |    24 +-
 sound/usb/mixer.c                                  |    33 +-
 sound/usb/quirks.c                                 |     2 +
 tools/sched_ext/scx_show_state.py                  |    19 +-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh  |    10 +
 .../test.d/dynevent/eprobes_syntax_errors.tc       |     2 +-
 tools/testing/selftests/kselftest_harness.h        |     1 +
 tools/testing/selftests/net/Makefile               |     1 +
 tools/testing/selftests/net/af_unix/scm_inq.c      |    54 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |     4 +
 .../selftests/net/test_vxlan_vnifilter_notify.sh   |   184 +
 virt/kvm/kvm_main.c                                |     3 +-
 804 files changed, 44580 insertions(+), 6024 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/cdns,xtfpga-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cdns,xtfpga-i2s.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/gpio-audio-amp.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt2701-hdmi-audio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt6351-sound.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8196-afe.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8196-nau8825.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mt6351.txt
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,r9a09g047-sound.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,tas67524.yaml
 create mode 100644 Documentation/sound/codecs/tas675x.rst
 create mode 100644 include/sound/acp7x_chip_offset_byte.h
 create mode 100644 sound/soc/amd/acp7x/Makefile
 create mode 100644 sound/soc/amd/acp7x/acp7x-common.c
 create mode 100644 sound/soc/amd/acp7x/acp7x.h
 create mode 100644 sound/soc/amd/acp7x/pci-acp7x.c
 create mode 100644 sound/soc/codecs/cs42xx8-spi.c
 create mode 100644 sound/soc/codecs/es9356.c
 create mode 100644 sound/soc/codecs/es9356.h
 create mode 100644 sound/soc/codecs/tac5xx2-sdw.c
 create mode 100644 sound/soc/codecs/tac5xx2.h
 create mode 100644 sound/soc/codecs/tas675x.c
 create mode 100644 sound/soc/codecs/tas675x.h
 create mode 100644 sound/soc/intel/catpt/trace.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-hdmi.c
 create mode 100644 sound/soc/mediatek/mt8196/Makefile
 create mode 100644 sound/soc/mediatek/mt8196/mt8196-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8196/mt8196-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8196/mt8196-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8196/mt8196-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8196/mt8196-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8196/mt8196-dai-i2s.c
 create mode 100644 sound/soc/mediatek/mt8196/mt8196-dai-tdm.c
 create mode 100644 sound/soc/mediatek/mt8196/mt8196-interconnection.h
 create mode 100644 sound/soc/mediatek/mt8196/mt8196-nau8825.c
 create mode 100644 sound/soc/mediatek/mt8196/mt8196-reg.h
 rename sound/{arm => soc/pxa}/pxa2xx-ac97-lib.c (91%)
 rename sound/{arm => soc/pxa}/pxa2xx-ac97-regs.h (100%)
 create mode 100644 sound/soc/pxa/pxa2xx-lib.h
 rename sound/{arm => soc/pxa}/pxa2xx-pcm-lib.c (86%)
 create mode 100644 sound/soc/sdw_utils/soc_sdw_es9356.c
 create mode 100755 tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh
