From: mengdong.lin@linux.intel.com
Subject: [PATCH 3/5] topology: Change uuid value to 16 separate
	characters in text conf file
Date: Wed, 13 Jul 2016 16:44:54 +0800
Message-ID: <d3cf452fd17a9ae3b2346ad3a75c8f07e28124c4.1468397702.git.mengdong.lin@linux.intel.com>
References: <cover.1468397702.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id F18EF26656A
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 10:40:19 +0200 (CEST)
In-Reply-To: <cover.1468397702.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@intel.com, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Previously in text conf file, the uuid value of vendor tuples is a
16-characer string. Now change it to 16 characters separated by commas,
easier for users to edit it manually.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index d666505..89bed6c 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -273,8 +273,8 @@ extern "C" {
  *		...
  *	}
  *
- *	tuples."uuid" {
- *		VENDOR_TOKEN_ID2 "16 character uuid"
+ *	tuples."uuid" {			# 16 characters separated by commas
+ *		VENDOR_TOKEN_ID2 "0x01,0x02,...,0x0f"
  *		...
  *	}
  *
diff --git a/src/topology/data.c b/src/topology/data.c
index 7ff178f..65054d7 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -176,6 +176,49 @@ static int get_hex_num(const char *str)
 	return values;
 }
 
+/* get uuid from a string made by 16 characters separated by commas */
+static int get_uuid(const char *str, unsigned char *uuid_le)
+{
+	unsigned long int  val;
+	char *tmp, *s = NULL;
+	int values = 0, ret = 0;
+
+	tmp = strdup(str);
+	if (tmp == NULL)
+		return -ENOMEM;
+
+	s = strtok(tmp, ",");
+
+	while (s != NULL) {
+		errno = 0;
+		val = strtoul(s, NULL, 0);
+		if ((errno == ERANGE && (val == LONG_MAX || val == LONG_MIN))
+			|| (errno != 0 && val == 0)
+			|| (val > UCHAR_MAX)) {
+			SNDERR("error: invalid value for uuid\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		 *(uuid_le + values) = (unsigned char)val;
+
+		values++;
+		if (values >= 16)
+			break;
+
+		s = strtok(NULL, ",");
+	}
+
+	if (values < 16) {
+		SNDERR("error: less than 16 integers for uuid\n");
+		ret = -EINVAL;
+	}
+
+out:
+	free(tmp);
+	return ret;
+}
+
 static int write_hex(char *buf, char *str, int width)
 {
 	long val;
@@ -536,14 +579,8 @@ static int parse_tuple_set(snd_tplg_t *tplg, snd_config_t *cfg,
 
 		switch (type) {
 		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
-			len = strlen(value);
-			if (len > 16 || len == 0) {
-				SNDERR("error: tuple %s: invalid uuid\n", id);
+			if (get_uuid(value, tuple->uuid) < 0)
 				goto err;
-			}
-
-			memcpy(tuple->uuid, value, len);
-			tplg_dbg("\t\t%s = %s\n", tuple->token, tuple->uuid);
 			break;
 
 		case SND_SOC_TPLG_TUPLE_TYPE_STRING:
-- 
2.5.0
