From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [RFC v2] ASoC: Topology File format
Date: Fri, 24 Apr 2015 01:24:12 +0100
Message-ID: <1429835052.2702.28.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 72F8526041D
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 02:24:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Here's V2 of the file format the userspace topology tool will read to
generate the binary output file. The output file uses the topology UAPI
structures to represent the objects in the text file. This is still WiP
and is based on the UCM file format from Jaroslav.

Changes from V1.

 o Added BE's and Codec <-> codec links
 o Added enumerated and binary controls
 o Added private data
 o Moved object names from name field into object top level (like
section names).
 o Control ops binding changed to string+number

# Firmware Topology Configuration for Broadwell

# TLV scale used by both global and stream volumes
SectionTLV."hsw_vol_tlv" {

	DBScale [
		min "-9000"
		step "300"
		mute "1"
	]
}

# Values for Equalizer 1
SectionText."EQU1" {
	Values [
		"100Hz", "200Hz", "1kHz"
	]
}

# Private data for Equalizer 1
SectionData."EQU1" {
	file "/path/to/file"
};

# Values for Input Muxes 1,2,3
SectionText."In1" {
	Values [
		"Line", "Mic",
	]
}

# Controls from default pipeline
SectionControl."Default Pipeline" {

	# All controls in this section belong to this Index group/pipeline
	Index "1"

	# Master DSP volume
	Mixer."Master Playback Volume" [

		# Channel register and shift for Front Left/Right
		Channel."FL" [
			reg "0"
			shift "0"
		]
		Channel."FR" [
			reg "0"
			shift "8"
		]

		# max control value and whether value is inverted
		max "31"
		invert "false"

		# control uses bespoke driver get/put/info ID 0
		ops "DRV0"

		# uses TLV data above
		tlv_array "hsw_vol_tlv"
	]

	# Offload 0 volume
	Mixer."Media0 Playback Volume" [

		# Channel register and shift for Front Left/Right
		Channel."FL" [
			reg "1"
			shift "0"
		]
		Channel."FR" [
			reg "1"
			shift "8"
		]

		# max control value and whether value is inverted
		max "31"
		invert "false"

		# control uses bespoke driver get/put/info ID 0
		ops "DRV0"

		# uses TLV data above
		tlv_array "hsw_vol_tlv"
	]

	# Enum controls
	Enum."Equ1" [
		# Texts for enum
		texts "EQU1"

		# Channel register and shift for Front Left/Right
		Channel."FL" [
			reg "2"
			shift "0"
		]
		Channel."FR" [
			reg "1"
			shift "8"
		]

		# control uses bespoke driver get/put/info ID 1
		ops "DRV1"

		# Private data for this control
		data "EQU1"
	]

	Enum."Input Select" [
		# Texts for enum
		texts "In1"

		# Channel register and shift for Front Left/Right
		Channel."FL" [
			reg "2"
			shift "0"
		]
		Channel."FR" [
			reg "1"
			shift "8"
		]

		# control uses bespoke driver get/put/info ID 1
		ops "DRV2"
	]

	# Byte controls
	Bytes [
		base "0"
		num_regs "16"
		mask "0xff"
	]
}

# DAPM Widgets for main pipeline
SectionWidget."Pipeline1" {

	# All controls in this section belong to this Index group/pipeline
	Index "1"

	# SSP AIF input
	AIF_IN."SSP0 CODEC IN" [
		no_pm "true"
	]

	# SSP AIF output
	AIF_OUT."SSP0 CODEC OUT" [
		no_pm "true"
	]

	# Virtual playback mixer 
	MIXER."Playback VMixer" [
		no_pm "true"
	]

	# Test input mux
	MUX."Capture Select" [
		no_pm "true"
		enum "Input Select"
	]
}

# DAPM Routes
SectionGraph."Pipeline 1 Graph" {

	Index "1"

	Routes [
		"Playback VMixer, , System Playback"
		"Playback VMixer, , Offload0 Playback"
		"Playback VMixer, , Offload1 Playback"
		"SSP0 CODEC OUT, , Playback VMixer"
		"Analog Capture, , SSP0 CODEC IN"
	]
}

# PCM Configurations supported by FW
SectionPCMConfig."PCM 48k Stereo 24bit" {

	Playback [
		format "S24_LE"
		rate "48000"
		channels "2"
		tdm_slot "0xf"
	]

	Capture [
		format "S24_LE"
		rate "48000"
		channels "2"
		tdm_slot "0xf"

	]
}

SectionPCMConfig."PCM 48k Stereo 16bit" {

	Playback [
		format "S16_LE"
		rate "48000"
		channels "2"
		tdm_slot "0xf"
	]

	Capture [
		format "S16_LE"
		rate "48000"
		channels "2"
		tdm_slot "0xf"

	]
}

SectionPCMConfig."PCM 48k 2P/4C 16bit" {

	Playback [
		format "S16_LE"
		rate "48000"
		channels "2"
		tdm_slot "0xf"
	]

	Capture [
		format "S16_LE"
		rate "48000"
		channels "4"
		tdm_slot "0xf"

	]
}

SectionPCMConfig."PCM 8k Mono 16bit" {

	Playback [
		format "S16_LE"
		rate "8000"
		channels "1"
	]

	Capture [
		format "S16_LE"
		rate "8000"
		channels "1"

	]
}

# PCM capabilities supported by FW
SectionPCMCapabilities."System Playback" {

	Capabilities [
		formats "S24_LE, S16_LE"
		rate_min "48000"
		rate_max "48000"
		channels_min "2"
		channels_max "2"
	]
}

SectionPCMCapabilities."Analog Capture" {

	Capabilities [
		formats "S24_LE, S16_LE"
		rate_min "48000"
		rate_max "48000"
		channels_min "2"
		channels_max "4"
	]
}

SectionPCMCapabilities."Offload Pin Playback" {

	Capabilities [
		formats "S24_LE, S16_LE"
		rate_min "8000"
		rate_max "192000"
		channels_min "2"
		channels_max "2"
	]
}

SectionPCMCapabilities."Loopback Capture" {

	Capabilities [
		formats "S16_LE"
		rate_min "48000"
		rate_max "48000"
		channels_min "2"
		channels_max "2"
	]
}

SectionPCMCapabilities."BT" {

	Capabilities [
		formats "S16_LE"
		rate_min "8000"
		rate_max "8000"
		channels_min "1"
		channels_max "1"
	]
}

# PCM devices exported by Firmware
SectionPCM."System Pin" {

	Index "1"

	# used for binding to the PCM
	ID "0"

	Playback [
		Capabilities "System Playback"
		Config "PCM 48k Stereo 24bit"
		Config "PCM 48k Stereo 16bit"
	]

	Capture [
		Capabilities "Analog Capture"
		Config "PCM 48k Stereo 24bit"
		Config "PCM 48k Stereo 16bit"
		Config "PCM 48k 2P/4C 16bit"
	]
}

SectionPCM."Offload Pin 0" {

	Index "1"

	# used for binding to the PCM
	ID "1"

	Playback [
		Capabilities "Offload Pin Playback"
		Config "PCM 48k Stereo 24bit"
		Config "PCM 48k Stereo 16bit"
	]
}

SectionPCM."Offload Pin 1" {

	Index "1"

	# used for binding to the PCM
	ID "2"

	Playback [
		Capabilities "Offload Pin Playback"
		Config "PCM 48k Stereo 24bit"
		Config "PCM 48k Stereo 16bit"
	]
}

SectionPCM."Loopback Pin" {

	Index "1"

	# used for binding to the PCM
	ID "3"

	Capture [
		Capabilities "Loopback Capture"
		Config "PCM 48k Stereo 16bit"
	]
}

# Backend DAI links
SectionBE."SSP0-Codec" {

	Index "1"

	# used for binding to the BE DAI link
	ID "0"

	# BE DAI link capabilities and supported configs
	Playback [
		Capabilities "System Playback"
		Config "PCM 48k Stereo 24bit"
		Config "PCM 48k Stereo 16bit"
	]

	Capture [
		Capabilities "Analog Capture"
		Config "PCM 48k Stereo 24bit"
		Config "PCM 48k Stereo 16bit"
		Config "PCM 48k 2P/4C 16bit"
	]
}

SectionBE."SSP1-BT" {

	Index "1"

	# used for binding to the BE DAI link
	ID "1"

	# BE DAI link capabilities and supported configs
	Playback [
		Capabilities "BT"
		Config "PCM 8k Mono 16bit"
	]

	Capture [
		Capabilities "BT"
		Config "PCM 8k Mono 16bit"
	]
}

# Codec <-> Codec style links
SectionCC."FM-Codec" {

	Index "1"

	# used for binding to the CC link
	ID "0"

	# CC DAI link capabilities and supported configs
	Playback [
		Capabilities "System Playback"
		Config "PCM 48k Stereo 16bit"
	]

	Capture [
		Capabilities "Analog Capture"
		Config "PCM 48k Stereo 16bit"
	]
}
