From: mengdong.lin@linux.intel.com
Subject: [PATCH v5 1/3] ucm: Assure the user input card name
	not to exceed max size of card long name
Date: Mon, 16 Jan 2017 18:44:08 +0800
Message-ID: <d8494768e045903098472b9ccf7de215eb88fe21.1484562657.git.mengdong.lin@linux.intel.com>
References: <cover.1484562657.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 95D27266FCC
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 11:40:52 +0100 (CET)
In-Reply-To: <cover.1484562657.git.mengdong.lin@linux.intel.com>
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

Users can load a card's UCM configuration file by giving the card short
name or long name, which should not exceed the maximum card long name
defined by the kernel. The kernel uses an 80-character buffer to store
the card long name.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index c98373a..3b42e31 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -1334,6 +1334,12 @@ static int load_master_config(const char *card_name, snd_config_t **cfg)
 	char *env = getenv(ALSA_CONFIG_UCM_VAR);
 	int err;
 
+	if (strnlen(card_name, MAX_CARD_LONG_NAME) == MAX_CARD_LONG_NAME) {
+		uc_error("error: invalid card name %s (at most %d chars)\n",
+			 card_name, MAX_CARD_LONG_NAME - 1);
+		return -EINVAL;
+	}
+
 	snprintf(filename, sizeof(filename)-1,
 		"%s/%s/%s.conf", env ? env : ALSA_USE_CASE_DIR,
 		card_name, card_name);
diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index 6d3302f..e41aafa 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -41,6 +41,7 @@
 #include "use-case.h"
 
 #define MAX_FILE		256
+#define MAX_CARD_LONG_NAME	80
 #define ALSA_USE_CASE_DIR	ALSA_CONFIG_DIR "/ucm"
 
 #define SEQUENCE_ELEMENT_TYPE_CDEV	1
-- 
2.7.4
