From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] UCM: bytcr/PlatformEnableSeq.conf update some
	comments
Date: Sun,  3 Feb 2019 12:37:41 +0100
Message-ID: <20190203113741.15203-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E542267463
 for <alsa-devel@alsa-project.org>; Sun,  3 Feb 2019 12:37:47 +0100 (CET)
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
Cc: Hans de Goede <hdegoede@redhat.com>, Russell Parker <russell.parker7@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit f91cc3c7d6b7 ("Update chtrt5645 ucm variants to use
bytcr/PlatformEnableSeq.conf component") updated the
following 2 comments:

 # codec0_out settings (used if SSP2 is connected to aif1)
 # modem_out settings (used if SSP0 is connected to aif2)

Specifically it added the " to aif1" resp. " to aif2" part of the comments.

This is not correct, AIF1 / AIF2 are something which is present on
Realtek codecs only, and either one can be used indepedent of
SSP0 or SSP2 being used (the comments in the chtrt5645 UCM profile
before this change were wrong / outdated).

Besides there not being any relationship between SSP0 or SSP2 being
used, bytcr/PlatformEnableSeq.conf is also used with other codecs,
e.g. the ESS8316 codec where this is not applicable at all.

Therefor this commit removes the " to aif?" part of the comments again
to avoid confusing people reading this in the future.

Cc: Russell Parker <russell.parker7@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/platforms/bytcr/PlatformEnableSeq.conf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/conf/ucm/platforms/bytcr/PlatformEnableSeq.conf b/src/conf/ucm/platforms/bytcr/PlatformEnableSeq.conf
index 6f5e899c..b5ee2b41 100644
--- a/src/conf/ucm/platforms/bytcr/PlatformEnableSeq.conf
+++ b/src/conf/ucm/platforms/bytcr/PlatformEnableSeq.conf
@@ -29,7 +29,7 @@ cset "name='pcm0_in Gain 0 Volume' 0"
 cset "name='pcm1_in Gain 0 Switch' off"
 cset "name='pcm1_in Gain 0 Volume' 0%"
 
-# codec0_out settings (used if SSP2 is connected to aif1)
+# codec0_out settings (used if SSP2 is connected)
 cset "name='codec_out0 mix 0 codec_in0 Switch' off"
 cset "name='codec_out0 mix 0 codec_in1 Switch' off"
 cset "name='codec_out0 mix 0 media_loop1_in Switch' off"
@@ -40,7 +40,7 @@ cset "name='codec_out0 mix 0 sprot_loop_in Switch' off"
 cset "name='codec_out0 Gain 0 Switch' on"
 cset "name='codec_out0 Gain 0 Volume' 0"
 
-# modem_out settings (used if SSP0 is connected to aif2)
+# modem_out settings (used if SSP0 is connected)
 cset "name='modem_out mix 0 codec_in0 Switch' off"
 cset "name='modem_out mix 0 codec_in1 Switch' off"
 cset "name='modem_out mix 0 media_loop1_in Switch' off"
-- 
2.20.1
