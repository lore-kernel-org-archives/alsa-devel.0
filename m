From: han.lu@intel.com
Subject: [PATCH V4 2/4] BAT: Use colon instead of comma for
	separation
Date: Tue, 20 Oct 2015 16:45:46 +0800
Message-ID: <cfcb07b007fbe87ba0b33c8ff58fed4740fd1d89.1445330404.git.han.lu@intel.com>
References: <cover.1445330404.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BFAD4266283
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 10:48:38 +0200 (CEST)
In-Reply-To: <cover.1445330404.git.han.lu@intel.com>
In-Reply-To: <cover.1445330404.git.han.lu@intel.com>
References: <cover.1445330404.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@intel.com, bernard.gautier@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Use colon instead of comma to separate frequency parameters, for
in several locale comma may be handled as decimal point.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/bat.c b/bat/bat.c
index 4320e22..2320984 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -74,7 +74,7 @@ static void get_sine_frequencies(struct bat *bat, char *freq)
 {
 	char *tmp1;
 
-	tmp1 = strchr(freq, ',');
+	tmp1 = strchr(freq, ':');
 	if (tmp1 == NULL) {
 		bat->target_freq[1] = bat->target_freq[0] = atof(optarg);
 	} else {
-- 
1.9.1
