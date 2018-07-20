From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 02/14] conf/ucm: bytcr-rt5651: Add support for
	boards using SSP0
Date: Fri, 20 Jul 2018 09:27:29 +0200
Message-ID: <20180720072741.4632-3-hdegoede@redhat.com>
References: <20180720072741.4632-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id C6CAA26770A
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 09:27:46 +0200 (CEST)
In-Reply-To: <20180720072741.4632-1-hdegoede@redhat.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add support for bytcr-rt5651 boards using SSP0.

This fixes sound not working on Bay Trail CR tablets with a rt5651 codec.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
index 069427b7..9efcafc0 100644
--- a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
+++ b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
@@ -34,7 +34,7 @@ SectionDefaults [
 	cset "name='pcm1_in Gain 0 Switch' off"
 	cset "name='pcm1_in Gain 0 Volume' 0%"
 
-	# codec0_out settings
+	# codec0_out settings used when SSP2 is connected
 	cset "name='codec_out0 mix 0 codec_in0 Switch' off"
 	cset "name='codec_out0 mix 0 codec_in1 Switch' off"
 	cset "name='codec_out0 mix 0 media_loop1_in Switch' off"
@@ -45,11 +45,30 @@ SectionDefaults [
 	cset "name='codec_out0 Gain 0 Switch' on"
 	cset "name='codec_out0 Gain 0 Volume' 0"
 
+	# modem_out settings used when SSP0 is connected
+	cset "name='modem_out mix 0 codec_in0 Switch' off"
+	cset "name='modem_out mix 0 codec_in1 Switch' off"
+	cset "name='modem_out mix 0 media_loop1_in Switch' off"
+	cset "name='modem_out mix 0 media_loop2_in Switch' off"
+	cset "name='modem_out mix 0 pcm0_in Switch' on"
+	cset "name='modem_out mix 0 pcm1_in Switch' off"
+	cset "name='modem_out mix 0 sprot_loop_in Switch' off"
+	cset "name='modem_out Gain 0 Switch' on"
+	cset "name='modem_out Gain 0 Volume' 0"
+
 	# input settings
 	# pcm1_out settings
+
+	# input used when SSP2 is connected
 	cset "name='codec_in0 Gain 0 Switch' on"
 	cset "name='codec_in0 Gain 0 Volume' 0"
+
+	# input used when SSP0 is connected
+	cset "name='modem_in Gain 0 Switch' on"
+	cset "name='modem_in Gain 0 Volume' 0"
+
 	cset "name='pcm1_out mix 0 codec_in0 Switch' on"
+	cset "name='pcm1_out mix 0 modem_in Switch' on"
 	cset "name='pcm1_out mix 0 codec_in1 Switch' off"
 	cset "name='pcm1_out mix 0 media_loop1_in Switch' off"
 	cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
-- 
2.17.1
