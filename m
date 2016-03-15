From: han.lu@intel.com
Subject: [PATCH 3/3] alsabat: add bash test script
Date: Tue, 15 Mar 2016 11:18:54 +0800
Message-ID: <f6b3cd38ecf81180145983db2d0acde31f80a347.1458011641.git.han.lu@intel.com>
References: <cover.1458011641.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A6892605CA
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 04:17:14 +0100 (CET)
In-Reply-To: <cover.1458011641.git.han.lu@intel.com>
In-Reply-To: <cover.1458011641.git.han.lu@intel.com>
References: <cover.1458011641.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, bernard.gautier@intel.com, edward.c.popescu@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add bash script for alsabat feature test. It covers basic alsabat
features, including waveform and wav file generate, playback,
capture and analysis with configurable parameters under different
work modes. (loopback, single line, standalone and local mode)
Usage examples:
        alsabat-test.sh
        alsabat-test.sh plughw:1,0
        alsabat-test.sh plughw:1,0 plughw:1,0

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/Makefile.am b/bat/Makefile.am
index 5646e9a..712f5bf 100644
--- a/bat/Makefile.am
+++ b/bat/Makefile.am
@@ -1,7 +1,7 @@
 bin_PROGRAMS = alsabat
 man_MANS = alsabat.1
-
-EXTRA_DIST = alsabat.1
+EXTRA_DIST = alsabat.1 alsabat-test.sh
+sbin_SCRIPTS = alsabat-test.sh
 
 alsabat_SOURCES = \
 	bat.c \
diff --git a/bat/alsabat-test.sh b/bat/alsabat-test.sh
new file mode 100755
index 0000000..2d31a77
--- /dev/null
+++ b/bat/alsabat-test.sh
@@ -0,0 +1,112 @@
+#!/bin/bash
+
+# default devices
+dev_playback="default"
+dev_capture="default"
+
+bin="alsabat"
+commands="$bin -P $dev_playback -C $dev_capture"
+
+file_sin_mono="default_mono.wav"
+file_sin_dual="default_dual.wav"
+logdir="tmp"
+
+# frequency range of signal
+maxfreq=16547
+minfreq=17
+
+# features passes vs. features all
+feature_pass=0
+feature_cnt=0
+
+init_counter () {
+	feature_pass=0
+	feature_all=0
+}
+
+evaluate_result () {
+	feature_cnt=$((feature_cnt+1))
+	if [ $1 -eq 0 ]; then
+		feature_pass=$((feature_pass+1))
+		echo "pass"
+	else
+		echo "fail"
+	fi
+}
+
+print_result () {
+	echo "[$feature_pass/$feature_cnt] features passes."
+}
+
+feature_test () {
+	echo "============================================"
+	echo "$feature_cnt: ALSA $2"
+	echo "-------------------------------------------"
+	echo "$commands $1 --log=$logdir/$feature_cnt.log"
+	$commands $1 --log=$logdir/$feature_cnt.log
+	evaluate_result $?
+	echo "$commands $1" >> $logdir/$((feature_cnt-1)).log
+}
+
+# test items
+feature_list_test () {
+	init_counter
+
+	commands="$bin"
+	feature_test "-c1 --saveplay $file_sin_mono" \
+			"generate mono wav file with default params"
+	feature_test "-c2 --saveplay $file_sin_dual" \
+			"generate dual wav file with default params"
+	sleep 5
+	feature_test "-P $dev_playback" "single line mode, playback"
+	feature_test "-C $dev_capture --standalone" "single line mode, capture"
+
+	commands="$bin -P $dev_playback -C $dev_capture"
+	feature_test "--file $file_sin_mono" "play mono wav file and detect"
+	feature_test "--file $file_sin_dual" "play dual wav file and detect"
+	feature_test "-c1" "configurable channel number: 1"
+	feature_test "-c2 -F $minfreq:$maxfreq" "configurable channel number: 2"
+	feature_test "-r44100" "configurable sample rate: 44100"
+	feature_test "-r48000" "configurable sample rate: 48000"
+	feature_test "-n10000" "configurable duration: in samples"
+	feature_test "-n2.5s" "configurable duration: in seconds"
+	feature_test "-f U8" "configurable data format: U8"
+	feature_test "-f S16_LE" "configurable data format: S16_LE"
+	feature_test "-f S24_3LE" "configurable data format: S24_3LE"
+	feature_test "-f S32_LE" "configurable data format: S32_LE"
+	feature_test "-f cd" "configurable data format: cd"
+	feature_test "-f dat" "configurable data format: dat"
+	feature_test "-F $maxfreq --standalone" \
+			"standalone mode: play and capture"
+	latestfile=`ls -t1 /tmp/bat.wav.* | head -n 1`
+	feature_test "--local -F $maxfreq --file $latestfile" \
+			"local mode: analyze local file"
+
+	print_result
+}
+
+echo "*******************************************"
+echo "                BAT Test                   "
+echo "-------------------------------------------"
+
+# get device
+echo "usage:"
+echo "  $0 <sound card>"
+echo "  $0 <device-playback> <device-capture>"
+
+if [ $# -eq 2 ]; then
+	dev_playback=$1
+	dev_capture=$2
+elif [ $# -eq 1 ]; then
+	dev_playback=$1
+	dev_capture=$1
+fi
+
+echo "current setting:"
+echo "  $0 $dev_playback $dev_capture"
+
+# run
+mkdir -p $logdir
+feature_list_test
+
+echo "*******************************************"
-- 
2.5.0
