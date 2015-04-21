From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [RFC] File format for topology data
Date: Tue, 21 Apr 2015 14:06:46 +0100
Message-ID: <1429621606.3793.37.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F29B260A5B
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 15:06:54 +0200 (CEST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I've pasted below the topology data for the broadwell firmware using the
text file format being used by UCM. Using the UCM format allows to to
share parser code and allows us to also have UCM define topology data.

I've not yet completed the byte or enum controls but the rest of the
data is there for comments. I've also included the recent channel
changes suggested in the UAPI header comments.

# Firmware Topology Configuration for Broadwell

# TLV scale used by both global and stream volumes
SectionTLV."hsw_vol_tlv" {

	DBScale [
		min "-9000"
		step "300"
		mute "1"
	]
}

# Controls from default pipeline
SectionControl."Default Pipeline" {

	Index "1"

	# Master DSP volume
	Mixer [
		name "Master Playback Volume"
		Channel.0 [
			map "Left"
			reg "0"
			shift "0"
		]
		Channel.1 [
			map "Right"
			reg "0"
			shift "8"
		]
		max "31"
		invert "false"
		get "0"
		put "0"
		tlv_array "hsw_vol_tlv"
	]

	# Offload 0 volume
	Mixer [
		name "Media0 Playback Volume"
		Channel.0 [
			map "Left"
			reg "1"
			shift "0"
		]
		Channel.1 [
			map "Right"
			reg "1"
			shift "8"
		]
		max "31"
		invert "false"
		get "1"
		put "1"
		tlv_array "hsw_vol_tlv"
	]

	# Enum controls
	Enum [
		...
	]

	# Byte controls
	Bytes [
		...
	]
}

# DAPM Widgets for main pipeline
SectionWidget."Pipeline1" {

	Index "1"

	AIF_IN [
		name "SSP0 CODEC IN"
		stream_name ""
		slot ""
		reg "0"
		shift "0"
		invert "false"
	]

	AIF_OUT [
		name "SSP0 CODEC OUT"
		stream_name ""
		slot ""
		reg "0"
		shift "0"
		invert "false"
	]

	...
}

# DAPM Routes
SectionGraph."Pipeline 1 Graph" {

	Index 1

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

# PCM devices exported by Firmware
SectionPCM."System Pin" {

	Index 1

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

	Index 1

	Playback [
		Capabilities "Offload Pin Playback"
		Config "PCM 48k Stereo 24bit"
		Config "PCM 48k Stereo 16bit"
	]
}

SectionPCM."Offload Pin 1" {

	Index 1

	Playback [
		Capabilities "Offload Pin Playback"
		Config "PCM 48k Stereo 24bit"
		Config "PCM 48k Stereo 16bit"
	]
}

SectionPCM."Loopback Pin" {

	Index 1

	Capture [
		Capabilities "Loopback Capture"
		Config "PCM 48k Stereo 16bit"
	]
}
