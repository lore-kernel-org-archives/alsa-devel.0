From: han.lu@intel.com
Subject: [PATCH 1/1] alsabat: fix a missing break in switch
Date: Sun, 12 Jun 2016 18:17:00 +0800
Message-ID: <1465726620-30679-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 771C92604EB
 for <alsa-devel@alsa-project.org>; Sun, 12 Jun 2016 05:00:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add the break line for OPT_ROUNDUPLATENCY case.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/bat.c b/bat/bat.c
index 72ab8b2..8645770 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -420,6 +420,7 @@ static void parse_arguments(struct bat *bat, int argc, char *argv[])
 			break;
 		case OPT_ROUNDTRIPLATENCY:
 			bat->roundtriplatency = true;
+			break;
 		case OPT_SNRTHD_DB:
 			get_snr_thd_db(bat, optarg);
 			break;
-- 
2.5.0
