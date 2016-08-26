From: keqiao.zhang@intel.com
Subject: [PATCH 2/2] alsabat: add system power management S3
	test
Date: Fri, 26 Aug 2016 23:37:55 +0800
Message-ID: <1472225875-18081-3-git-send-email-keqiao.zhang@intel.com>
References: <1472225875-18081-1-git-send-email-keqiao.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A985F26621A
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 09:59:11 +0200 (CEST)
In-Reply-To: <1472225875-18081-1-git-send-email-keqiao.zhang@intel.com>
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
Cc: keqiao.zhang@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Keqiao, Zhang" <keqiao.zhang@intel.com>

Support audio pause/resume for playback and capture. The user can
pause alsabat playback/capture threads by sending a signal. The patch
provides a method for QA to quick test audio during system s3.

Signed-off-by: Keqiao, Zhang <keqiao.zhang@intel.com>
---
 bat/alsabat-test.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/bat/alsabat-test.sh b/bat/alsabat-test.sh
index aa0281b..bc3d512 100755
--- a/bat/alsabat-test.sh
+++ b/bat/alsabat-test.sh
@@ -15,6 +15,10 @@ logdir="tmp"
 maxfreq=16547
 minfreq=17
 
+# sleep time and pause time
+sleep_time=5
+pause_time=2
+
 # features passes vs. features all
 feature_pass=0
 feature_cnt=0
@@ -48,6 +52,35 @@ feature_test () {
 	echo "$commands $1" >> $logdir/$((feature_cnt-1)).log
 }
 
+feature_test_power () {
+	echo "============================================"
+	echo "$feature_cnt: ALSA $2"
+	echo "-------------------------------------------"
+	echo "$commands $1 --log=$logdir/$feature_cnt.log"
+
+	# run alsabat in the background
+	nohup $commands $1 > $logdir/$feature_cnt.log 2>&1 &
+	sleep $pause_time
+	pid=`ps -aux |grep alsabat|head -1 |awk -F ' ' '{print $2}'`
+
+	# stop the alsabat thread
+	kill -STOP $pid > /dev/null
+	sleep 4
+
+	# do system S3
+	rtcwake -m mem -s $sleep_time
+	sleep $pause_time
+
+	# resume the alasbat thread to run
+	kill -CONT $pid > /dev/null
+
+	# wait for alsabat to complete the analysis
+	sleep $pause_time
+	cat $logdir/$feature_cnt.log |grep -i "Return value is 0" > /dev/null
+	evaluate_result $?
+	echo "$commands $1" >> $logdir/$((feature_cnt-1)).log
+}
+
 # test items
 feature_list_test () {
 	init_counter
@@ -87,6 +120,7 @@ feature_list_test () {
 			"noise detect threshold in SNR(dB)"
 	feature_test "--snr-pc 5" \
 			"noise detect threshold in noise percentage(%)"
+	feature_test_power "-n5s" "power management: S3 test"
 
 	print_result
 }
-- 
2.5.0
