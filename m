From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] conf/ucm: broadwell-rt286: change to set
	capture volume and capture device
Date: Fri,  8 May 2015 15:18:47 +0800
Message-ID: <1431069527-9336-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F650260573
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 09:15:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Set 'Mic Capture Volume' in capture device EnableSequence, to fix
capture no volume by default issue.

Also add JackHWMute Value item to mute onboard dmic while headset
mic is plugged in.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 src/conf/ucm/broadwell-rt286/HiFi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/conf/ucm/broadwell-rt286/HiFi b/src/conf/ucm/broadwell-rt286/HiFi
index 58983ea..c09a01c 100644
--- a/src/conf/ucm/broadwell-rt286/HiFi
+++ b/src/conf/ucm/broadwell-rt286/HiFi
@@ -86,6 +86,7 @@ SectionDevice."Handset" {
 	EnableSequence [
 		cdev "hw:broadwellrt286"
 
+		cset "name='Mic Capture Volume' 28"
 		cset "name='ADC 0 Mux' 0"
 		cset "name='ADC0 Capture Switch' on"
 		cset "name='ADC0 Capture Volume' 127"
@@ -99,6 +100,9 @@ SectionDevice."Handset" {
 
 	Value {
 		CaptureChannels "2"
+		JackDev "rt286-jack"
+		JackControl "Mic Jack"
+		JackHWMute "Mainmic"
 	}
 }
 
@@ -112,6 +116,7 @@ SectionDevice."Mainmic" {
 	EnableSequence [
 		cdev "hw:broadwellrt286"
 
+		cset "name='Mic Capture Volume' 30"
 		cset "name='ADC 0 Mux' 2"
 		cset "name='ADC0 Capture Switch' on"
 		cset "name='ADC0 Capture Volume' 127"
-- 
1.9.1
