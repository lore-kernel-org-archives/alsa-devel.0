From: mengdong.lin@linux.intel.com
Subject: [PATCH] topology: Update physical link configurations
	in Broadwell text conf file
Date: Fri, 25 Nov 2016 13:20:02 +0800
Message-ID: <1480051202-32198-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B1CE226581B
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2016 06:18:02 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

To make this conf file a better example, add configurations for the
physical link "Codec", same as that defined by Intel Broadwell upstream
machine driver.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/conf/topology/broadwell/broadwell.conf b/src/conf/topology/broadwell/broadwell.conf
index eb89377..b8405d9 100644
--- a/src/conf/topology/broadwell/broadwell.conf
+++ b/src/conf/topology/broadwell/broadwell.conf
@@ -389,3 +389,22 @@ SectionGraph."dsp" {
 		"Analog Capture, , SSP0 CODEC IN"
 	]
 }
+
+SectionHWConfig."CodecHWConfig" {
+	id "1"
+	format "I2S"		# physical audio format.
+	bclk   "master"		# Platform is master of bit clock
+	fsync  "master"		# platform is master of fsync
+}
+
+SectionLink."Codec" {
+
+	# used for binding to the physical link
+	id "0"
+
+	hw_configs [
+		"CodecHWConfig"
+	]
+
+	default_hw_conf_id "1"
+}
-- 
2.5.0
