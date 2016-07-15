From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 5/5] topology: Tuple type can have an
	extenstion
Date: Fri, 15 Jul 2016 20:19:58 +0800
Message-ID: <f5df6d9c05581807cc80c4446c5ea8fcc0238657.1468583255.git.mengdong.lin@linux.intel.com>
References: <cover.1468583255.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 289972668B8
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 14:15:00 +0200 (CEST)
In-Reply-To: <cover.1468583255.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, o-takashi@sakamocchi.jp, liam.r.girdwood@intel.com, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

After the type specific string ("uuid", "string", "byte", "short" and
"word"), users may append a string, like  "uuidxxx". The topology parser
will check the first few characters to get the tuple type.

This can allow users to put multiple tuples of the same type into one
vendor tuple section (SectionVendorTuples), e.g. parameters of multiple
firmware modules.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 644e548..0675b52 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -302,6 +302,29 @@ extern "C" {
  *	}
  * }
  * </pre>
+ * To define multiple vendor tuples of same type, please append some
+ * characters after the type string ("string", "uuid", "bool", "byte", "short"
+ * or "word"), to avoid ID duplication in the SectionVendorTuples.<br>
+ * The parser will check the first few characters in ID to get the tuple type.
+ * Here is an example:
+ * <pre>
+ * SectionVendorTuples."id of the vendor tuples" {
+ *    ...
+ *	tuples."word.module0" {
+ *		VENDOR_TOKEN_PARAM_ID1 "0x00112233"
+ *		VENDOR_TOKEN_PARAM_ID2 "0x44556677"
+ *		...
+ *	}
+ *
+ *	tuples."word.module2" {
+ *		VENDOR_TOKEN_PARAM_ID1 "0x11223344"
+ *		VENDOR_TOKEN_PARAM_ID2 "0x55667788"
+ *		...
+ *	}
+ *	...
+ * }
+ *
+ * </pre>
  *
  * <h5>Mixer Controls</h5>
  * A mixer control is defined as a new section that can include channel mapping,
diff --git a/src/topology/data.c b/src/topology/data.c
index 245a834..e81b7f1 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -534,17 +534,17 @@ static int parse_tuple_set(snd_config_t *cfg,
 
 	snd_config_get_id(cfg, &id);
 
-	if (strcmp(id, "uuid") == 0)
+	if (strncmp(id, "uuid", 4) == 0)
 		type = SND_SOC_TPLG_TUPLE_TYPE_UUID;
-	else if (strcmp(id, "string") == 0)
+	else if (strncmp(id, "string", 5) == 0)
 		type = SND_SOC_TPLG_TUPLE_TYPE_STRING;
-	else if (strcmp(id, "bool") == 0)
+	else if (strncmp(id, "bool", 4) == 0)
 		type = SND_SOC_TPLG_TUPLE_TYPE_BOOL;
-	else if (strcmp(id, "byte") == 0)
+	else if (strncmp(id, "byte", 4) == 0)
 		type = SND_SOC_TPLG_TUPLE_TYPE_BYTE;
-	else if (strcmp(id, "short") == 0)
+	else if (strncmp(id, "short", 5) == 0)
 		type = SND_SOC_TPLG_TUPLE_TYPE_SHORT;
-	else if (strcmp(id, "word") == 0)
+	else if (strncmp(id, "word", 4) == 0)
 		type = SND_SOC_TPLG_TUPLE_TYPE_WORD;
 	else {
 		SNDERR("error: invalid tuple type '%s'\n", id);
-- 
2.5.0
