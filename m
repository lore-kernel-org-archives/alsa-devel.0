From: han.lu@intel.com
Subject: [PATCH 08/10] alsabat: fix an incorrect print
Date: Wed,  2 Mar 2016 16:53:18 +0800
Message-ID: <88b74bc19aeae8e09854a0f84ffea820e638ee51.1456907242.git.han.lu@intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BAB5626517F
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 09:51:17 +0100 (CET)
In-Reply-To: <cover.1456907242.git.han.lu@intel.com>
In-Reply-To: <cover.1456907242.git.han.lu@intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
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

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 443ede8..0a5f899 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -329,7 +329,7 @@ void *playback_alsa(struct bat *bat)
 				bat->playback.file);
 		bat->fp = fopen(bat->playback.file, "rb");
 		if (bat->fp == NULL) {
-			fprintf(bat->err, _("Cannot open file for capture: "));
+			fprintf(bat->err, _("Cannot open file for playback: "));
 			fprintf(bat->err, _("%s %d\n"),
 					bat->playback.file, -errno);
 			retval_play = 1;
-- 
2.5.0
