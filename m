From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 1/3] conf: topology: Add Skylake i2s conf
Date: Thu, 21 Apr 2016 11:57:36 +0530
Message-ID: <1461220058-1378-2-git-send-email-vinod.koul@intel.com>
References: <1461220058-1378-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CD632608B3
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 08:23:07 +0200 (CEST)
In-Reply-To: <1461220058-1378-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

The Skylake topology configuration for simple topology graph is
provided. This exposes the PCM capabilities of the DSP.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 configure.ac                            |   1 +
 src/conf/topology/Makefile.am           |   2 +-
 src/conf/topology/sklrt286/Makefile.am  |  11 +
 src/conf/topology/sklrt286/skl_i2s.conf | 342 ++++++++++++++++++++++++++++++++
 4 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/topology/sklrt286/Makefile.am
 create mode 100644 src/conf/topology/sklrt286/skl_i2s.conf

diff --git a/configure.ac b/configure.ac
index c265ec9e159b..1bf75e6d9c2b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -661,6 +661,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/topology/Makefile \
 	  src/conf/topology/broadwell/Makefile \
 	  modules/Makefile modules/mixer/Makefile modules/mixer/simple/Makefile \
+	  src/conf/topology/sklrt286/Makefile \
 	  alsalisp/Makefile aserver/Makefile \
 	  test/Makefile test/lsb/Makefile \
 	  utils/Makefile utils/alsa-lib.spec utils/alsa.pc)
diff --git a/src/conf/topology/Makefile.am b/src/conf/topology/Makefile.am
index f56a96c651e5..cbdb7cf07c97 100644
--- a/src/conf/topology/Makefile.am
+++ b/src/conf/topology/Makefile.am
@@ -1 +1 @@
-SUBDIRS=broadwell
+SUBDIRS=broadwell sklrt286
diff --git a/src/conf/topology/sklrt286/Makefile.am b/src/conf/topology/sklrt286/Makefile.am
new file mode 100644
index 000000000000..f10d12fa0f73
--- /dev/null
+++ b/src/conf/topology/sklrt286/Makefile.am
@@ -0,0 +1,11 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+SUBDIRS = data
+sklrt286dir = $(alsaconfigdir)/topology/sklrt286
+sklrt286_DATA = skl_i2s.conf
+EXTRA_DIST = sklrt286_DATA
+install-data-hook:
+	cp -p media0_in-cpr-0.bin media0_in-mi.bin media0_out-mo.bin media0_out-cpr-6.bin codec0_out-mo.bin codec0_out-cpr-4.bin codec1_out-mo.bin codec1_out-cpr-5.bin codec0_in-cpr-1.bin codec0_in-mi.bin dmic01_hifi_in-cpr-3.bin dmic01_hifi_in-mi.bin hdmi1_pt_out-cpr-7.bin hdmi1_pt_out-cpr-8.bin hdmi2_pt_out-cpr-9.bin hdmi2_pt_out-cpr-10.bin hdmi3_pt_out-cpr-11.bin hdmi3_pt_out-cpr-12.bin $(sklrt286dir)
+clean-local: clean-local-check
+.PHONY: clean-local-check
+clean-local-check:
+	-rm -rf *.bin
\ No newline at end of file
diff --git a/src/conf/topology/sklrt286/skl_i2s.conf b/src/conf/topology/sklrt286/skl_i2s.conf
new file mode 100644
index 000000000000..6da224fb4d2b
--- /dev/null
+++ b/src/conf/topology/sklrt286/skl_i2s.conf
@@ -0,0 +1,342 @@
+SectionData."media0_in cpr 0" {
+	file "sklrt286/media0_in-cpr-0.bin"
+}
+SectionData."media0_in mi" {
+	file "sklrt286/media0_in-mi.bin"
+}
+SectionData."media0_out mo" {
+	file "sklrt286/media0_out-mo.bin"
+}
+SectionData."media0_out cpr 6" {
+	file "sklrt286/media0_out-cpr-6.bin"
+}
+SectionData."codec0_out mo" {
+	file "sklrt286/codec0_out-mo.bin"
+}
+SectionData."codec0_out cpr 4" {
+	file "sklrt286/codec0_out-cpr-4.bin"
+}
+SectionData."codec1_out mo" {
+	file "sklrt286/codec1_out-mo.bin"
+}
+SectionData."codec1_out cpr 5" {
+	file "sklrt286/codec1_out-cpr-5.bin"
+}
+SectionData."codec0_in cpr 1" {
+	file "sklrt286/codec0_in-cpr-1.bin"
+}
+SectionData."codec0_in mi" {
+	file "sklrt286/codec0_in-mi.bin"
+}
+SectionData."dmic01_hifi_in cpr 3" {
+	file "sklrt286/dmic01_hifi_in-cpr-3.bin"
+}
+SectionData."dmic01_hifi_in mi" {
+	file "sklrt286/dmic01_hifi_in-mi.bin"
+}
+SectionData."hdmi1_pt_out cpr 7" {
+	file "sklrt286/hdmi1_pt_out-cpr-7.bin"
+}
+SectionData."hdmi1_pt_out cpr 8" {
+	file "sklrt286/hdmi1_pt_out-cpr-8.bin"
+}
+SectionData."hdmi2_pt_out cpr 9" {
+	file "sklrt286/hdmi2_pt_out-cpr-9.bin"
+}
+SectionData."hdmi2_pt_out cpr 10" {
+	file "sklrt286/hdmi2_pt_out-cpr-10.bin"
+}
+SectionData."hdmi3_pt_out cpr 11" {
+	file "sklrt286/hdmi3_pt_out-cpr-11.bin"
+}
+SectionData."hdmi3_pt_out cpr 12" {
+	file "sklrt286/hdmi3_pt_out-cpr-12.bin"
+}
+
+SectionControlMixer."media0_in mi Switch" {
+	index"1"
+	invert "false"
+	max "1"
+	min"0"
+	no_pm "true"
+	channel."fl" {
+		reg "-1"
+		shift "0"
+	}
+	channel."fr" {
+		reg "-1"
+		shift "0"
+	}
+	ops."ctl" {
+		get "64"
+		put "64"
+		info "64"
+	}
+}
+SectionControlMixer."codec0_in mi Switch" {
+	index"1"
+	invert "false"
+	max "1"
+	min"0"
+	no_pm "true"
+	channel."fl" {
+		reg "-1"
+		shift "0"
+	}
+	channel."fr" {
+		reg "-1"
+		shift "0"
+	}
+	ops."ctl" {
+		get "64"
+		put "64"
+		info "64"
+	}
+}
+SectionControlMixer."dmic01_hifi_in mi Switch" {
+	index"1"
+	invert "false"
+	max "1"
+	min"0"
+	no_pm "true"
+	channel."fl" {
+		reg "-1"
+		shift "0"
+	}
+	channel."fr" {
+		reg "-1"
+		shift "0"
+	}
+	ops."ctl" {
+		get "64"
+		put "64"
+		info "64"
+	}
+}
+
+
+SectionWidget."media0_in cpr 0" {
+	index"1"
+	type"mixer"
+	no_pm "true"
+	event_type "3"
+	event_flags "9"
+	data "media0_in cpr 0"
+}
+SectionWidget."media0_in mi" {
+	index"1"
+	type"pga"
+	no_pm "true"
+	event_type "4"
+	event_flags "9"
+	subseq "10"
+	data "media0_in mi"
+}
+SectionWidget."media0_out mo" {
+	index"1"
+	type"mixer"
+	no_pm "true"
+	event_type "1"
+	event_flags "15"
+	subseq "10"
+	data "media0_out mo"
+	mixer [
+		"media0_in mi Switch"
+		"codec0_in mi Switch"
+		"dmic01_hifi_in mi Switch"
+	]
+}
+SectionWidget."media0_out cpr 6" {
+	index"1"
+	type"pga"
+	no_pm "true"
+	event_type "4"
+	data "media0_out cpr 6"
+}
+SectionWidget."codec0_out mo" {
+	index"1"
+	type"mixer"
+	no_pm "true"
+	event_type "1"
+	event_flags "15"
+	subseq "10"
+	data "codec0_out mo"
+	mixer [
+		"media0_in mi Switch"
+		"codec0_in mi Switch"
+		"dmic01_hifi_in mi Switch"
+	]
+}
+SectionWidget."codec0_out cpr 4" {
+	index"1"
+	type"pga"
+	no_pm "true"
+	event_type "4"
+	data "codec0_out cpr 4"
+}
+SectionWidget."codec0_out" {
+	index"1"
+	type"aif_out"
+	no_pm "true"
+}
+SectionWidget."codec1_out mo" {
+	index"1"
+	type"mixer"
+	no_pm "true"
+	event_type "1"
+	event_flags "15"
+	subseq "10"
+	data "codec1_out mo"
+	mixer [
+		"media0_in mi Switch"
+		"codec0_in mi Switch"
+		"dmic01_hifi_in mi Switch"
+	]
+}
+SectionWidget."codec1_out cpr 5" {
+	index"1"
+	type"pga"
+	no_pm "true"
+	event_type "4"
+	data "codec1_out cpr 5"
+}
+SectionWidget."codec1_out" {
+	index"1"
+	type"aif_out"
+	no_pm "true"
+}
+SectionWidget."codec0_in cpr 1" {
+	index"1"
+	type"mixer"
+	no_pm "true"
+	event_type "3"
+	event_flags "9"
+	data "codec0_in cpr 1"
+}
+SectionWidget."codec0_in mi" {
+	index"1"
+	type"pga"
+	no_pm "true"
+	event_type "4"
+	event_flags "9"
+	subseq "10"
+	data "codec0_in mi"
+}
+SectionWidget."codec0_in" {
+	index"1"
+	type"aif_in"
+	no_pm "true"
+}
+SectionWidget."dmic01_hifi_in cpr 3" {
+	index"1"
+	type"mixer"
+	no_pm "true"
+	event_type "3"
+	event_flags "9"
+	data "dmic01_hifi_in cpr 3"
+}
+SectionWidget."dmic01_hifi_in mi" {
+	index"1"
+	type"pga"
+	no_pm "true"
+	event_type "4"
+	event_flags "9"
+	subseq "10"
+	data "dmic01_hifi_in mi"
+}
+SectionWidget."dmic01_hifi" {
+	index"1"
+	type"aif_in"
+	no_pm "true"
+}
+SectionWidget."hdmi1_pt_out cpr 7" {
+	index"1"
+	type"mixer"
+	no_pm "true"
+	event_type "3"
+	event_flags "9"
+	data "hdmi1_pt_out cpr 7"
+}
+SectionWidget."hdmi1_pt_out cpr 8" {
+	index"1"
+	type"pga"
+	no_pm "true"
+	event_type "4"
+	data "hdmi1_pt_out cpr 8"
+}
+SectionWidget."iDisp1_out" {
+	index"1"
+	type"aif_out"
+	no_pm "true"
+}
+SectionWidget."hdmi2_pt_out cpr 9" {
+	index"1"
+	type"mixer"
+	no_pm "true"
+	event_type "3"
+	event_flags "9"
+	data "hdmi2_pt_out cpr 9"
+}
+SectionWidget."hdmi2_pt_out cpr 10" {
+	index"1"
+	type"pga"
+	no_pm "true"
+	event_type "4"
+	data "hdmi2_pt_out cpr 10"
+}
+SectionWidget."iDisp2_out" {
+	index"1"
+	type"aif_out"
+	no_pm "true"
+}
+SectionWidget."hdmi3_pt_out cpr 11" {
+	index"1"
+	type"mixer"
+	no_pm "true"
+	event_type "3"
+	event_flags "9"
+	data "hdmi3_pt_out cpr 11"
+}
+SectionWidget."hdmi3_pt_out cpr 12" {
+	index"1"
+	type"pga"
+	no_pm "true"
+	event_type "4"
+	data "hdmi3_pt_out cpr 12"
+}
+SectionGraph."Pipeline 1 Graph" {
+	index"1"
+	lines [
+		"media0_in mi, , media0_in cpr 0"
+		"media0_in cpr 0, , System Playback"
+		"media0_out mo, media0_in mi Switch, media0_in mi"
+		"media0_out mo, codec0_in mi Switch, codec0_in mi"
+		"media0_out mo, dmic01_hifi_in mi Switch, dmic01_hifi_in mi"
+		"media0_out cpr 6, , media0_out mo"
+		"System Capture, , media0_out cpr 6"
+		"codec0_out mo, media0_in mi Switch, media0_in mi"
+		"codec0_out mo, codec0_in mi Switch, codec0_in mi"
+		"codec0_out mo, dmic01_hifi_in mi Switch, dmic01_hifi_in mi"
+		"codec0_out cpr 4, , codec0_out mo"
+		"codec0_out, , codec0_out cpr 4"
+		"codec1_out mo, media0_in mi Switch, media0_in mi"
+		"codec1_out mo, codec0_in mi Switch, codec0_in mi"
+		"codec1_out mo, dmic01_hifi_in mi Switch, dmic01_hifi_in mi"
+		"codec1_out cpr 5, , codec1_out mo"
+		"codec1_out, , codec1_out cpr 5"
+		"codec0_in mi, , codec0_in cpr 1"
+		"codec0_in cpr 1, , codec0_in"
+		"dmic01_hifi_in mi, , dmic01_hifi_in cpr 3"
+		"dmic01_hifi_in cpr 3, , dmic01_hifi"
+		"hdmi1_pt_out cpr 8, , hdmi1_pt_out cpr 7"
+		"hdmi1_pt_out cpr 7, , HDMI1 Playback"
+		"iDisp1_out, , hdmi1_pt_out cpr 8"
+		"hdmi2_pt_out cpr 10, , hdmi2_pt_out cpr 9"
+		"hdmi2_pt_out cpr 9, , HDMI2 Playback"
+		"iDisp2_out, , hdmi2_pt_out cpr 10"
+		"hdmi3_pt_out cpr 12, , hdmi3_pt_out cpr 11"
+		"hdmi3_pt_out cpr 11, , HDMI3 Playback"
+		"iDisp1_out, , hdmi3_pt_out cpr 12"
+	]
+}
+
-- 
1.9.1
