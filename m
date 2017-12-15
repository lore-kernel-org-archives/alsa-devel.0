From: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Subject: [PATCH 15/27] ALSA: hda - Use timecounter_initialize
	interface
Date: Fri, 15 Dec 2017 13:08:30 +0530
Message-ID: <1513323522-15021-16-git-send-email-sagar.a.kamble@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D224B267B42
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 08:35:51 +0100 (CET)
In-Reply-To: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Richard Cochran <richardcochran@gmail.com>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Sagar Arun Kamble <sagar.a.kamble@intel.com>
List-Id: alsa-devel@alsa-project.org

With new interface timecounter_initialize we can initialize timecounter
fields and underlying cyclecounter together. Update azx timecounter
init with this new function.

Signed-off-by: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/hda/hdac_stream.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 9426c1a..ad91dde 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -477,12 +477,8 @@ static void azx_timecounter_init(struct hdac_stream *azx_dev,
 				 bool force, u64 last)
 {
 	struct timecounter *tc = &azx_dev->tc;
-	struct cyclecounter *cc = &azx_dev->tc.cc;
 	u64 nsec;
 
-	cc->read = azx_cc_read;
-	cc->mask = CLOCKSOURCE_MASK(32);
-
 	/*
 	 * Converting from 24 MHz to ns means applying a 125/3 factor.
 	 * To avoid any saturation issues in intermediate operations,
@@ -493,11 +489,13 @@ static void azx_timecounter_init(struct hdac_stream *azx_dev,
 	 * overflows occur after about 4 hours or less, not a option.
 	 */
 
-	cc->mult = 125; /* saturation after 195 years */
-	cc->shift = 0;
-
 	nsec = 0; /* audio time is elapsed time since trigger */
-	timecounter_init(tc, nsec);
+	timecounter_initialize(tc,
+			       azx_cc_read,
+			       CLOCKSOURCE_MASK(32),
+			       125, /* saturation after 195 years */
+			       0,
+			       nsec);
 	if (force) {
 		/*
 		 * force timecounter to use predefined value,
-- 
1.9.1
