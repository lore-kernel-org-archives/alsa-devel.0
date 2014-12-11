From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 3/4] sound: oss: Remove dead sound card number
	definitions
Date: Thu, 11 Dec 2014 14:19:12 +0200
Message-ID: <1418300353-13243-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1418300353-13243-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D500A26500C
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 13:19:23 +0100 (CET)
In-Reply-To: <1418300353-13243-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

None of these is used in kernel tree.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/oss/dev_table.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/oss/dev_table.h b/sound/oss/dev_table.h
index 0199a317c5a9..afb3aaff145f 100644
--- a/sound/oss/dev_table.h
+++ b/sound/oss/dev_table.h
@@ -21,20 +21,7 @@
  * Numbers 1000 to N are reserved for driver's internal use.
  */
 
-#define SNDCARD_DESKPROXL		27	/* Compaq Deskpro XL */
-#define SNDCARD_VIDC			28	/* ARMs VIDC */
-#define SNDCARD_SBPNP			29
-#define SNDCARD_SOFTOSS			36
 #define SNDCARD_VMIDI			37
-#define SNDCARD_OPL3SA1			38	/* Note: clash in msnd.h */
-#define SNDCARD_OPL3SA1_SB		39
-#define SNDCARD_OPL3SA1_MPU		40
-#define SNDCARD_WAVEFRONT               41
-#define SNDCARD_OPL3SA2                 42
-#define SNDCARD_OPL3SA2_MPU             43
-#define SNDCARD_WAVEARTIST              44	/* Waveartist */
-#define SNDCARD_OPL3SA2_MSS             45	/* Originally missed */
-#define SNDCARD_AD1816                  88
 
 /*
  *	NOTE! 	NOTE!	NOTE!	NOTE!
-- 
2.1.3
