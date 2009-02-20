From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] speaker-test.c - add readability comments to
	speaker	channels
Date: Fri, 20 Feb 2009 21:05:33 +0800
Message-ID: <20090220130533.GA8812@localhost>
References: <20090211072227.760779741@intel.com>
	<20090211223241.GA31322@csy.ca> <s5hfxik8ukn.wl%tiwai@suse.de>
	<20090212012504.GA6387@localhost> <s5hhc30m6oa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 688C5103807
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 14:05:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhc30m6oa.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 speaker-test/speaker-test.c |   72 +++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 36 deletions(-)

--- alsa-utils.orig/speaker-test/speaker-test.c
+++ alsa-utils/speaker-test/speaker-test.c
@@ -85,48 +85,48 @@ static const char *given_test_wav_file =
 static char *wav_file_dir = SOUNDSDIR;
 
 static const char *const channel_name[MAX_CHANNELS] = {
-  N_("Front Left"),
-  N_("Front Right"),
-  N_("Rear Left"),
-  N_("Rear Right"),
-  N_("Center"),
-  N_("LFE"),
-  N_("Side Left"),
-  N_("Side Right"),
-  N_("Channel 9"),
-  N_("Channel 10"),
-  N_("Channel 11"),
-  N_("Channel 12"),
-  N_("Channel 13"),
-  N_("Channel 14"),
-  N_("Channel 15"),
-  N_("Channel 16")
+  /*  0 */ N_("Front Left"),
+  /*  1 */ N_("Front Right"),
+  /*  2 */ N_("Rear Left"),
+  /*  3 */ N_("Rear Right"),
+  /*  4 */ N_("Center"),
+  /*  5 */ N_("LFE"),
+  /*  6 */ N_("Side Left"),
+  /*  7 */ N_("Side Right"),
+  /*  8 */ N_("Channel 9"),
+  /*  9 */ N_("Channel 10"),
+  /* 10 */ N_("Channel 11"),
+  /* 11 */ N_("Channel 12"),
+  /* 12 */ N_("Channel 13"),
+  /* 13 */ N_("Channel 14"),
+  /* 14 */ N_("Channel 15"),
+  /* 15 */ N_("Channel 16")
 };
 
 static const int	channels4[] = {
-  0,
-  1,
-  3,
-  2
+  0, /* Front Left  */
+  1, /* Front Right */
+  3, /* Rear Right  */
+  2, /* Rear Left   */
 };
 static const int	channels6[] = {
-  0,
-  4,
-  1,
-  3,
-  2,
-  5
-}; 
+  0, /* Front Left  */
+  4, /* Center      */
+  1, /* Front Right */
+  3, /* Rear Right  */
+  2, /* Rear Left   */
+  5, /* LFE         */
+};
 static const int	channels8[] = {
-  0,
-  4,
-  1,
-  7,
-  3,
-  2,
-  6,
-  5
-}; 
+  0, /* Front Left  */
+  4, /* Center      */
+  1, /* Front Right */
+  7, /* Side Right  */
+  3, /* Rear Right  */
+  2, /* Rear Left   */
+  6, /* Side Left   */
+  5, /* LFE         */
+};
 
 static void generate_sine(uint8_t *frames, int channel, int count, double *_phase) {
   double phase = *_phase;
