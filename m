From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 2/2] ucm: Add command 'get _file' to get the
	config file name of the opened card
Date: Tue,  3 Jan 2017 13:13:15 +0800
Message-ID: <cbb6d5aab68a3e552e59c3deaf2c0abbbcd31716.1483286749.git.mengdong.lin@linux.intel.com>
References: <cover.1483286749.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id EB600266D2C
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 06:10:15 +0100 (CET)
In-Reply-To: <cover.1483286749.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

After opening a card, this command can show the name of the actually
loaded configuration file, either matches the card name or card long name.
So developers can check if there is a device-sepcific configuration file
available for a given card.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/use-case.h b/include/use-case.h
index 8911645..15036fb 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -230,7 +230,7 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  * Known identifiers:
  *   - NULL 		- return current card
  *   - _verb		- return current verb
- *
+ *   - _file		- return configuration file loaded for current card
  *   - [=]{NAME}[/[{modifier}|{/device}][/{verb}]]
  *                      - value identifier {NAME}
  *                      - Search starts at given modifier or device if any,
diff --git a/src/ucm/main.c b/src/ucm/main.c
index 38a5e81..2d33886 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -1528,6 +1528,20 @@ int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
                         goto __end;
                 }
 	        err = 0;
+	} else if (strcmp(identifier, "_file") == 0) {
+		/* get the conf file name of the opened card */
+		if ((uc_mgr->card_name == NULL)
+		    || (uc_mgr->conf_file_name[0] == '\0')) {
+			err = -ENOENT;
+			goto __end;
+		}
+		*value = strndup(uc_mgr->conf_file_name, MAX_FILE);
+		if (*value == NULL) {
+			err = -ENOMEM;
+			goto __end;
+		}
+		err = 0;
+
 	} else if (identifier[0] == '_') {
 		err = -ENOENT;
 		goto __end;
-- 
2.7.4
