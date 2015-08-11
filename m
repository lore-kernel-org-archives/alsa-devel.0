From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v3 1/3] core: add convenience macros to local.h
Date: Tue, 11 Aug 2015 18:23:15 +0100
Message-ID: <1439313797-6169-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1439313797-6169-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C78826057B
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 19:27:13 +0200 (CEST)
In-Reply-To: <1439313797-6169-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Move ARRAY_SIZE() from tplg_local.h to local.h and add container_of()
macro to local.h. Both macros are generic but are initially used by
topology.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/local.h           | 7 +++++++
 src/topology/tplg_local.h | 1 -
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/local.h b/include/local.h
index 6600816..b429f5d 100644
--- a/include/local.h
+++ b/include/local.h
@@ -350,4 +350,11 @@ int snd_config_search_alias_hooks(snd_config_t *config,
 
 int _snd_conf_generic_id(const char *id);
 
+/* convenience macros */
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
+
+#define container_of(ptr, type, member) ({                      \
+	 const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
+	(type *)( (char *)__mptr - offsetof(type,member) );})
+
 #endif
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index febc177..3982cc7 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -32,7 +32,6 @@
 #define MAX_FILE		256
 #define TPLG_MAX_PRIV_SIZE	(1024 * 128)
 #define ALSA_TPLG_DIR	ALSA_CONFIG_DIR "/topology"
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
 
 /** The name of the environment variable containing the tplg directory */
 #define ALSA_CONFIG_TPLG_VAR "ALSA_CONFIG_TPLG"
-- 
2.1.4
