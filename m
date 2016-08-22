From: focus.luo@linux.intel.com
Subject: [PATCH v2 2/2] alsabat: add amixer config files
Date: Tue, 23 Aug 2016 00:16:50 +0800
Message-ID: <1471882610-18781-3-git-send-email-focus.luo@linux.intel.com>
References: <1471882610-18781-1-git-send-email-focus.luo@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D55FE266719
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 17:48:56 +0200 (CEST)
In-Reply-To: <1471882610-18781-1-git-send-email-focus.luo@linux.intel.com>
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
Cc: tiwai@suse.de, focus.luo@intel.com, Focus Luo <focus.luo@linux.intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Focus Luo <focus.luo@linux.intel.com>

This patch includes the reference asound.state config files
on Intel Skylake, Broadwell and Hsawell platforms

Signed-off-by: Focus Luo <focus.luo@linux.intel.com>
---
 bat/tests/Makefile.am                         |   1 +
 bat/tests/asound_state/Makefile.am            |   6 +
 bat/tests/asound_state/asound.state.Broadwell | 439 ++++++++++++++++++++++++++
 bat/tests/asound_state/asound.state.Haswell   | 342 ++++++++++++++++++++
 bat/tests/asound_state/asound.state.Skylake   | 437 +++++++++++++++++++++++++
 configure.ac                                  |   2 +-
 6 files changed, 1226 insertions(+), 1 deletion(-)
 create mode 100644 bat/tests/asound_state/Makefile.am
 create mode 100644 bat/tests/asound_state/asound.state.Broadwell
 create mode 100644 bat/tests/asound_state/asound.state.Haswell
 create mode 100644 bat/tests/asound_state/asound.state.Skylake

diff --git a/bat/tests/Makefile.am b/bat/tests/Makefile.am
index 5182976..d20eb3c 100644
--- a/bat/tests/Makefile.am
+++ b/bat/tests/Makefile.am
@@ -1,3 +1,4 @@
+SUBDIRS=asound_state
 alsabat_script_files = analog_audio_playback_and_capture.sh \
 	dp_audio_playback.sh \
 	dp_audio_subdevice_number.sh \
diff --git a/bat/tests/asound_state/Makefile.am b/bat/tests/asound_state/Makefile.am
new file mode 100644
index 0000000..7010310
--- /dev/null
+++ b/bat/tests/asound_state/Makefile.am
@@ -0,0 +1,6 @@
+alsabat_cfg_files = asound.state.Broadwell \
+	asound.state.Haswell \
+	asound.state.Skylake
+
+EXTRA_DIST = \
+	$(alsabat_cfg_files)
diff --git a/bat/tests/asound_state/asound.state.Broadwell b/bat/tests/asound_state/asound.state.Broadwell
new file mode 100644
index 0000000..bea75e5
--- /dev/null
+++ b/bat/tests/asound_state/asound.state.Broadwell
@@ -0,0 +1,439 @@
+state.HDMI {
+	control.1 {
+		iface CARD
+		name 'HDMI/DP,pcm=3 Jack'
+		value false
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.2 {
+		iface MIXER
+		name 'IEC958 Playback Con Mask'
+		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.3 {
+		iface MIXER
+		name 'IEC958 Playback Pro Mask'
+		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.4 {
+		iface MIXER
+		name 'IEC958 Playback Default'
+		value '0482000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access 'read write'
+			type IEC958
+			count 1
+		}
+	}
+	control.5 {
+		iface MIXER
+		name 'IEC958 Playback Switch'
+		value true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.6 {
+		iface PCM
+		device 3
+		name ELD
+		value ''
+		comment {
+			access 'read volatile'
+			type BYTES
+			count 0
+		}
+	}
+	control.7 {
+		iface CARD
+		name 'HDMI/DP,pcm=7 Jack'
+		value true
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.8 {
+		iface MIXER
+		name 'IEC958 Playback Con Mask'
+		index 1
+		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.9 {
+		iface MIXER
+		name 'IEC958 Playback Pro Mask'
+		index 1
+		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.10 {
+		iface MIXER
+		name 'IEC958 Playback Default'
+		index 1
+		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access 'read write'
+			type IEC958
+			count 1
+		}
+	}
+	control.11 {
+		iface MIXER
+		name 'IEC958 Playback Switch'
+		index 1
+		value true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.12 {
+		iface PCM
+		device 7
+		name ELD
+		value '100008006a10000100000000000000000469b12341535553205041323338091707000000'
+		comment {
+			access 'read volatile'
+			type BYTES
+			count 36
+		}
+	}
+	control.13 {
+		iface CARD
+		name 'HDMI/DP,pcm=8 Jack'
+		value false
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.14 {
+		iface MIXER
+		name 'IEC958 Playback Con Mask'
+		index 2
+		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.15 {
+		iface MIXER
+		name 'IEC958 Playback Pro Mask'
+		index 2
+		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.16 {
+		iface MIXER
+		name 'IEC958 Playback Default'
+		index 2
+		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access 'read write'
+			type IEC958
+			count 1
+		}
+	}
+	control.17 {
+		iface MIXER
+		name 'IEC958 Playback Switch'
+		index 2
+		value true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.18 {
+		iface PCM
+		device 8
+		name ELD
+		value ''
+		comment {
+			access 'read volatile'
+			type BYTES
+			count 0
+		}
+	}
+	control.19 {
+		iface PCM
+		device 3
+		name 'Playback Channel Map'
+		value.0 0
+		value.1 0
+		value.2 0
+		value.3 0
+		value.4 0
+		value.5 0
+		value.6 0
+		value.7 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 8
+			range '0 - 36'
+		}
+	}
+	control.20 {
+		iface PCM
+		device 7
+		name 'Playback Channel Map'
+		value.0 0
+		value.1 0
+		value.2 0
+		value.3 0
+		value.4 0
+		value.5 0
+		value.6 0
+		value.7 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 8
+			range '0 - 36'
+		}
+	}
+	control.21 {
+		iface PCM
+		device 8
+		name 'Playback Channel Map'
+		value.0 0
+		value.1 0
+		value.2 0
+		value.3 0
+		value.4 0
+		value.5 0
+		value.6 0
+		value.7 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 8
+			range '0 - 36'
+		}
+	}
+}
+state.PCH {
+	control.1 {
+		iface MIXER
+		name 'Master Playback Volume'
+		value.0 41
+		value.1 41
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 87'
+			dbmin -6525
+			dbmax 0
+			dbvalue.0 -3450
+			dbvalue.1 -3450
+		}
+	}
+	control.2 {
+		iface MIXER
+		name 'Master Playback Switch'
+		value.0 true
+		value.1 true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 2
+		}
+	}
+	control.3 {
+		iface MIXER
+		name 'Loopback Mixing'
+		value Enabled
+		comment {
+			access 'read write'
+			type ENUMERATED
+			count 1
+			item.0 Disabled
+			item.1 Enabled
+		}
+	}
+	control.4 {
+		iface MIXER
+		name 'Mic Playback Volume'
+		value.0 0
+		value.1 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 31'
+			dbmin -3450
+			dbmax 1200
+			dbvalue.0 -3450
+			dbvalue.1 -3450
+		}
+	}
+	control.5 {
+		iface MIXER
+		name 'Mic Playback Switch'
+		value.0 true
+		value.1 true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 2
+		}
+	}
+	control.6 {
+		iface MIXER
+		name 'Capture Volume'
+		value.0 21
+		value.1 21
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 63'
+			dbmin -1725
+			dbmax 3000
+			dbvalue.0 -150
+			dbvalue.1 -150
+		}
+	}
+	control.7 {
+		iface MIXER
+		name 'Capture Switch'
+		value.0 true
+		value.1 true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 2
+		}
+	}
+	control.8 {
+		iface MIXER
+		name 'Mic Boost Volume'
+		value.0 0
+		value.1 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 3'
+			dbmin 0
+			dbmax 3600
+			dbvalue.0 0
+			dbvalue.1 0
+		}
+	}
+	control.9 {
+		iface CARD
+		name 'Mic Jack'
+		value false
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.10 {
+		iface CARD
+		name 'Headphone Jack'
+		value true
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.11 {
+		iface PCM
+		name 'Playback Channel Map'
+		value.0 0
+		value.1 0
+		comment {
+			access read
+			type INTEGER
+			count 2
+			range '0 - 36'
+		}
+	}
+	control.12 {
+		iface PCM
+		name 'Capture Channel Map'
+		value.0 0
+		value.1 0
+		comment {
+			access read
+			type INTEGER
+			count 2
+			range '0 - 36'
+		}
+	}
+	control.13 {
+		iface MIXER
+		name 'PCM Playback Volume'
+		value.0 105
+		value.1 105
+		comment {
+			access 'read write user'
+			type INTEGER
+			count 2
+			range '0 - 255'
+			tlv '0000000100000008ffffec1400000014'
+			dbmin -5100
+			dbmax 0
+			dbvalue.0 -3000
+			dbvalue.1 -3000
+		}
+	}
+	control.14 {
+		iface MIXER
+		name 'Digital Capture Volume'
+		value.0 60
+		value.1 60
+		comment {
+			access 'read write user'
+			type INTEGER
+			count 2
+			range '0 - 120'
+			tlv '0000000100000008fffff44800000032'
+			dbmin -3000
+			dbmax 3000
+			dbvalue.0 0
+			dbvalue.1 0
+		}
+	}
+}
diff --git a/bat/tests/asound_state/asound.state.Haswell b/bat/tests/asound_state/asound.state.Haswell
new file mode 100644
index 0000000..8bc8f3c
--- /dev/null
+++ b/bat/tests/asound_state/asound.state.Haswell
@@ -0,0 +1,342 @@
+state.HDMI {
+	control.1 {
+		iface CARD
+		name 'HDMI/DP,pcm=3 Jack'
+		value true
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.2 {
+		iface MIXER
+		name 'IEC958 Playback Con Mask'
+		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.3 {
+		iface MIXER
+		name 'IEC958 Playback Pro Mask'
+		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.4 {
+		iface MIXER
+		name 'IEC958 Playback Default'
+		value '0482000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access 'read write'
+			type IEC958
+			count 1
+		}
+	}
+	control.5 {
+		iface MIXER
+		name 'IEC958 Playback Switch'
+		value true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.6 {
+		iface PCM
+		device 3
+		name ELD
+		value '100008006a10000100000000000000000469d22341535553205653323339091707000000'
+		comment {
+			access 'read volatile'
+			type BYTES
+			count 36
+		}
+	}
+	control.7 {
+		iface CARD
+		name 'HDMI/DP,pcm=7 Jack'
+		value true
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.8 {
+		iface MIXER
+		name 'IEC958 Playback Con Mask'
+		index 1
+		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.9 {
+		iface MIXER
+		name 'IEC958 Playback Pro Mask'
+		index 1
+		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.10 {
+		iface MIXER
+		name 'IEC958 Playback Default'
+		index 1
+		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access 'read write'
+			type IEC958
+			count 1
+		}
+	}
+	control.11 {
+		iface MIXER
+		name 'IEC958 Playback Switch'
+		index 1
+		value true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.12 {
+		iface PCM
+		device 7
+		name ELD
+		value '100008006a10000100000000000000000469b12341535553205041323338091707000000'
+		comment {
+			access 'read volatile'
+			type BYTES
+			count 36
+		}
+	}
+	control.13 {
+		iface PCM
+		device 3
+		name 'Playback Channel Map'
+		value.0 0
+		value.1 0
+		value.2 0
+		value.3 0
+		value.4 0
+		value.5 0
+		value.6 0
+		value.7 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 8
+			range '0 - 36'
+		}
+	}
+	control.14 {
+		iface PCM
+		device 7
+		name 'Playback Channel Map'
+		value.0 0
+		value.1 0
+		value.2 0
+		value.3 0
+		value.4 0
+		value.5 0
+		value.6 0
+		value.7 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 8
+			range '0 - 36'
+		}
+	}
+}
+state.PCH {
+	control.1 {
+		iface MIXER
+		name 'Master Playback Volume'
+		value.0 45
+		value.1 45
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 87'
+			dbmin -6525
+			dbmax 0
+			dbvalue.0 -3150
+			dbvalue.1 -3150
+		}
+	}
+	control.2 {
+		iface MIXER
+		name 'Master Playback Switch'
+		value.0 true
+		value.1 true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 2
+		}
+	}
+	control.3 {
+		iface MIXER
+		name 'Capture Volume'
+		value.0 27
+		value.1 27
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 63'
+			dbmin -1725
+			dbmax 3000
+			dbvalue.0 300
+			dbvalue.1 300
+		}
+	}
+	control.4 {
+		iface MIXER
+		name 'Capture Switch'
+		value.0 true
+		value.1 true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 2
+		}
+	}
+	control.5 {
+		iface MIXER
+		name 'Mic Boost Volume'
+		value.0 0
+		value.1 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 3'
+			dbmin 0
+			dbmax 3600
+			dbvalue.0 0
+			dbvalue.1 0
+		}
+	}
+	control.6 {
+		iface MIXER
+		name 'Internal Mic Boost Volume'
+		value.0 0
+		value.1 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 3'
+			dbmin 0
+			dbmax 3600
+			dbvalue.0 0
+			dbvalue.1 0
+		}
+	}
+	control.7 {
+		iface CARD
+		name 'Mic Jack'
+		value true
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.8 {
+		iface CARD
+		name 'Internal Mic Phantom Jack'
+		value true
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.9 {
+		iface CARD
+		name 'Headphone Jack'
+		value true
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.10 {
+		iface PCM
+		name 'Playback Channel Map'
+		value.0 0
+		value.1 0
+		comment {
+			access read
+			type INTEGER
+			count 2
+			range '0 - 36'
+		}
+	}
+	control.11 {
+		iface PCM
+		name 'Capture Channel Map'
+		value.0 0
+		value.1 0
+		comment {
+			access read
+			type INTEGER
+			count 2
+			range '0 - 36'
+		}
+	}
+	control.12 {
+		iface MIXER
+		name 'PCM Playback Volume'
+		value.0 167
+		value.1 167
+		comment {
+			access 'read write user'
+			type INTEGER
+			count 2
+			range '0 - 255'
+			tlv '0000000100000008ffffec1400000014'
+			dbmin -5100
+			dbmax 0
+			dbvalue.0 -1760
+			dbvalue.1 -1760
+		}
+	}
+	control.13 {
+		iface MIXER
+		name 'Digital Capture Volume'
+		value.0 60
+		value.1 60
+		comment {
+			access 'read write user'
+			type INTEGER
+			count 2
+			range '0 - 120'
+			tlv '0000000100000008fffff44800000032'
+			dbmin -3000
+			dbmax 3000
+			dbvalue.0 0
+			dbvalue.1 0
+		}
+	}
+}
diff --git a/bat/tests/asound_state/asound.state.Skylake b/bat/tests/asound_state/asound.state.Skylake
new file mode 100644
index 0000000..50f672a
--- /dev/null
+++ b/bat/tests/asound_state/asound.state.Skylake
@@ -0,0 +1,437 @@
+state.PCH {
+	control.1 {
+		iface MIXER
+		name 'Master Playback Volume'
+		value.0 57
+		value.1 57
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 87'
+			dbmin -6525
+			dbmax 0
+			dbvalue.0 -2250
+			dbvalue.1 -2250
+		}
+	}
+	control.2 {
+		iface MIXER
+		name 'Master Playback Switch'
+		value.0 true
+		value.1 true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 2
+		}
+	}
+	control.3 {
+		iface MIXER
+		name 'Loopback Mixing'
+		value Enabled
+		comment {
+			access 'read write'
+			type ENUMERATED
+			count 1
+			item.0 Disabled
+			item.1 Enabled
+		}
+	}
+	control.4 {
+		iface MIXER
+		name 'Mic Playback Volume'
+		value.0 15
+		value.1 15
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 31'
+			dbmin -3450
+			dbmax 1200
+			dbvalue.0 -1200
+			dbvalue.1 -1200
+		}
+	}
+	control.5 {
+		iface MIXER
+		name 'Mic Playback Switch'
+		value.0 true
+		value.1 true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 2
+		}
+	}
+	control.6 {
+		iface MIXER
+		name 'Capture Volume'
+		value.0 27
+		value.1 27
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 63'
+			dbmin -1725
+			dbmax 3000
+			dbvalue.0 300
+			dbvalue.1 300
+		}
+	}
+	control.7 {
+		iface MIXER
+		name 'Capture Switch'
+		value.0 true
+		value.1 true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 2
+		}
+	}
+	control.8 {
+		iface MIXER
+		name 'Mic Boost Volume'
+		value.0 0
+		value.1 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 2
+			range '0 - 3'
+			dbmin 0
+			dbmax 3600
+			dbvalue.0 0
+			dbvalue.1 0
+		}
+	}
+	control.9 {
+		iface CARD
+		name 'Mic Jack'
+		value true
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.10 {
+		iface CARD
+		name 'Headphone Jack'
+		value true
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.11 {
+		iface PCM
+		name 'Playback Channel Map'
+		value.0 0
+		value.1 0
+		comment {
+			access read
+			type INTEGER
+			count 2
+			range '0 - 36'
+		}
+	}
+	control.12 {
+		iface PCM
+		name 'Capture Channel Map'
+		value.0 0
+		value.1 0
+		comment {
+			access read
+			type INTEGER
+			count 2
+			range '0 - 36'
+		}
+	}
+	control.13 {
+		iface CARD
+		name 'HDMI/DP,pcm=3 Jack'
+		value true
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.14 {
+		iface MIXER
+		name 'IEC958 Playback Con Mask'
+		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.15 {
+		iface MIXER
+		name 'IEC958 Playback Pro Mask'
+		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.16 {
+		iface MIXER
+		name 'IEC958 Playback Default'
+		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access 'read write'
+			type IEC958
+			count 1
+		}
+	}
+	control.17 {
+		iface MIXER
+		name 'IEC958 Playback Switch'
+		value true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.18 {
+		iface PCM
+		device 3
+		name ELD
+		value '100008006a10000100000000000000000469d22341535553205653323339091707000000'
+		comment {
+			access 'read volatile'
+			type BYTES
+			count 36
+		}
+	}
+	control.19 {
+		iface CARD
+		name 'HDMI/DP,pcm=7 Jack'
+		value true
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.20 {
+		iface MIXER
+		name 'IEC958 Playback Con Mask'
+		index 1
+		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.21 {
+		iface MIXER
+		name 'IEC958 Playback Pro Mask'
+		index 1
+		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.22 {
+		iface MIXER
+		name 'IEC958 Playback Default'
+		index 1
+		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access 'read write'
+			type IEC958
+			count 1
+		}
+	}
+	control.23 {
+		iface MIXER
+		name 'IEC958 Playback Switch'
+		index 1
+		value true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.24 {
+		iface PCM
+		device 7
+		name ELD
+		value '100008006a14000100000000000000000469b12341535553205041323338091707000000'
+		comment {
+			access 'read volatile'
+			type BYTES
+			count 36
+		}
+	}
+	control.25 {
+		iface CARD
+		name 'HDMI/DP,pcm=8 Jack'
+		value false
+		comment {
+			access read
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.26 {
+		iface MIXER
+		name 'IEC958 Playback Con Mask'
+		index 2
+		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.27 {
+		iface MIXER
+		name 'IEC958 Playback Pro Mask'
+		index 2
+		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access read
+			type IEC958
+			count 1
+		}
+	}
+	control.28 {
+		iface MIXER
+		name 'IEC958 Playback Default'
+		index 2
+		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
+		comment {
+			access 'read write'
+			type IEC958
+			count 1
+		}
+	}
+	control.29 {
+		iface MIXER
+		name 'IEC958 Playback Switch'
+		index 2
+		value true
+		comment {
+			access 'read write'
+			type BOOLEAN
+			count 1
+		}
+	}
+	control.30 {
+		iface PCM
+		device 8
+		name ELD
+		value ''
+		comment {
+			access 'read volatile'
+			type BYTES
+			count 0
+		}
+	}
+	control.31 {
+		iface PCM
+		device 3
+		name 'Playback Channel Map'
+		value.0 0
+		value.1 0
+		value.2 0
+		value.3 0
+		value.4 0
+		value.5 0
+		value.6 0
+		value.7 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 8
+			range '0 - 36'
+		}
+	}
+	control.32 {
+		iface PCM
+		device 7
+		name 'Playback Channel Map'
+		value.0 0
+		value.1 0
+		value.2 0
+		value.3 0
+		value.4 0
+		value.5 0
+		value.6 0
+		value.7 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 8
+			range '0 - 36'
+		}
+	}
+	control.33 {
+		iface PCM
+		device 8
+		name 'Playback Channel Map'
+		value.0 0
+		value.1 0
+		value.2 0
+		value.3 0
+		value.4 0
+		value.5 0
+		value.6 0
+		value.7 0
+		comment {
+			access 'read write'
+			type INTEGER
+			count 8
+			range '0 - 36'
+		}
+	}
+	control.34 {
+		iface MIXER
+		name 'PCM Playback Volume'
+		value.0 158
+		value.1 158
+		comment {
+			access 'read write user'
+			type INTEGER
+			count 2
+			range '0 - 255'
+			tlv '0000000100000008ffffec1400000014'
+			dbmin -5100
+			dbmax 0
+			dbvalue.0 -1940
+			dbvalue.1 -1940
+		}
+	}
+	control.35 {
+		iface MIXER
+		name 'Digital Capture Volume'
+		value.0 60
+		value.1 60
+		comment {
+			access 'read write user'
+			type INTEGER
+			count 2
+			range '0 - 120'
+			tlv '0000000100000008fffff44800000032'
+			dbmin -3000
+			dbmax 3000
+			dbvalue.0 0
+			dbvalue.1 0
+		}
+	}
+}
diff --git a/configure.ac b/configure.ac
index 0520515..2221617 100644
--- a/configure.ac
+++ b/configure.ac
@@ -412,7 +412,7 @@ AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  alsaconf/alsaconf alsaconf/Makefile \
 	  alsaconf/po/Makefile \
 	  alsaucm/Makefile topology/Makefile \
-	  bat/Makefile bat/tests/Makefile \
+	  bat/Makefile bat/tests/Makefile bat/tests/asound_state/Makefile \
 	  aplay/Makefile include/Makefile iecset/Makefile utils/Makefile \
 	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile \
 	  seq/aplaymidi/Makefile seq/aseqdump/Makefile seq/aseqnet/Makefile \
-- 
1.9.1
