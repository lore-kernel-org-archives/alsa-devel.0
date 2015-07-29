From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v3 13/13] conf: topology: Add topology file for
	broadwell audio DSP
Date: Wed, 29 Jul 2015 17:45:25 +0100
Message-ID: <1438188325-11553-14-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1438188325-11553-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A1402606AB
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 18:46:03 +0200 (CEST)
In-Reply-To: <1438188325-11553-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/conf/Makefile.am                       |   2 +-
 src/conf/topology/Makefile.am              |   1 +
 src/conf/topology/broadwell/Makefile.am    |   4 +
 src/conf/topology/broadwell/broadwell.conf | 375 +++++++++++++++++++++++++++++
 4 files changed, 381 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/topology/Makefile.am
 create mode 100644 src/conf/topology/broadwell/Makefile.am
 create mode 100644 src/conf/topology/broadwell/broadwell.conf

diff --git a/src/conf/Makefile.am b/src/conf/Makefile.am
index 948d5a1..a04f73f 100644
--- a/src/conf/Makefile.am
+++ b/src/conf/Makefile.am
@@ -1,4 +1,4 @@
-SUBDIRS=cards pcm alsa.conf.d ucm
+SUBDIRS=cards pcm alsa.conf.d ucm topology
 
 cfg_files = alsa.conf
 if BUILD_ALISP
diff --git a/src/conf/topology/Makefile.am b/src/conf/topology/Makefile.am
new file mode 100644
index 0000000..f56a96c
--- /dev/null
+++ b/src/conf/topology/Makefile.am
@@ -0,0 +1 @@
+SUBDIRS=broadwell
diff --git a/src/conf/topology/broadwell/Makefile.am b/src/conf/topology/broadwell/Makefile.am
new file mode 100644
index 0000000..35d1e83
--- /dev/null
+++ b/src/conf/topology/broadwell/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+topologydir = $(alsaconfigdir)/topology/broadwell
+topology_DATA = broadwell.conf
+EXTRA_DIST = $(topology_DATA)
diff --git a/src/conf/topology/broadwell/broadwell.conf b/src/conf/topology/broadwell/broadwell.conf
new file mode 100644
index 0000000..05b3889
--- /dev/null
+++ b/src/conf/topology/broadwell/broadwell.conf
@@ -0,0 +1,375 @@
+# Dynamic Firmware Configuration for Broadwell
+
+# TLV
+SectionTLV."hsw_vol_tlv" {
+	Comment "TLV used by both global and stream volumes"
+
+	scale {
+		min "-9000"
+		step "300"
+		mute "1"
+	}
+}
+
+# Controls
+SectionControlMixer."Master Playback Volume" {
+	Comment "Global DSP volume"
+
+	# control belongs to this index group
+	index "1"
+
+	# Channel register and shift for Front Left/Right
+	channel."FL" {
+		reg "0"
+		shift "0"
+	}
+	channel."FR" {
+		reg "0"
+		shift "8"
+	}
+
+	# max control value and whether value is inverted
+	max "31"
+	invert "false"
+
+	# control uses bespoke driver get/put/info ID 0
+	ops."ctl" {
+		info "volsw"
+		get "256"
+		put "256"
+	}
+
+	# uses TLV data above
+	tlv "hsw_vol_tlv"
+}
+
+SectionControlMixer."Media0 Playback Volume" {
+	Comment "Offload 0 volume"
+
+	# control belongs to this index group
+	index "1"
+
+	# Channel register and shift for Front Left/Right
+	channel."FL" {
+		reg "1"
+		shift "0"
+	}
+	channel."FR" {
+		reg "1"
+		shift "8"
+	}
+
+	# max control value and whether value is inverted
+	max "31"
+	invert "false"
+
+	# control uses bespoke driver get/put/info ID 0
+	ops."ctl" {
+		info "volsw"
+		get "257"
+		put "257"
+	}
+
+	# uses TLV data above
+	tlv "hsw_vol_tlv"
+}
+
+SectionControlMixer."Media1 Playback Volume" {
+	Comment "Offload 1 volume"
+
+	# control belongs to this index group
+	index "1"
+
+	# Channel register and shift for Front Left/Right
+	channel."FL" {
+		reg "2"
+		shift "0"
+	}
+	channel."FR" {
+		reg "2"
+		shift "8"
+	}
+
+	# max control value and whether value is inverted
+	max "31"
+	invert "false"
+
+	# control uses bespoke driver get/put/info ID 0
+	ops."ctl" {
+		info "volsw"
+		get "257"
+		put "257"
+	}
+
+	# uses TLV data above
+	tlv "hsw_vol_tlv"
+}
+
+SectionControlMixer."Mic Capture Volume" {
+	Comment "Mic Capture volume"
+
+	# control belongs to this index group
+	index "1"
+
+	# Channel register and shift for Front Left/Right
+	channel."FL" {
+		reg "0"
+		shift "0"
+	}
+	channel."FR" {
+		reg "0"
+		shift "8"
+	}
+
+	# max control value and whether value is inverted
+	max "31"
+	invert "false"
+
+	# control uses bespoke driver get/put/info ID 0
+	ops."ctl" {
+		info "volsw"
+		get "257"
+		put "257"
+	}
+
+	# uses TLV data above
+	tlv "hsw_vol_tlv"
+}
+
+SectionWidget."SSP0 CODEC IN" {
+
+	index "1"
+	type "aif_in"
+	no_pm "true"
+	shift "0"
+	invert "0"
+}
+
+SectionWidget."SSP0 CODEC OUT" {
+
+	index "1"
+	type "aif_out"
+	no_pm "true"
+	shift "0"
+	invert "0"
+}
+
+SectionWidget."SSP1 BT IN" {
+
+	index "1"
+	type "aif_in"
+	no_pm "true"
+	shift "0"
+	invert "0"
+}
+
+SectionWidget."SSP1 BT OUT" {
+
+	index "1"
+	type "aif_out"
+	no_pm "true"
+	shift "0"
+	invert "0"
+}
+
+SectionWidget."Playback VMixer" {
+
+	index "1"
+	type "mixer"
+	no_pm "true"
+	shift "0"
+	invert "0"
+}
+
+# PCM Configurations supported by FW
+SectionPCMConfig."PCM 48k Stereo 24bit" {
+
+	config."playback" {
+		format "S24_LE"
+		rate "48000"
+		channels "2"
+		tdm_slot "0xf"
+	}
+
+	config."capture" {
+		format "S24_LE"
+		rate "48000"
+		channels "2"
+		tdm_slot "0xf"
+	}
+}
+
+SectionPCMConfig."PCM 48k Stereo 16bit" {
+
+	config."playback" {
+		format "S16_LE"
+		rate "48000"
+		channels "2"
+		tdm_slot "0xf"
+	}
+
+	config."capture" {
+		format "S16_LE"
+		rate "48000"
+		channels "2"
+		tdm_slot "0xf"
+	}
+}
+
+SectionPCMConfig."PCM 48k 2P/4C 16bit" {
+
+	config."playback" {
+		format "S16_LE"
+		rate "48000"
+		channels "2"
+		tdm_slot "0xf"
+	}
+
+	config."capture" {
+		format "S16_LE"
+		rate "48000"
+		channels "4"
+		tdm_slot "0xf"
+	}
+}
+
+# PCM capabilities supported by FW
+SectionPCMCapabilities."System Playback" {
+
+	formats "S24_LE,S16_LE"
+	rate_min "48000"
+	rate_max "48000"
+	channels_min "2"
+	channels_max "2"
+}
+
+SectionPCMCapabilities."Analog Capture" {
+
+	formats "S24_LE,S16_LE"
+	rate_min "48000"
+	rate_max "48000"
+	channels_min "2"
+	channels_max "4"
+}
+
+SectionPCMCapabilities."Loopback Capture" {
+
+	formats "S24_LE,S16_LE"
+	rate_min "48000"
+	rate_max "48000"
+	channels_min "2"
+	channels_max "2"
+}
+
+SectionPCMCapabilities."Offload0 Playback" {
+	formats "S24_LE,S16_LE"
+	rate_min "8000"
+	rate_max "192000"
+	channels_min "2"
+	channels_max "2"
+}
+
+SectionPCMCapabilities."Offload1 Playback" {
+	formats "S24_LE,S16_LE"
+	rate_min "8000"
+	rate_max "48000"
+	channels_min "2"
+	channels_max "2"
+}
+
+# PCM devices exported by Firmware
+SectionPCM."System Pin" {
+
+	index "1"
+
+	# used for binding to the PCM
+	ID "0"
+
+	pcm."playback" {
+
+		capabilities "System Playback"
+
+		configs [
+			"PCM 48k Stereo 24bit"
+			"PCM 48k Stereo 16bit"
+		]
+	}
+
+	pcm."capture" {
+
+		capabilities "Analog Capture"
+
+		configs [
+			"PCM 48k Stereo 24bit"
+			"PCM 48k Stereo 16bit"
+			"PCM 48k 2P/4C 16bit"
+		]
+	}
+}
+
+SectionPCM."Offload0 Pin" {
+
+	index "1"
+
+	# used for binding to the PCM
+	ID "1"
+
+	pcm."playback" {
+
+		capabilities "Offload0 Playback"
+
+		configs [
+			"PCM 48k Stereo 24bit"
+			"PCM 48k Stereo 16bit"
+		]
+	}
+}
+
+SectionPCM."Offload1 Pin" {
+
+	index "1"
+
+	# used for binding to the PCM
+	ID "2"
+
+	pcm."playback" {
+
+		capabilities "Offload1 Playback"
+
+		configs [
+			"PCM 48k Stereo 24bit"
+			"PCM 48k Stereo 16bit"
+		]
+	}
+}
+
+SectionPCM."Loopback Pin" {
+
+	index "1"
+
+	# used for binding to the PCM
+	ID "3"
+
+	pcm."capture" {
+
+		capabilities "Loopback Capture"
+
+		configs [
+			"PCM 48k Stereo 24bit"
+			"PCM 48k Stereo 16bit"
+		]
+	}
+}
+
+SectionGraph."dsp" {
+	index "1"
+
+	lines [
+		"Playback VMixer, , System Playback"
+		"Playback VMixer, , Offload0 Playback"
+		"Playback VMixer, , Offload1 Playback"
+		"SSP0 CODEC OUT, , Playback VMixer"
+		"Loopback Capture, , Playback VMixer"
+		"Analog Capture, , SSP0 CODEC IN"
+	]
+}
-- 
2.1.4
