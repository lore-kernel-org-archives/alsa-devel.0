From: mengdong.lin@linux.intel.com
Subject: [PATCH v4 2/2] ucm: Add command 'get _file' to get the
	config file name of the opened card
Date: Sat, 14 Jan 2017 16:24:01 +0800
Message-ID: <214d83794100e1b132bed219d34ec68454d23b56.1484381554.git.mengdong.lin@linux.intel.com>
References: <cover.1484381554.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B6EAC2666FB
 for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2017 09:20:48 +0100 (CET)
In-Reply-To: <cover.1484381554.git.mengdong.lin@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

After opening a card, this command can show the name of the actually
loaded configuration file, either matches the card name or card long name.
So developers can check if there is a device-sepcific configuration file
available for a given card.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/use-case.h b/include/use-case.h
index 8911645..ae22bde 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -230,6 +230,7 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  * Known identifiers:
  *   - NULL 		- return current card
  *   - _verb		- return current verb
+ *   - _file		- return configuration file loaded for current card
  *
  *   - [=]{NAME}[/[{modifier}|{/device}][/{verb}]]
  *                      - value identifier {NAME}
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
