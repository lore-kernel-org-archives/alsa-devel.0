From: mengdong.lin@linux.intel.com
Subject: [PATCH] ASoC: Drop invalid DMI fields when setting
	card long name from DMI info
Date: Wed, 28 Jun 2017 15:01:39 +0800
Message-ID: <20170628070139.18340-1-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id CCA5D266BC2
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 15:59:02 +0200 (CEST)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Sometimes DMI fields may be invalid and so can't give useful vendor,
product or board info, such as "Type2 - Board Manufacturer" or
"Type1 - TBD by OEM". Including such invalid DMI fileds may create silly
card long name. So this patch creates a black list of invalid strings.
And if a DMI field contains any string in this list, it will be excluded
from the card long name.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cfa9cf1476f2..419b788fd801 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -69,6 +69,20 @@ static int pmdown_time = 5000;
 module_param(pmdown_time, int, 0);
 MODULE_PARM_DESC(pmdown_time, "DAPM stream powerdown time (msecs)");
 
+/* If a DMI filed contain strings in this blacklist (e.g.
+ * "Type2 - Board Manufacturer" or  "Type1 - TBD by OEM"), it will be taken
+ * as invalid and dropped when setting the card long name from DMI info.
+ */
+static const char * const dmi_blacklist[] = {
+	"To be filled by OEM",
+	"TBD by OEM",
+	"Default String",
+	"Board Manufacturer",
+	"Board Vendor Name",
+	"Board Product Name",
+	NULL,	/* terminator */
+};
+
 /* returns the minimum number of bytes needed to represent
  * a particular given value */
 static int min_bytes_needed(unsigned long val)
@@ -1934,6 +1948,22 @@ static void cleanup_dmi_name(char *name)
 	name[j] = '\0';
 }
 
+/* Check if a DMI field is valid, i.e. not containing any string
+ * in the black list.
+ */
+static int is_dmi_valid(const char *field)
+{
+	int i = 0;
+
+	while (dmi_blacklist[i]) {
+		if (strstr(field, dmi_blacklist[i]))
+			return 0;
+		i++;
+	};
+
+	return 1;
+}
+
 /**
  * snd_soc_set_dmi_name() - Register DMI names to card
  * @card: The card to register DMI names
@@ -1976,17 +2006,18 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 
 	/* make up dmi long name as: vendor.product.version.board */
 	vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
-	if (!vendor) {
+	if (!vendor || !is_dmi_valid(vendor)) {
 		dev_warn(card->dev, "ASoC: no DMI vendor name!\n");
 		return 0;
 	}
 
+
 	snprintf(card->dmi_longname, sizeof(card->snd_card->longname),
 			 "%s", vendor);
 	cleanup_dmi_name(card->dmi_longname);
 
 	product = dmi_get_system_info(DMI_PRODUCT_NAME);
-	if (product) {
+	if (product && is_dmi_valid(product)) {
 		len = strlen(card->dmi_longname);
 		snprintf(card->dmi_longname + len,
 			 longname_buf_size - len,
@@ -2000,7 +2031,7 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 		 * name in the product version field
 		 */
 		product_version = dmi_get_system_info(DMI_PRODUCT_VERSION);
-		if (product_version) {
+		if (product_version && is_dmi_valid(product_version)) {
 			len = strlen(card->dmi_longname);
 			snprintf(card->dmi_longname + len,
 				 longname_buf_size - len,
@@ -2013,7 +2044,7 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 	}
 
 	board = dmi_get_system_info(DMI_BOARD_NAME);
-	if (board) {
+	if (board && is_dmi_valid(board)) {
 		len = strlen(card->dmi_longname);
 		snprintf(card->dmi_longname + len,
 			 longname_buf_size - len,
-- 
2.11.0
