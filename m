From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] conf/ucm: broadwell-rt286: change to use the
	correct jack kcontrol name
Date: Tue, 28 Apr 2015 15:40:22 +0800
Message-ID: <1430206822-23359-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 796722602AD
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 09:36:56 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, tanu.kaskinen@linux.intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, bardliao@realtek.com, han.lu@intel.com
List-Id: alsa-devel@alsa-project.org

The headset jack has two kctls: "Headphone Jack" and "Mic Jack",
we need switch speaker output according to the former JackControl.
Here correct it.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 src/conf/ucm/broadwell-rt286/HiFi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/conf/ucm/broadwell-rt286/HiFi b/src/conf/ucm/broadwell-rt286/HiFi
index 08f5c50..58983ea 100644
--- a/src/conf/ucm/broadwell-rt286/HiFi
+++ b/src/conf/ucm/broadwell-rt286/HiFi
@@ -43,7 +43,7 @@ SectionDevice."Headphones" {
 	Value {
 		PlaybackChannels "2"
 		JackDev "rt286-jack"
-		JackControl "Headset Jack"
+		JackControl "Headphone Jack"
 		JackHWMute "Speaker"
 	}
 }
-- 
1.9.1
