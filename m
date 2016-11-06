From: mengdong.lin@linux.intel.com
Subject: [PATCH 01/13] topology: Use snd_config_get_bool to
	simplify boolean flag parsing
Date: Sun,  6 Nov 2016 13:11:04 +0800
Message-ID: <9b8b6816e96c655f4b9625be41b36eed91dd2464.1478407716.git.mengdong.lin@linux.intel.com>
References: <cover.1478407716.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AEDA265B04
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 06:09:34 +0100 (CET)
In-Reply-To: <cover.1478407716.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

The link flags in the text conf file are boolean, so this patch uses
snd_config_get_bool() to simplify the code.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 3f54e94..b7a2df7 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -400,13 +400,14 @@ static int tplg_parse_fe_dai(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
 static int parse_flag(snd_config_t *n, unsigned int mask_in,
 		      unsigned int *mask, unsigned int *flags)
 {
-	const char *val = NULL;
+	int ret;
 
-	if (snd_config_get_string(n, &val) < 0)
-		return -EINVAL;
+	ret = snd_config_get_bool(n);
+	if (ret < 0)
+		return ret;
 
 	*mask |= mask_in;
-	if (strcmp(val, "true") == 0)
+	if (ret)
 		*flags |= mask_in;
 	else
 		*flags &= ~mask_in;
-- 
2.7.4
